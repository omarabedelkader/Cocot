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

	| string case closeClassNames keys | 
	string := filter completionString.
	case := NECPreferences caseSensitive.

	closeClassNames := packages first definedClasses collect: [ :each | each name ].
	
	closeClassNames do: [ :closeClassName | 
							(closeClassName beginsWith: string caseSensitive: case) 
										ifTrue: [ aBlock value: (NECGlobalEntry contents: closeClassName node: astNode) ] ].
	
	"forced to copy the keys but let us try."
	keys := self systemNavigation keys.
	closeClassNames do: [ :e | keys remove: e ].
	"we could not use remove: ifAbsent: but this would hide something. 
	Because I do not get why the navigation should not contain the same objects than before."
	
	keys	do: [ :globalName | (globalName beginsWith: string caseSensitive: case) 
										ifTrue: [ aBlock value: (NECGlobalEntry contents: globalName node: astNode) ] ]
		
	
]

{ #category : 'enumerating' }
CoSinglePackageScopedGlobalVariableFetcher >> packages: aCollection [

	packages := aCollection
]
