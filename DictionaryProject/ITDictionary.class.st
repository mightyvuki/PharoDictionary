Class {
	#name : #ITDictionary,
	#superclass : #Object,
	#instVars : [
		'words'
	],
	#category : #DictionaryProject
}

{ #category : #adding }
ITDictionary >> addWord: word meaning: meaning [
    "This method adds a word and its meaning to the dictionary."

    (words includesKey: word)
        ifTrue: [ "Handle synonyms here later" ]
        ifFalse: [ words at: word put: meaning ].
]

{ #category : #accessing }
ITDictionary >> initialize [
    "Initialize the dictionary to hold words and their meanings."
    
    super initialize.
    words := Dictionary new.
]

{ #category : #accessing }
ITDictionary >> listSimilarWords: word [
    "Return a list of words that include the given word as a substring."
    
    ^ words keys select: [ :key | key includesSubstring: word ].
]

{ #category : #accessing }
ITDictionary >> search: word [
    "Return the meaning of the given word if it exists in the dictionary. Otherwise, return 'Word not found'."
    
    ^ words at: word ifAbsent: [ 'Word not found' ].
]
