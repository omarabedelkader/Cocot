Class {
	#name : 'CoSinglePackageScopedGlobalVariableFetcherTest',
	#superclass : 'CoBasicFetcherWithElementsTest',
	#instVars : [
		'package'
	],
	#category : 'HeuristicCompletion-Cocot',
	#package : 'HeuristicCompletion-Cocot'
}

{ #category : 'running' }
CoSinglePackageScopedGlobalVariableFetcherTest >> setUp [

	self setUpSomeClassesInAndOutsidePackage. 
	
	fetcher := CoSinglePackageScopedGlobalVariableFetcher new.
	fetcher packages: { PackageOrganizer default packageNamed: 'HeuristicCompletion-Cocot'  }.
	fetcher systemNavigation: self systemNavigation.
	fetcher filter: (CoBeginsWithFilter caseSensitive: false filterString: 'AI').

	expectedElements := {
		NECGlobalEntry contents: 'AInP1' node: nil .
		NECGlobalEntry contents: 'AAInP1' node: nil .
		NECGlobalEntry contents: 'AA' node: nil }
]

{ #category : 'running' }
CoSinglePackageScopedGlobalVariableFetcherTest >> setUpSomeClassesInAndOutsidePackage [

	| a b c |
	completionClass := CoMockClass new name: 'CoInP1'. 
	a := CoMockClass new name: 'AInP1'.
	b := CoMockClass new name: 'AAInP1'.
	c := CoMockClass new name: 'AA'.
	package := CoMockPackage new. 
			

	systemNavigation := CoMockSystemNavigation new
		globals: {'Ab' . 'B' . 'AIGlobal' };
		yourself
]

{ #category : 'running' }
CoSinglePackageScopedGlobalVariableFetcherTest >> testNextManyShouldReturnCollection [

	| fetchedElements expected |
	fetchedElements := self fetcher next: 2.
	expected := { self firstExpectedElement . self secondExpectedElement }.
	fetchedElements withIndexDo: [ :each :index |
		self assertEntry: each equals: (expected at: index) ].
	self assert: fetchedElements size equals: expected size
]
