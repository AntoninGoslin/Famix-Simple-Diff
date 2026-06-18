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

	^ FSDEntityAddition new
		  entity: anEntity;
		  expectedValue: FamixSimpleDifferenceNullValue new;
		  actualValue: actualValue;
		  yourself
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createEntityChanged: anEntity expectedValue: expectedValue actualValue: actualValue [

	^ FSDEntityChanged new
		  entity: anEntity;
		  expectedValue: expectedValue;
		  actualValue: actualValue;
		  yourself
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createEntityDeletion: anEntity expectedValue: expectedValue [

	^ FSDEntityDeletion new
		  entity: anEntity;
		  expectedValue: expectedValue;
		  actualValue: FamixSimpleDifferenceNullValue new;
		  yourself
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createPropertyChanged: aPropertyName entity: anEntity expectedValue: expectedValue actualValue: actualValue [

	^ FSDPropertyChanged new
		  propertyName: aPropertyName;
		  entity: anEntity;
		  expectedValue: expectedValue;
		  actualValue: actualValue;
		  yourself
]

{ #category : 'instance creation' }
FamixSimpleDifference class >> createRelationChanged: aRelationName entity: anEntity expectedValue: expectedValue actualValue: actualValue [

	^ FSDRelationChanged new
		  propertyName: aRelationName;
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
	"Will build a string that represent our differences"
	
	"change name" 
	aStream nextPutAll: '['; 
	nextPutAll: self changeTypeName; 
	nextPutAll: '] '.
	
	"entity"
	aStream nextPutAll: 'On: '.
	self entity 
		ifNotNil: [ aStream nextPutAll: self entity mooseName asString ] 
		ifNil: [ aStream nextPutAll: 'Unknown' ].
		
	"Property"
	self propertyName ifNotNil: [ 
		aStream nextPutAll: ' | Property: '; nextPutAll: self propertyName asString.
	].

	"subclass responsibility"
	self printValuesOn: aStream.
]

{ #category : 'printing' }
FamixSimpleDifference >> printValuesOn: aStream [
	" By default we give the expected value and the actual value"

	aStream nextPutAll: ' | Expected: '.
	aStream print: self expectedValue.
	aStream nextPutAll: ' | Actual: '.
	aStream print: self actualValue
]

{ #category : 'accessing' }
FamixSimpleDifference >> propertyName [

	^ propertyName
]

{ #category : 'accessing' }
FamixSimpleDifference >> propertyName: anObject [

	^ propertyName := anObject
]
