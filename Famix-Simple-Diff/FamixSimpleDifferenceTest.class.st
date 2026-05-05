Class {
	#name : 'FamixSimpleDifferenceTest',
	#superclass : 'TestCase',
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'tests' }
FamixSimpleDifferenceTest >> testInstanceCreation [
	| difference expectedValue actualValue |
	
	"testing a code modification"
	expectedValue := 'private int money;'.
	actualValue := 'private int age;'.
	
	difference := FamixSimpleDifference 
						createEntityChanged: 'testEntity' 
						expectedValue: expectedValue 
						actualValue: actualValue.
						
	"checking instance creation"
	self assert: difference entity equals: 'testEntity'.
	self assert: difference class equals: FamixSimpleDifferenceEntityChanged.
	self assert: difference expectedValue equals: expectedValue.
	self assert: difference actualValue equals: actualValue.
]
