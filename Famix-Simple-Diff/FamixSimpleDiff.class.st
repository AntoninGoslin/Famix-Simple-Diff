Class {
	#name : 'FamixSimpleDiff',
	#superclass : 'Object',
	#instVars : [
		'roots',
		'childrenCache',
		'debug',
		'differences'
	],
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'comparing' }
FamixSimpleDiff >> compareEntity: aFamixEntity to: otherFamixEntity [

	| properties relations |
	aFamixEntity class = otherFamixEntity class ifFalse: [ ^ self fail ].

	"Comparing properties (slots with non-famix values)"
	properties := aFamixEntity class allSlots select: [ :slot |
		              slot class = FMProperty ].
	properties do: [ :p |
			(p read: aFamixEntity) = (p read: otherFamixEntity) ifFalse: [
				^ self fail ] ].

	"Comparing relations (slots with famix values)"
	"We exclude source anchors because they are not relevant to model comparison"
	relations := aFamixEntity class allSlots select: [ :slot |
		             slot isFMRelationSlot and: [ slot name ~= 'sourceAnchor' ] ].
	relations do: [ :r |
			(self compareRelation: r from: aFamixEntity to: otherFamixEntity)
				ifFalse: [ ^ self fail ] ].

	"Every slot value is equal, the entities are identical"
	^ true
]

{ #category : 'comparing' }
FamixSimpleDiff >> compareModel: aFamixJavaModel to: aFamixJavaModel2 [

	(self entityRoots: aFamixJavaModel) do: [ :root |
			| correspondingRoot |
			correspondingRoot := self
				                     correspondingEntityTo: root
				                     in: aFamixJavaModel2.
			(self recursiveCompareEntity: root with: correspondingRoot)
				ifFalse: [ ^ self fail ] ].

	^ true
]

{ #category : 'comparing' }
FamixSimpleDiff >> compareRelation: aFMRelationSlot from: aFamixEntity to: otherFamixEntity [

	| val1 val2 sortBlock |
	aFMRelationSlot isToOne
		ifTrue: [
				val1 := aFMRelationSlot read: aFamixEntity.
				val2 := aFMRelationSlot read: otherFamixEntity ]
		ifFalse: [
				| rejectBlock |
				val1 := (aFMRelationSlot read: aFamixEntity) asOrderedCollection.
				val2 := (aFMRelationSlot read: otherFamixEntity)
					        asOrderedCollection.

				sortBlock := val1
					             ifEmpty: [ self sortBlock ]
					             ifNotEmpty: [ self sortBlockFor: val1 anyOne ].

				rejectBlock := [ :e | e name = 'clone' ].

				val1 := val1 reject: rejectBlock.
				val2 := val2 reject: rejectBlock.

				val1 := val1 sorted: sortBlock.
				val2 := val2 sorted: sortBlock ].

	"Sometimes, parent relations are duplicated and are nil.
	This guards for that..."
	val1 == val2 ifTrue: [ ^ true ].

	aFMRelationSlot isToOne
		ifTrue: [ ^ (self pathesForMaybeMultiRelation: val1) = (self pathesForMaybeMultiRelation: val2) ]
		ifFalse: [ "This is a toMany Relation! and the value should be a collection"
				val1 size = val2 size ifFalse: [ ^ self fail ].
				val1 := val1
					        flatCollect: [ :e | self pathesForMaybeMultiRelation: e ]
					        as: Bag.
				val2 := val2
					        flatCollect: [ :e | self pathesForMaybeMultiRelation: e ]
					        as: Bag.

				val1 = val2
					ifFalse: [ ^ self fail ]
					ifTrue: [ ^ true ] ]
]

{ #category : 'path-computing' }
FamixSimpleDiff >> computePathOfEntity: anEntity [
	"We only work for single parent entities... And we hope this is the case always.
	If not, talk to Guille, he has a point.
	Read about lexical definition"

	self assert: anEntity containers asSet size <= 1.
	
	"If we have a container, we continue recursively"
	anEntity containers asSet do: [ :c |
			^ (self pathOfEntity: c) copyWith:
				  ((self sortedChildren: c) indexOf: anEntity) ].

	"We don't have a container, this is the root. Return the index of this entity in the root collection"
	^ { ((self entityRoots: anEntity mooseModel) indexOf: anEntity) }
]

{ #category : 'accessing' }
FamixSimpleDiff >> correspondingEntityTo: entity in: model [

	| path |
	path := self pathOfEntity: entity.
	^ self entityAtPath: path inModel: model
	
]

{ #category : 'debug' }
FamixSimpleDiff >> debugOn [

	debug := true
]

{ #category : 'accessing' }
FamixSimpleDiff >> differences [
	^ differences
]

{ #category : 'path-computing' }
FamixSimpleDiff >> entityAtPath: indexPath fromEntity: entity [

	indexPath ifEmpty: [ ^ entity ].

	^ self
		  entityAtPath: indexPath allButFirst
		  fromEntity: ((self sortedChildren: entity) at: indexPath first)
]

{ #category : 'path-computing' }
FamixSimpleDiff >> entityAtPath: indexPath inModel: model [

	| rootEntity |
	
	rootEntity := (self entityRoots: model) at: indexPath first.
	^ self entityAtPath: indexPath allButFirst fromEntity: rootEntity
]

{ #category : 'accessing' }
FamixSimpleDiff >> entityRoots: aFamixJavaModel [

	| goodSortBlock excludedClasses |
	excludedClasses := {
		                   FamixJavaWildcard.
		                   FamixJavaAnnotationInstance.
		                   FamixJavaAnnotationInstanceAttribute }.

	^ (roots ifNil: [ roots := Dictionary new ])
		  at: aFamixJavaModel
		  ifAbsentPut: [
				  | rootEntities |
				  rootEntities := aFamixJavaModel rootEntities reject: [ :entity |
						                  entity name = '<Default Package>' or: [
							                  excludedClasses includes: entity class ] ].
				  goodSortBlock := self sortBlockFor: rootEntities anyOne.
				  rootEntities sorted: goodSortBlock ]
]

{ #category : 'asserting' }
FamixSimpleDiff >> fail [

	debug ifTrue: [ self halt ].
	^ false
]

{ #category : 'initialization' }
FamixSimpleDiff >> initialize [
	
	super initialize.
	debug := false.
	childrenCache := LRUCache new maximumWeight: 100.
	differences := OrderedCollection new.
]

{ #category : 'path-computing' }
FamixSimpleDiff >> pathOfEntity: anEntity [

	^ anEntity
		  cacheAt: #path
		  ifAbsentPut: [ self computePathOfEntity: anEntity ]
]

{ #category : 'path-computing' }
FamixSimpleDiff >> pathesForMaybeMultiRelation: multiRelationTargetOrCollectionOrSmellingThing [

	| target targettedEntities |
	target := multiRelationTargetOrCollectionOrSmellingThing isAssociation
		          ifTrue: [ multiRelationTargetOrCollectionOrSmellingThing target ]
		          ifFalse: [ multiRelationTargetOrCollectionOrSmellingThing ].

	targettedEntities := target isCollection
		                     ifTrue: [ target ]
		                     ifFalse: [ { target } ].

	^ targettedEntities collect: [ :e |
		"Please e be an entity please please plz"
		  self pathOfEntity: e ]
]

{ #category : 'comparing' }
FamixSimpleDiff >> recursiveCompareEntity: entity1 with: entity2 [

	"Parametric entities and inner classes are not used in the comparison process, so we return true by default"
	entity1 mooseName = entity2 mooseName ifTrue: [
			(entity1 isParametricEntity and: [ entity2 isParametricEntity ])
				ifTrue: [ ^ true ].
			(entity1 isType and: [ entity1 isAnonymousClass ]) ifTrue: [
				^ true ] ].

	"Clone methods have an issue (potentially due to JDT) which isn't easy to fix, so we skip those."
	entity1 name = 'clone' ifTrue: [ ^ true ].

	(self compareEntity: entity1 to: entity2) ifFalse: [ ^ false ].

	(self sortedChildren: entity1)
		with: (self sortedChildren: entity2)
		do: [ :child1 :child2 |
			(self recursiveCompareEntity: child1 with: child2) ifFalse: [
				^ false ] ].

	^ true
]

{ #category : 'sorting' }
FamixSimpleDiff >> sortBlock [

	^ [ :a :b | a mooseName > b mooseName ]
]

{ #category : 'sorting' }
FamixSimpleDiff >> sortBlockFor: anEntity [

	^ anEntity hasUniqueMooseNameInModel
		  ifTrue: [ [ :a :b | a mooseName < b mooseName ] ]
		  ifFalse: [
				  [ :a :b |
					  | valA valB |
					  valA := String streamContents: [ :s | a printOn: s ].
					  valB := String streamContents: [ :s | b printOn: s ].
					  valA < valB ] ]
]

{ #category : 'sorting' }
FamixSimpleDiff >> sortedChildren: entity [

	| res |
	res := childrenCache at: entity ifAbsentPut: [
			       (entity containedEntities reject: [ :e |
				        e isStub or: [ e name = '<Initializer>' ] ]) sorted: [ :a :b |
					       | valA valB |
					       valA := String streamContents: [ :s | a printOn: s ].
					       valB := String streamContents: [ :s | b printOn: s ].
					       valA = valB
						       ifTrue: [
								       a sourceAnchor
									       ifNotNil: [
											       b sourceAnchor
												       ifNotNil: [ "case for two entities with identical printing string but different source anchor (several inner classes in the same parent for example)"
													       a sourceAnchor endPos < b sourceAnchor endPos ]
												       ifNil: [ valA < valB ] ]
									       ifNil: [ valA < valB] ]
						       ifFalse: [ valA < valB ] ] ].


	^ res
]
