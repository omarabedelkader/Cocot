Class {
	#name : 'CoAlternateGlobalVariableFetcherTest',
	#superclass : 'CoBasicFetcherWithElementsTest',
	#instVars : [
		'package'
	],
	#category : 'HeuristicCompletion-Cocot',
	#package : 'HeuristicCompletion-Cocot'
}

{ #category : 'running' }
CoAlternateGlobalVariableFetcherTest >> setUp [

	systemNavigation := CoMockSystemNavigation new
		globals: {'Ab' . 'B' . 'AIGlobal' };
		yourself.

	fetcher := CoSinglePackageScopedGlobalVariableFetcher new.
	
	fetcher systemNavigation: systemNavigation.
	fetcher filter: (CoBeginsWithFilter caseSensitive: false filterString: 'AI').

	completionClass := CoMockClass new name: 'CoInP1'. 
	
	expectedElements := {
		NECGlobalEntry contents: 'AIGlobal' node: nil  }
]

{ #category : 'running' }
CoAlternateGlobalVariableFetcherTest >> testEnvironment [ 

	| o | 
	o := OrderedCollection new. 
	systemNavigation 
			allGlobalNamesStartingWith: 'AI' 
			do: [ :each | o add: each ] caseSensitive: false.
	self assert: o first equals: 'AIGlobal'.
	self assert: o size equals: 1.

]

{ #category : 'running' }
CoAlternateGlobalVariableFetcherTest >> testFirst [

	| fetchedElements expected |
	fetchedElements := self fetcher next: 1.
	expected := { self firstExpectedElement }.
	fetchedElements withIndexDo: [ :each :index |
		self assertEntry: each equals: (expected at: index) ].
	self assert: fetchedElements size equals: expected size
]

{ #category : 'running' }
CoAlternateGlobalVariableFetcherTest >> testFirstTwoButOnlyOne [

	| fetchedElements expected |
	fetchedElements := self fetcher next: 2.
	expected := { self firstExpectedElement }.
	fetchedElements withIndexDo: [ :each :index |
		self assertEntry: each equals: (expected at: index) ].
	self assert: fetchedElements size equals: expected size
]
