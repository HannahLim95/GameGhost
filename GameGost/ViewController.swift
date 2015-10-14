//
//  ViewController.swift
//  GameGost
//
//  Created by Hannah Lim on 30-09-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//
//Name: Hannah Lim
//Student ID: 10588973

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var textFieldNamePlayer1: UITextField!
    @IBOutlet weak var textFieldNamePlayer2: UITextField!
    @IBOutlet weak var pickerViewPlayer1: UIPickerView!
    @IBOutlet weak var pickerViewPlayer2: UIPickerView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var newPlayers : Player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // if OK is presesed the names will be added tot the array of all the names of players ever played.
    @IBAction func beginGame(sender: AnyObject) {
        if (defaults.arrayForKey("players") == nil) {
            var namesPlayersList = [""]
            defaults.setObject(namesPlayersList, forKey: "players")
        }
        Player.name1 = textFieldNamePlayer1.text
        Player.name2 = textFieldNamePlayer2.text
        newPlayers.setName()
        var allPlayersList = defaults.arrayForKey("players")
        allPlayersList!.append(Player.name1!)
        allPlayersList!.append(Player.name2!)
        var allPlayersListNoDuplicates = removeDuplicates(allPlayersList as! [String])
        //alles resetten
        defaults.setObject(allPlayersListNoDuplicates, forKey: "players")
        defaults.setObject(Player.name1, forKey: "turn")
        defaults.setObject("gamePlaying", forKey: "statusGame")
        Player.score1 = 0
        Player.score2 = 0
        newPlayers.setScore()
        defaults.setObject("", forKey: "word")
    }
    
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }
    
    // this segmented control sets the chosen language. Initially the language is dutch.
    @IBAction func setChosenLanguage(sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            Lexicon.chosenLanguage = "dutch"
            defaults.setObject(Lexicon.chosenLanguage!, forKey: "language")
        } else if (sender.selectedSegmentIndex == 1){
            Lexicon.chosenLanguage = "english"
            defaults.setObject(Lexicon.chosenLanguage!, forKey: "language")
        }
    }
    
    @IBAction func goToPreviousGame(sender: AnyObject) {
        print(defaults.stringForKey("statusGame"))
        shouldPerformSegueWithIdentifier("segueToPreviousGame", sender: self)
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if(defaults.stringForKey("statusGame") == "gameEnded"){
            return false
        } else{
            return true
        }
    }
    
    //COMMENTS
    
    func pickerView(pickerViewPlayer: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerViewPlayer.restorationIdentifier! == "PickerView1"){
            textFieldNamePlayer1.text = defaults.arrayForKey("players")![row] as! String
        } else{
            textFieldNamePlayer2.text = defaults.arrayForKey("players")![row] as! String
        }
    }
    
    func numberOfComponentsInPickerView(pickerViewPlayer1: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerViewPlayer1: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return defaults.arrayForKey("players")!.count;
    }
    
    func pickerView(pickerViewPlayer1: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return defaults.arrayForKey("players")![row] as! String
    }
}

