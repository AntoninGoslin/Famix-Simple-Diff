"
This class implement the Null Object pattern for FamixSimpleDifference values.
 
This class is used when a difference does not have an expected or actual value (expected value of an addition is nil for example). 

We use Null Pattern to avoid useless if cases.
"
Class {
	#name : 'FamixSimpleDifferenceNullValue',
	#superclass : 'Object',
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'accessing' }
FamixSimpleDifferenceNullValue >> mooseName [
	^ 'Nothing'
]

{ #category : 'accessing' }
FamixSimpleDifferenceNullValue >> name [
	^ 'Nothing'
]

{ #category : 'printing' }
FamixSimpleDifferenceNullValue >> printOn: aStream [
	aStream nextPutAll: 'Nothing'
]
