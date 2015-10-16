//
//  Lexicon.swift
//  GameGost
//
//  Created by Hannah Lim on 01-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//
//  Name: Hannah Lim
//  Student ID: 10588973

import Foundation

class Lexicon {
    let defaults = NSUserDefaults.standardUserDefaults()
    var dutchLexicon = NSMutableSet()
    var englishLexicon = NSMutableSet()
    static var chosenLanguage: String?
    
    init(language: String) {
        loadLanguages(language)
    }
    
    func loadLanguages(language: String) {
        // Loads the lexicon files.
        let filePath = NSBundle.mainBundle().pathForResource(language, ofType: "txt")
        let content = NSString(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
        let words = content!.componentsSeparatedByString("\n")
        
        // Adds the words found in the lexicon to the lexicon list.
        for word in words {
            if(language == "dutch") {
                self.dutchLexicon.addObject(word)
                Lexicon.chosenLanguage = "dutch"
            } else {
                self.englishLexicon.addObject(word)
            }
        }
    }
    
    // Filters the lexicon list that is used with the input, that is the word guessed so far.
    func filter(word: String) {
        var predicate = NSPredicate(format: "SELF beginswith %@", word)
        if(defaults.stringForKey("language") == "dutch") {
            dutchLexicon.filterUsingPredicate(predicate)
        } else {
            englishLexicon.filterUsingPredicate(predicate)
        }
    }
    
    // Counts the word remaining in the filtered lexicon list and returns that count.
    func count() -> Int {
        if(defaults.stringForKey("language") == "dutch") {
            return dutchLexicon.count
        } else {
            return englishLexicon.count
        }
    }
    
    // Returns the single remaining word in the lexicon list.
    func result() -> String {
        if(defaults.stringForKey("language") == "dutch") {
            return "\(dutchLexicon)"
        } else {
            return "\(englishLexicon)"
        }
    }    
}