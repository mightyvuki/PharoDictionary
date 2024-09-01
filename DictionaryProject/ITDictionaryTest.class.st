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

{ #category : #tests }
ITDictionaryTest >> testAddWord [
    "Test that a word can be added and retrieved."

    dictionary addWord: 'Pharo' meaning: 'A Smalltalk-inspired programming language'.
    self assert: (dictionary search: 'Pharo') equals: 'A Smalltalk-inspired programming language'.
]

{ #category : #tests }
ITDictionaryTest >> testListSimilarWords [ [
    "Test that the meaning with synonyms works correctly."

    dictionary addWord: 'Pharo' meaning: 'A Smalltalk-inspired programming language (Similar words: Smalltalk)'.
    dictionary addWord: 'Smalltalk' meaning: 'An object-oriented programming language (Similar words: Pharo)'.
    dictionary addWord: 'Graph' meaning: 'A diagram representing connections (Similar words: Network)'.
    dictionary addWord: 'Network' meaning: 'A system of interconnected elements (Similar words: Graph)'.

    "Check the meanings with synonyms"
    self assert: (dictionary search: 'Pharo') = 'A Smalltalk-inspired programming language (Similar words: Smalltalk)'.
    self assert: (dictionary search: 'Network') = 'A system of interconnected elements (Similar words: Graph)'.
]
]

{ #category : #tests }
ITDictionaryTest >> testSaveAndLoadFile [ [
    "Test saving to and loading from a file."

    | tempFileName loadedDictionary file |
    
    tempFileName := 'tempITDictionary.txt'.

    "Add some words to the dictionary"
    dictionary addWord: 'Pharo' meaning: 'A Smalltalk-inspired programming language'.
    dictionary addWord: 'Smalltalk' meaning: 'An object-oriented programming language'.
    
    "Save the dictionary to the temporary file"
    dictionary saveToFile: tempFileName.

    "Create a new dictionary and load the file"
    loadedDictionary := ITDictionary new.
    loadedDictionary loadFromFile: tempFileName.
    
    "Check that the words have been loaded correctly"
    self assert: (loadedDictionary search: 'Pharo') equals: 'A Smalltalk-inspired programming language'.
    self assert: (loadedDictionary search: 'Smalltalk') equals: 'An object-oriented programming language'.
]
]

{ #category : #tests }
ITDictionaryTest >> testSearchNonExistentWord [ [
    "Test that searching for a non-existent word returns 'Word not found'."

    self assert: (dictionary search: 'NonExistent') equals: 'Word not found'.
]
]
