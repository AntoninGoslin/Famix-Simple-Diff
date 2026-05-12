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
	^ FamixSimpleDifferenceEntityAddition new
		entity: anEntity;
		expectedValue: FamixSimpleDifferenceNullValue new;
		actualValue: actualValue;
		yourself
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createEntityChanged: anEntity expectedValue: expectedValue actualValue: actualValue [ 
	^ FamixSimpleDifferenceEntityChanged new
		entity: anEntity; 
		expectedValue: expectedValue;
		actualValue: actualValue;
		yourself 
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createEntityDeletion: anEntity expectedValue: expectedValue [ 
	^ FamixSimpleDifferenceEntityDeletion new
		entity: anEntity;
		expectedValue: expectedValue;
		actualValue: FamixSimpleDifferenceNullValue new;
		yourself 
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createPropertyChanged: anEntity expectedValue: expectedValue actualValue: actualValue [ 
	^ FamixSimpleDifferencePropertyChanged new
		entity: anEntity; 
		expectedValue: expectedValue;
		actualValue: actualValue;
		yourself 
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createRelationChanged: anEntity expectedValue: expectedValue actualValue: actualValue [ 
	^ FamixSimpleDifferenceRelationChanged new
		entity: anEntity;
		expectedValue: expectedValue;
		actualValue: actualValue;
		yourself
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
FamixSimpleDifference >> changeTypeName [
	"the name have to be defined by the subclass"
	^ self subclassResponsibility 
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
	"Will build a Stream like: FamixDiff(Addition -> Expected: ' ' | Actual: 'private int something' | On Class1)"
	 
	super printOn: aStream.
	aStream nextPutAll: '('.
	aStream print: self changeTypeName.
	
	aStream 
		nextPutAll: ' -> Expected: '; 
		print: expectedValue;
		nextPutAll: ' | Actual: ';
		print: actualValue.
	
	aStream nextPutAll: ' | On: '.
	aStream print: entity.
	aStream nextPutAll: ')'.
]
