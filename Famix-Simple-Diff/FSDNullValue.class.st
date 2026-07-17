"
This class implement the Null Object pattern for FamixSimpleDifference values.
 
This class is used when a difference does not have an expected or actual value (expected value of an addition is nil for example). 

We use Null Pattern to avoid useless if cases, and to represent our entities that are missing between models.
"
Class {
	#name : 'FSDNullValue',
	#superclass : 'FamixSimpleDifference',
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'accessing' }
FSDNullValue >> mooseName [
	^ 'NullPatternObject'
]

{ #category : 'accessing' }
FSDNullValue >> name [
	^ 'NullPatternObject'
]

{ #category : 'printing' }
FSDNullValue >> printOn: aStream [
	aStream nextPutAll: 'NullPatternObject' 
]
