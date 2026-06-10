"
This is a class that represents and creates a single difference between two Famix entities or models. 

The subclasses represent specific types of modifications (such as addition, deletion, property change, etc.). 

This class uses a target entity, which is an entity from the second model that we are comparing, on which the change occurred.

Thanks to the target, we always have an expected value (from the original model) and an actual value (from the new model).
"
Class {
	#name : 'FamixSimpleDifference',
	#superclass : 'Object',
	#instVars : [
		'entity',
		'expectedValue',
		'actualValue',
		'propertyName'
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
FamixSimpleDifference class >> createPropertyChanged: aPropertyName entity: anEntity expectedValue: expectedValue actualValue: actualValue [

	^ FamixSimpleDifferencePropertyChanged new
		  propertyName: aPropertyName;
		  entity: anEntity;
		  expectedValue: expectedValue;
		  actualValue: actualValue;
		  yourself
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createRelationChanged: aRelationName entity: anEntity expectedValue: expectedValue actualValue: actualValue [

	^ FamixSimpleDifferenceRelationChanged new
		  propertyName: aRelationName;
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
	
	self propertyName ifNotNil: [ 
		aStream nextPutAll: '| Property Name: ';
				  nextPutAll: self propertyName asString
	].
	
	aStream 
		nextPutAll: ' -> Expected: '; 
		print: expectedValue;
		nextPutAll: ' | Actual: ';
		print: actualValue.
	
	aStream nextPutAll: ' | On: '.
	aStream print: entity.
	aStream nextPutAll: ')'.
]

{ #category : 'accessing' }
FamixSimpleDifference >> propertyName [

	^ propertyName
]

{ #category : 'accessing' }
FamixSimpleDifference >> propertyName: anObject [

	^ propertyName := anObject
]
