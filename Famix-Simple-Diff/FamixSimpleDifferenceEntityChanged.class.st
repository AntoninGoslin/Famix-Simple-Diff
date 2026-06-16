"
This class represents a specific type of difference where two entities changed.

The expected value is the entity from the original model.
The actual value is the entity from the modified model.
"
Class {
	#name : 'FamixSimpleDifferenceEntityChanged',
	#superclass : 'FamixSimpleDifference',
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'accessing' }
FamixSimpleDifferenceEntityChanged >> changeTypeName [
	^ 'Entity Changed'
]
