Extension { #name : 'FamixTEntityTyping' }

{ #category : '*Famix-Simple-Diff' }
FamixTEntityTyping >> containers [

	^ { typedEntity }
]

{ #category : '*Famix-Simple-Diff' }
FamixTEntityTyping >> containersDo: aFullBlockClosure [ 
	
	self containers do: aFullBlockClosure
]
