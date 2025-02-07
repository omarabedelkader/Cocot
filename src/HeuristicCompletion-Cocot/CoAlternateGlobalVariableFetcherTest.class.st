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
		globals: {'Ab' . 'B' . 'AIGlobal' . 'AIa' };
		yourself.

	fetcher := CoGlobalVariableFetcher new.
	
	fetcher systemNavigation: systemNavigation.
	fetcher filter: (CoBeginsWithFilter caseSensitive: false filterString: 'AI').

	completionClass := CoMockClass new name: 'CoInP1'. 
	
	expectedElements := {
		NECGlobalEntry contents: 'AIGlobal' node: nil .
		NECGlobalEntry contents: 'AIa' node: nil.
		  }
]

{ #category : 'running' }
CoAlternateGlobalVariableFetcherTest >> testEnvironment [ 

	| o | 
	o := OrderedCollection new. 
	systemNavigation 
			allGlobalNamesStartingWith: 'AI' 
			do: [ :each | o add: each ] caseSensitive: false.
	self assert: o first equals: 'AIGlobal'.
	self assert: o second equals: 'AIa'.
	self assert: o size equals: 2.

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
CoAlternateGlobalVariableFetcherTest >> testFirstThreeButOnlyTwo [

	| fetchedElements  |
	fetchedElements := self fetcher next: 3.
	fetchedElements withIndexDo: [ :each :index |
		self assertEntry: each equals: (expectedElements at: index) ].
	self assert: fetchedElements size equals: expectedElements size
]
