Class {
	#name : #ITDictionaryTest,
	#superclass : #TestCase,
	#instVars : [
		'dictionary'
	],
	#category : #DictionaryProject
}

{ #category : #accessing }
ITDictionaryTest >> setUp [
    "Initialize the dictionary before each test."
    
    dictionary := ITDictionary new.
    dictionary initialize.
]

{ #category : #tests }
ITDictionaryTest >> testAddDuplicateWord [
    "Test that adding a duplicate word logs a warning but does not overwrite the original meaning."

    dictionary addWord: 'Pharo' meaning: 'A Smalltalk-inspired programming language'.
    dictionary addWord: 'Pharo' meaning: 'Another meaning'.
    self assert: (dictionary search: 'Pharo') equals: 'A Smalltalk-inspired programming language'.
]

{ #category : #accessing }
ITDictionaryTest >> testAddWord [
    "Test that a word can be added and retrieved."

    dictionary addWord: 'Pharo' meaning: 'A Smalltalk-inspired programming language'.
    self assert: (dictionary search: 'Pharo') equals: 'A Smalltalk-inspired programming language'.
]

{ #category : #tests }
ITDictionaryTest >> testSearchNonExistentWord [
    "Test that searching for a non-existent word returns nil."

    self assert: (dictionary searchWord: 'NonExistent') isNil.
]
