//
//  Lexicon.swift
//  GameGost
//
//  Created by Hannah Lim on 01-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//

import Foundation

class Lexicon {
//    static var language: String?
    var dutchLexicon = NSMutableSet()
    var englishLexicon = NSMutableSet()
    var chosenLanguage: String?
    
    init(language: String) {
        // open file and read into local data structure
        loadLanguages(language)
    }

    
    func loadLanguages(language: String) {
        let filePath = NSBundle.mainBundle().pathForResource(language, ofType: "txt")
        

        let content = NSString(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
        let words = content!.componentsSeparatedByString("\n")
    
        for word in words {
            if(language == "dutch"){
                self.dutchLexicon.addObject(word)
                chosenLanguage = "dutch"
            }
            if(language == "english"){
                self.englishLexicon.addObject(word)
                chosenLanguage = "english"
            }
        }

    }
    
    // method filter, this method takes a string as input and filters the word list using this string. Because loading the lexicon takes quite a bit of time, this method should not destroy the base lexicon and thus allows it to be re-used.
    
    func filter(word: String){
        var predicate = NSPredicate(format: "SELF beginswith %@", word)
        dutchLexicon.filterUsingPredicate(predicate)
    }
    
    // method count, this method returns the length of the words remaining in the filtered list.
    func count() -> Int{
        return dutchLexicon.count
    }

    // method result, this method returns the single remaining word in the list. Obviously, this method can only be called if count returns the number 1.
    func result() -> String {
        return "\(dutchLexicon)"
    }

    
    // method reset, to remove the filter and re-start with the original lexicon.
    func restart(){
        let filePath = NSBundle.mainBundle().pathForResource(chosenLanguage, ofType: "txt")
        let content = NSString(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
        
        let words = content!.componentsSeparatedByString("\n")
        
        for word in words {
            if(chosenLanguage == "dutch"){
                self.dutchLexicon.addObject(word)
            }
            if(chosenLanguage == "english"){
                self.englishLexicon.addObject(word)
            }
        }
    }
}



    


    
    
    // Dictonary with words, English and Dutch
    