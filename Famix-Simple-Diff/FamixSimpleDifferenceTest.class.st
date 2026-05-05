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
						entity: 'testEntity' 
						changeType: #entityModification
						expectedValue: expectedValue 
						actualValue: actualValue.
						
	"checking instance creation"
	self assert: difference entity equals: 'testEntity'.
	self assert: difference changeType equals: #entityModification.
	self assert: difference expectedValue equals: expectedValue.
	self assert: difference actualValue equals: actualValue.
]
