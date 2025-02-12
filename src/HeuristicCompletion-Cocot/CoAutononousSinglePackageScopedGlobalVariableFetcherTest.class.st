Class {
	#name : 'CoAutononousSinglePackageScopedGlobalVariableFetcherTest',
	#superclass : 'TestCase',
	#instVars : [
		'package',
		'completionClass',
		'systemNavigation',
		'fetcher',
		'expectedElements'
	],
	#category : 'HeuristicCompletion-Cocot',
	#package : 'HeuristicCompletion-Cocot'
}

{ #category : 'running' }
CoAutononousSinglePackageScopedGlobalVariableFetcherTest >> assertEntry: anEntry equals: expectedEntry [

	"Entries do not define equality :("
	self assert: anEntry class equals: expectedEntry class.
	self assert: anEntry contents equals: expectedEntry contents
]

{ #category : 'running' }
CoAutononousSinglePackageScopedGlobalVariableFetcherTest >> fetcher [ 

	^ fetcher
]

{ #category : 'accessing' }
CoAutononousSinglePackageScopedGlobalVariableFetcherTest >> firstExpectedElement [
	^ expectedElements first
]

{ #category : 'helpers' }
CoAutononousSinglePackageScopedGlobalVariableFetcherTest >> secondExpectedElement [
	^ expectedElements second
]

{ #category : 'running' }
CoAutononousSinglePackageScopedGlobalVariableFetcherTest >> setUpOneLocalThenGlobal [ 

	| a b c |
	completionClass := CoMockClass new name: 'CoInP1'. 
	a := CoMockClass new name: 'AInP1'.
	b := CoMockClass new name: 'AAInP1'.
	c := CoMockClass new name: 'AA'.
	package := CoMockPackage new. 
	package definedClasses: { a . b . c . completionClass }.
			
	systemNavigation := CoMockSystemNavigation new
		globals: OrderedCollection <- {'Ab' . 'B' . 'AIGlobal' . 'AInP1' . 'AAInP1'. 'AA' } ;
		yourself.

	fetcher := CoSinglePackageScopedGlobalVariableFetcher new. 
	fetcher packages: { package }.
	fetcher systemNavigation: systemNavigation.
	fetcher filter: (CoBeginsWithFilter caseSensitive: false filterString: 'AI').

	expectedElements := {
		NECGlobalEntry contents: 'AInP1' node: nil .
		NECGlobalEntry contents: 'AIGlobal' node: nil }
]

{ #category : 'running' }
CoAutononousSinglePackageScopedGlobalVariableFetcherTest >> testFirstPackageLevelThenGlobal [

	| fetchedElements expected |
	self setUpOneLocalThenGlobal. 
	fetchedElements := self fetcher next: 2.
	expected := { self firstExpectedElement . self secondExpectedElement }.
	fetchedElements withIndexDo: [ :each :index |
		self assertEntry: each equals: (expected at: index) ].
	self assert: fetchedElements size equals: expected size
]

{ #category : 'running' }
CoAutononousSinglePackageScopedGlobalVariableFetcherTest >> testResetShouldRestartGenerator [

	| fetchedElements |
	self setUpOneLocalThenGlobal. 
	self fetcher upToEnd; reset.
	fetchedElements := self fetcher next: expectedElements size + 1.
	fetchedElements withIndexDo: [ :each :index |
		self assertEntry: each equals: (expectedElements at: index) ].
	self assert: fetchedElements size equals: expectedElements size
]
