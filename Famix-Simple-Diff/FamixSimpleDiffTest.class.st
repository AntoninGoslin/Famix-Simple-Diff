Class {
	#name : 'FamixSimpleDiffTest',
	#superclass : 'TestCase',
	#instVars : [
		'mainModel1',
		'mainModel2',
		'libraryModel'
	],
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'running' }
FamixSimpleDiffTest >> setUp [
	super setUp.

	"fix here to limit window's performances problems"
	self timeLimit: 15 seconds.
	"Put here a common initialization logic for tests"
	mainModel1 := TestJavaModelBuilder loadMainModel.
	mainModel2 := TestJavaModelBuilder loadMainModel.
	libraryModel := TestJavaModelBuilder loadLibraryModel 
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testClassesWithDifferentNamesAreNotEqual [

	| sd entity1 entity2 |
	sd := FamixSimpleDiff new.
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass'.
	entity2 := mainModel2 entityNamed: 'some.thing.whatever.MainClass'.
	entity2 name: 'NewName'. 
	
	self assert: (sd compareEntity: entity1 to: entity2) equals: false
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testClassesWithDifferentSuperclassesAreNotEqual [

	| sd entity1 entity2 newInheritance |
	sd := FamixSimpleDiff new.
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass'.
	entity2 := mainModel2 entityNamed: 'some.thing.whatever.MainClass'.
	
	newInheritance := mainModel2 newInheritance
		superclass: entity2;
		subclass: entity2.
	entity2 superInheritances: { newInheritance }. 
	
	self assert: (sd compareEntity: entity1 to: entity2) equals: false
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testCompareEntityToReturnsTrueAndEmptyDiffListWhenSameClasses [
	| sd class1 class2 |
	sd := FamixSimpleDiff new.
	
	"same classes"
	class1 := FamixJavaClass new name: 'MyClass'; 
	isStub: false.
	class2 := FamixJavaClass new name: 'MyClass'; 
	isStub: false.
	
	self assert: (sd compareEntity: class1 to: class2).
	self assert: sd differences isEmpty.
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testCorrespondingClassesAreEqual [

	| sd entity1 entity2 path |
	sd := FamixSimpleDiff new.
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass'.
	path := sd pathOfEntity: entity1.
	entity2 := sd entityAtPath: path inModel: mainModel2.
	
	self assert: (sd compareEntity: entity1 to: entity2)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testCorrespondingClassesInSameModelIsSameEntity [

	| sd entity1 entity2 path |
	sd := FamixSimpleDiff new.
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass'.
	path := sd pathOfEntity: entity1.
	entity2 := sd entityAtPath: path inModel: mainModel1.
	
	self assert: entity1 == entity2
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testCorrespondingMethodsAreEqual [

	| sd entity1 entity2 path |
	sd := FamixSimpleDiff new.
	
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass.getIntAttribute()'.
	path := sd pathOfEntity: entity1.
	entity2 := sd entityAtPath: path inModel: mainModel2.
	
	self assert: (sd compareEntity: entity1 to: entity2)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testCorrespondingMethodsInSameModelIsSameEntity [

	| sd entity1 entity2 path |
	sd := FamixSimpleDiff new.
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass.getIntAttribute()'.
	path := sd pathOfEntity: entity1.
	entity2 := sd entityAtPath: path inModel: mainModel1.
	
	self assert: entity1 == entity2
]

{ #category : 'as yet unclassified' }
FamixSimpleDiffTest >> testCorrespondingPrimitiveTypesAreEqual [

	| sd entity1 entity2 path |
	sd := FamixSimpleDiff new.

	entity1 := (mainModel1 entityNamed: 'some.thing.whatever.MainClass.getIntAttribute()') declaredType.
	path := sd pathOfEntity: entity1.
	entity2 := sd entityAtPath: path inModel: mainModel2.
	
	self assert: (sd compareEntity: entity1 to: entity2)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testEntityWithDifferentRelationsSizesAreNotEquals [

	| sd entity1 entity2 newMethod methodList |
	sd := FamixSimpleDiff new.
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass'.
	entity2 := mainModel2 entityNamed: 'some.thing.whatever.MainClass'.
	
	"adding a new method to set a difference between the two models"
	newMethod := FamixJavaMethod new name: 'newMethod()'.
	
	"adding the method in the current method list"
	methodList := entity2 methods asOrderedCollection.
	methodList add: newMethod.
	
	"changing the method list"
	entity2 methods: methodList.
	
	self deny: (sd compareEntity: entity1 to: entity2)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testEqualClassesAreEqual [

	| sd entity1 |
	sd := FamixSimpleDiff new.
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass'.
	
	self assert: (sd compareEntity: entity1 to: entity1)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testEqualMethodsAreEqual [

	| sd entity1 |
	sd := FamixSimpleDiff new.
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass.getIntAttribute()'.
	
	self assert: (sd compareEntity: entity1 to: entity1)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testEqualModelsAreEqual [

	| sd |
	sd := FamixSimpleDiff new.
	
	self assert: (sd compareModel: mainModel1 to: mainModel2)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testMethodsWithDifferentNamesAreNotEqual [

	| sd entity1 entity2 |
	sd := FamixSimpleDiff new.
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass.getIntAttribute()'.
	entity2 := mainModel2 entityNamed: 'some.thing.whatever.MainClass.getIntAttribute()'.
	entity2 name: 'NewName'. 
	
	self assert: (sd compareEntity: entity1 to: entity2) equals: false
]

{ #category : 'as yet unclassified' }
FamixSimpleDiffTest >> testNotEqualModelsAreNotEqual [

	| sd |
	sd := FamixSimpleDiff new.
	self deny: (sd compareModel: mainModel1 to: libraryModel)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testRecursiveCompareEntityReturnFalseOnDeepDifferentModels [

	| sd childMethod2 |
	sd := FamixSimpleDiff new.
	
	"modify a child"
	childMethod2 := mainModel2 entityNamed: 'some.thing.whatever.MainClass.getIntAttribute()'.
	childMethod2 name: 'getIntAttributeWithDifferentName'.
	
	"the models should not be equals"
	self deny: (sd compareModel: mainModel1 to: mainModel2)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testSameClassesAreEqual [

	| sd entity1 entity2 |
	sd := FamixSimpleDiff new.
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass'.
	entity2 := mainModel2 entityNamed: 'some.thing.whatever.MainClass'.
	
	self assert: (sd compareEntity: entity1 to: entity2)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testSameMethodsAreEqual [

	| sd entity1 entity2 |
	sd := FamixSimpleDiff new.
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass.getIntAttribute()'.
	entity2 := mainModel2 entityNamed: 'some.thing.whatever.MainClass.getIntAttribute()'.
	
	self assert: (sd compareEntity: entity1 to: entity2)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testSameModelsAreEqual [

	| sd |
	sd := FamixSimpleDiff new.
	
	self assert: (sd compareModel: mainModel1 to: mainModel1)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testSortBlockOrdersByName [

	| sd block entity1 entity2 |
	sd := FamixSimpleDiff new.
	
	block := sd sortBlock.
	
	entity1 := mainModel1 entityNamed: 'some.thing.whatever.MainClass'.
	entity2 := mainModel1 entityNamed: 'some.thing.whatever.MainClass.getIntAttribute()'.
	
	self assert: (block value: entity2 value: entity1).
	self deny: (block value: entity1 value: entity2)
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testSortedChildrenFiltersStubsAndInitializers [
	| sd parent normalMethod stubMethod initializeMethod res |
	sd := FamixSimpleDiff new.
	
	"init parent and stubs methods"
	parent := FamixJavaClass new name: 'ParentClass'.
	normalMethod := FamixJavaMethod new name: 'normalMethod'; 
	isStub: false.
	stubMethod  := FamixJavaMethod new name: 'stubMethod'; 
	isStub: true.
	initializeMethod := FamixJavaMethod new name: '<Initializer>';
	isStub: false.
	
	"testing the sort"
	parent methods: { normalMethod . stubMethod . initializeMethod }.
	res := sd sortedChildren: parent.
	
	"the filter keep just 1 method"
	self assert: res size equals: 1.
	self assert: res first equals: normalMethod .
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testSortedChildrenSortsAlphabeticallyWhenNotSameName [
	| sd parent aBeginMethod bBeginMethod res |
	sd := FamixSimpleDiff new.
	
	"init parent and child methods"
	parent := FamixJavaClass new name: 'ParentClass'.
	aBeginMethod := FamixJavaMethod new name: 'aBeginMethod'.
	bBeginMethod := FamixJavaMethod new name: 'bBeginMethod'.
	
	"testing the sort"
	parent methods: { bBeginMethod . aBeginMethod}.
	res := sd sortedChildren: parent. 
	self assert: res first equals: aBeginMethod.
	self assert: res second equals: bBeginMethod.
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testSortedChildrenSortsAlphabeticallyWhenNotSameNameNotSameAnchors [
	| sd parent aBeginMethod bBeginMethod anchor1 anchor2 res |
	sd := FamixSimpleDiff new.
	
	"init parent and child methods"
	parent := FamixJavaClass new name: 'ParentClass'.
	aBeginMethod := FamixJavaMethod new name: 'aBeginMethod';
	signature: 'aBeginMethod()'.
	bBeginMethod := FamixJavaMethod new name: 'bBeginMethod';
	signature: 'bBeginMethod()'.
	
	"init file anchor, must be different for this test"
	anchor1 := FamixJavaIndexedFileAnchor new endPos: 20.
	anchor2 := FamixJavaIndexedFileAnchor new endPos: 10.
	
	"giving created anchors to the methods"
	aBeginMethod sourceAnchor: anchor1.
	bBeginMethod sourceAnchor: anchor2.
	
	"testing the sort"
	parent methods: { bBeginMethod . aBeginMethod}.
	res := sd sortedChildren: parent. 
	
	self assert: res first equals: aBeginMethod.
	self assert: res second equals: bBeginMethod.
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testSortedChildrenUseSourceAnchorWhenFirstAnchorIsMissing [
	| sd parent method1 method2 anchor2 res |
	sd := FamixSimpleDiff new.
	
	"init parent and child methods"
	parent := FamixJavaClass new name: 'ParentClass'.
	
	"init same method"
	method1 := FamixJavaMethod new name: 'SameMethod'.
	method2 := FamixJavaMethod new name: 'SameMethod'.
	
	"init anchor"
	anchor2 := FamixJavaIndexedFileAnchor new endPos: 20.
	method2 sourceAnchor: anchor2.
	
	"testing the sort"
	parent methods: { method2 . method1}.
	res := sd sortedChildren: parent. 
	
	self assert: res size equals: 2.
	self assert: res first equals: method1.
	self assert: res second equals: method2.
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testSortedChildrenUseSourceAnchorWhenSameName [
	| sd parent method1 method2 anchor1 anchor2 res |
	sd := FamixSimpleDiff new.
	
	"init parent and child methods, must be the same for this test"
	parent := FamixJavaClass new name: 'ParentClass'.
	method1 := FamixJavaMethod new name: 'SameMethod'.
	method2 := FamixJavaMethod new name: 'SameMethod'.
	
	"init file anchor, must be different for this test"
	anchor1 := FamixJavaIndexedFileAnchor new endPos: 10.
	anchor2 := FamixJavaIndexedFileAnchor new endPos: 20.
	
	"giving created anchors to the methods"
	method1 sourceAnchor: anchor1.
	method2 sourceAnchor: anchor2.
	
	"testing the sort"
	parent methods: { method2 . method1}.
	res := sd sortedChildren: parent. 
	self assert: res first equals: method1.
	self assert: res second equals: method2. 
	 
	
	
]

{ #category : 'tests' }
FamixSimpleDiffTest >> testSortedChildrenUseSourceAnchorWhenSecondAnchorIsMissing [
	| sd parent method1 method2 anchor1 res |
	sd := FamixSimpleDiff new.
	
	"init parent and child methods"
	parent := FamixJavaClass new name: 'ParentClass'.
	
	"init methods"
	method1 := FamixJavaMethod new name: 'SameMethod'.
	method2 := FamixJavaMethod new name: 'SameMethod'.
	
	anchor1 := FamixJavaIndexedFileAnchor new endPos: 10.
	method1 sourceAnchor: anchor1.
	
	"testing the sort"
	parent methods: { method2 . method1}.
	res := sd sortedChildren: parent. 
	
	self assert: res size equals: 2.
	self assert: res first equals: method1.
	self assert: res second equals: method2.
]
