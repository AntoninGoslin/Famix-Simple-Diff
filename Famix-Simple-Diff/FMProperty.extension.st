Extension { #name : 'FMProperty' }

{ #category : '*Famix-Simple-Diff' }
FMProperty >> read: anEntity [

	"For reflective purposes. If we use the slot reflectively, honor the defaultValue.
	Are we using slots in the right way?"
	^ (super read: anEntity) ifNil: [ self defaultValue ]
]
