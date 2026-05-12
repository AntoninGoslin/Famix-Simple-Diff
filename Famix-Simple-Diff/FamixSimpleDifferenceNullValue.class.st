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
