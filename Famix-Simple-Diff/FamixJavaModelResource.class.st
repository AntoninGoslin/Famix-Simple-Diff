Class {
	#name : 'FamixJavaModelResource',
	#superclass : 'FamixAbstractModelBuilderTestResource',
	#category : 'Famix-Simple-Diff',
	#package : 'Famix-Simple-Diff'
}

{ #category : 'accessing' }
FamixJavaModelResource class >> resources [

	^ { FamixJavaModelResource }
]

{ #category : 'accessing' }
FamixJavaModelResource >> libraryModel [

	^ self resources anyOne current libraryModel
]

{ #category : 'accessing' }
FamixJavaModelResource >> mainModel1 [ 

	^ self resources anyOne current mainModel1
]

{ #category : 'accessing' }
FamixJavaModelResource >> mainModel2 [ 

	^ self resources anyOne current mainModel2
]
