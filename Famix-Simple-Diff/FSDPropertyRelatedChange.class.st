Class {
	#name : 'FSDPropertyRelatedChange',
	#superclass : 'FamixSimpleDifference',
	#instVars : [
		'propertyName'
	],
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'as yet unclassified' }
FSDPropertyRelatedChange >> changeTypeName [
	^ 'Property Related Change'
]

{ #category : 'accessing' }
FSDPropertyRelatedChange >> propertyName [

	^ propertyName
]

{ #category : 'accessing' }
FSDPropertyRelatedChange >> propertyName: anObjet [

	propertyName := anObjet 
]
