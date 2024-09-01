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
        ifTrue: [ "Here we can display synonyms in the future" ]
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
ITDictionary >> loadFromFile: fileName [
    "Load the dictionary from a .txt file."

    | file lines |
    words := Dictionary new.  "Reinitialize the dictionary"
    [
        file := FileLocator desktop / fileName.
        lines := file readStreamDo: [ :stream | stream contents lines ].
        lines do: [ :line |
            | parts word meaning |
            parts := line findTokens: ' : '.
            (parts size = 2)
                ifTrue: [
                    word := parts first.
                    meaning := parts second.
                    words at: word put: meaning.
                ]
                ifFalse: [
                    "Handle invalid line format"
                    Transcript show: 'Invalid line in file: ', line; cr.
                ].
        ].
    ] on: FileDoesNotExistException do: [ :ex |
        Transcript show: 'File not found: ', fileName; cr.
    ].
]

{ #category : #accessing }
ITDictionary >> saveToFile: fileName [
    "Save the dictionary to a  .txt file formatted [word : meaning]"

    | file |
    file := File newFileNamed: fileName.
    file nextPutAll: [ words associationsDo: [ :assoc |
        file nextPutAll: assoc key; nextPutAll: ' : '; nextPutAll: assoc value; cr.
    ] ].
    file close.
]

{ #category : #accessing }
ITDictionary >> search: word [
    "Return the meaning of the given word if it exists in the dictionary. Otherwise, return 'Word not found'."
    
    ^ words at: word ifAbsent: [ 'Word not found' ].
]

{ #category : #accessing }
ITDictionary >> searchWord: word [
    "Search for the meaning of a word in the dictionary. Returns the meaning if found, otherwise logs a message and returns nil."

    | meaning |
    meaning := words at: word ifAbsent: [
        Transcript
            nextPutAll: 'The word: ';
            nextPutAll: word;
            nextPutAll: ' is not found in the dictionary.';
            cr.
        nil
    ].
    ^meaning
]
