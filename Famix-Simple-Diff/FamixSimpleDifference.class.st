Class {
	#name : 'FamixSimpleDifference',
	#superclass : 'Object',
	#instVars : [
		'entity',
		'expectedValue',
		'actualValue'
	],
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'instance creation' }
FamixSimpleDifference class >> createEntityAdded: anEntity actualValue: actualValue [ 
	^ self 
		entity: anEntity 
		changeType: self entityAdded
		expectedValue: FamixSimpleDifferenceNullValue new
		actualValue: actualValue 
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createEntityChanged: anEntity expectedValue: expectedValue actualValue: actualValue [ 
	^ self 
		entity: anEntity 
		changeType: self entityChanged 
		expectedValue: expectedValue 
		actualValue: actualValue
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createEntityRemoved: anEntity expectedValue: expectedValue [ 
	^ self 
		entity: anEntity 
		changeType: self entityRemoved 
		expectedValue: expectedValue 
		actualValue: FamixSimpleDifferenceNullValue new
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createPropertyChanged: anEntity expectedValue: expectedValue actualValue: actualValue [ 
	^ self 
		entity: anEntity 
		changeType: self propertyChanged 
		expectedValue: expectedValue 
		actualValue: actualValue 
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createRelationChanged: anEntity expectedValue: expectedValue actualValue: actualValue [ 
	^ self 
		entity: anEntity 
		changeType: self relationChanged 
		expectedValue: expectedValue 
		actualValue: actualValue 
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> entity: anEntity changeType: aSymbol expectedValue: val1 actualValue: val2 [

	| difference |
	difference := FamixSimpleDifference new.
	difference entity: anEntity.
	difference changeType: aSymbol.
	difference expectedValue: val1.
	difference actualValue: val2.
	^ difference
]

{ #category : 'accessing' }
FamixSimpleDifference >> actualValue [

	^ actualValue
]

{ #category : 'accessing' }
FamixSimpleDifference >> actualValue: anObject [

	actualValue := anObject
]

{ #category : 'accessing' }
FamixSimpleDifference >> entity [

	^ entity
]

{ #category : 'accessing' }
FamixSimpleDifference >> entity: anObject [

	entity := anObject
]

{ #category : 'accessing' }
FamixSimpleDifference >> expectedValue [

	^ expectedValue
]

{ #category : 'accessing' }
FamixSimpleDifference >> expectedValue: anObject [

	expectedValue := anObject
]

{ #category : 'printing' }
FamixSimpleDifference >> printOn: aStream [
	"Redifine the display of the FamixDiff class"

	"Will build a Stream like: FamixDiff(Addition -> Expected: ' ' | Actual: 'private int something' | On Class1)"
	 
	super printOn: aStream.
	aStream nextPutAll: '('.
	aStream print: changeType.
	
	aStream 
		nextPutAll: ' -> Expected: '; 
		print: expectedValue;
		nextPutAll: ' | Actual: ';
		print: actualValue.
	
	aStream nextPutAll: ' | On: '.
	aStream print: entity.
	aStream nextPutAll: ')'.
]
