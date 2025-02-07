"
I am a fetcher looking for globals in an environment.
"
Class {
	#name : 'CoSinglePackageScopedGlobalVariableFetcher',
	#superclass : 'CoGlobalFetcher',
	#instVars : [
		'packages'
	],
	#category : 'HeuristicCompletion-Cocot',
	#package : 'HeuristicCompletion-Cocot'
}

{ #category : 'enumerating' }
CoSinglePackageScopedGlobalVariableFetcher >> entriesDo: aBlock [

	self systemNavigation
		allGlobalNamesStartingWith: filter completionString
		do: [ :e | aBlock value: (NECGlobalEntry contents: e node: astNode) ]
		caseSensitive: (NECPreferences caseSensitive)
]

{ #category : 'enumerating' }
CoSinglePackageScopedGlobalVariableFetcher >> packages: aCollection [

	packages := aCollection
]
