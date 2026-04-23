Class {
	#name : 'FamixDiff',
	#superclass : 'Object',
	#instVars : [
		'entity',
		'changeType',
		'expectedValue',
		'actualValue'
	],
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'instance creation' }
FamixDiff class >> entity: anEntity changeType: aSymbol expectedValue: val1 actualValue: val2 [

	| difference |
	difference := FamixDiff new.
	difference entity: anEntity.
	difference changeType: aSymbol.
	difference expectedValue: val1.
	difference actualValue: val2.
	^ difference
]

{ #category : 'accessing' }
FamixDiff >> actualValue [

	^ actualValue
]

{ #category : 'accessing' }
FamixDiff >> actualValue: anObject [

	actualValue := anObject
]

{ #category : 'accessing' }
FamixDiff >> changeType [

	^ changeType
]

{ #category : 'accessing' }
FamixDiff >> changeType: anObject [

	changeType := anObject
]

{ #category : 'accessing' }
FamixDiff >> entity [

	^ entity
]

{ #category : 'accessing' }
FamixDiff >> entity: anObject [

	entity := anObject
]

{ #category : 'accessing' }
FamixDiff >> expectedValue [

	^ expectedValue
]

{ #category : 'accessing' }
FamixDiff >> expectedValue: anObject [

	expectedValue := anObject
]
