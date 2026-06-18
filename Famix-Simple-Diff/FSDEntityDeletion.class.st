"
This class represents a specific type of difference where an entity has been removed from the target model.

The expected value is the deleted entity.
The actual value is a NullValue.
"
Class {
	#name : 'FSDEntityDeletion',
	#superclass : 'FamixSimpleDifference',
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'accessing' }
FSDEntityDeletion >> changeTypeName [
	^ 'Entity Deletion'
]
