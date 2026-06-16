"
This class represents a specific type of difference where a new entity has been added to the target model.

The expected value is a NullValue (as the entity did not exist before).
The actual value is the added entity.
"
Class {
	#name : 'FamixSimpleDifferenceEntityAddition',
	#superclass : 'FamixSimpleDifference',
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'accessing' }
FamixSimpleDifferenceEntityAddition >> changeTypeName [
	^ 'Entity Addition'
]
