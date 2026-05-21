"
This is the baseline for Clap - the Pharo command line handler
"
Class {
	#name : 'BaselineOfFamixSimpleDiff',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFamixSimpleDiff',
	#package : 'BaselineOfFamixSimpleDiff'
}

{ #category : 'baselines' }
BaselineOfFamixSimpleDiff >> baseline: spec [

	<baseline>
	self mooseTestResourcesJavaModels: spec.
	
	spec for: #common do: [
		spec
			package: 'Famix-Simple-Diff' with: [
				spec requires:
						#( 'MooseTestResourcesJavaModels' ) ];
					
			package: 'Famix-Simple-Diff-Tests' with: [
				spec requires:
						#( 'Famix-Simple-Diff' ) ] ]
]

{ #category : 'baselines' }
BaselineOfFamixSimpleDiff >> mooseTestResourcesJavaModels: spec [

	spec
		baseline: 'MooseTestResourcesJavaModels'
		with: [ 
		spec repository: 'github://RomainDeg/Moose-TestResources-JavaModels:main/src' ]
]
