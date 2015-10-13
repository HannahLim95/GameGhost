//
//  Lexicon.swift
//  GameGost
//
//  Created by Hannah Lim on 01-10-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//

import Foundation

class Lexicon {
    var dutchLexicon = NSMutableSet()
    var englishLexicon = NSMutableSet()
    static var chosenLanguage: String?
    let defaults = NSUserDefaults.standardUserDefaults()
    
    init(language: String) {
        // open file and read into local data structure
        //var languageChosen = language
        //print(languageChosen)
        loadLanguages(language)
        //dit gaat nog niet goed, hij geeft de oude taal
    }
    
    func loadLanguages(language: String) {
        let filePath = NSBundle.mainBundle().pathForResource(language, ofType: "txt")
        let content = NSString(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
        let words = content!.componentsSeparatedByString("\n")
    
        for word in words {
            if(language == "dutch"){
                self.dutchLexicon.addObject(word)
                Lexicon.chosenLanguage = "dutch"
            }
            if(language == "english"){
                self.englishLexicon.addObject(word)
                Lexicon.chosenLanguage = "english"
            }
        }
    }
    
    // method filter, this method takes a string as input and filters the word list using this string. Because loading the lexicon takes quite a bit of time, this method should not destroy the base lexicon and thus allows it to be re-used.
    func filter(word: String){
        var predicate = NSPredicate(format: "SELF beginswith %@", word)
        if(Lexicon.chosenLanguage == "dutch"){
            dutchLexicon.filterUsingPredicate(predicate)
            //print(dutchLexicon)
        } else{
            englishLexicon.filterUsingPredicate(predicate)
            //print(englishLexicon)
        }
    }
    
    // method count, this method returns the length of the words remaining in the filtered list.
    func count() -> Int{
        if(Lexicon.chosenLanguage == "dutch"){
            return dutchLexicon.count
        } else{
            return englishLexicon.count
        }
    }

    // method result, this method returns the single remaining word in the list. Obviously, this method can only be called if count returns the number 1.
    func result() -> String {
         return "\(dutchLexicon)"
    }

    
    // method reset, to remove the filter and re-start with the original lexicon.
    func restart(){
        if(Lexicon.chosenLanguage == "dutch"){
            let filePath = NSBundle.mainBundle().pathForResource(Lexicon.chosenLanguage, ofType: "txt")
            let content = NSString(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
            
            let words = content!.componentsSeparatedByString("\n")
            
            for word in words {
                self.dutchLexicon.addObject(word)
            }
        } else{
            let filePath = NSBundle.mainBundle().pathForResource(Lexicon.chosenLanguage, ofType: "txt")
            let content = NSString(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
            
            let words = content!.componentsSeparatedByString("\n")
            
            for word in words {
                self.englishLexicon.addObject(word)
            }
        }
    }
}