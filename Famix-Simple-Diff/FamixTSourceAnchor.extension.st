Extension { #name : 'FamixTSourceAnchor' }

{ #category : '*Famix-Simple-Diff' }
FamixTSourceAnchor >> containers [

	^ { element }
]

{ #category : '*Famix-Simple-Diff' }
FamixTSourceAnchor >> containersDo: aFullBlockClosure [ 
	
	self containers do: aFullBlockClosure
]
