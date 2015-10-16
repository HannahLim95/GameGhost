//
//  ViewController.swift
//  GameGost
//
//  Created by Hannah Lim on 30-09-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//
//  Name: Hannah Lim
//  Student ID: 10588973

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldNamePlayer1: UITextField!
    @IBOutlet weak var textFieldNamePlayer2: UITextField!
    @IBOutlet weak var pickerViewPlayer1: UIPickerView!
    @IBOutlet weak var pickerViewPlayer2: UIPickerView!
    @IBOutlet weak var segmentedControlSetLanguage: UISegmentedControl!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var newGame : Game = Game()
    
    // Sets language in segmented control depending on the language chosen in the previous game.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets view depending if the keyboard is shown or hiden.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        
        textFieldNamePlayer1.delegate = self
        textFieldNamePlayer2.delegate = self
        
        if(defaults.stringForKey("language") == "dutch") {
            segmentedControlSetLanguage.selectedSegmentIndex = 0
        } else {
            segmentedControlSetLanguage.selectedSegmentIndex = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Sets view if keyboard is shwon.
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    // Sets view if keyboard is hidden.
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }

    // If a name from the pickerview is selected by the player, it sets the selected name to the textfield from the player it is selected by.
    func pickerView(pickerViewPlayer: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerViewPlayer.restorationIdentifier! == "PickerView1") {
            textFieldNamePlayer1.text = defaults.arrayForKey("players")![row] as! String
        } else {
            textFieldNamePlayer2.text = defaults.arrayForKey("players")![row] as! String
        }
    }
    
    func numberOfComponentsInPickerView(pickerViewPlayer1: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerViewPlayer1: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return defaults.arrayForKey("players")!.count
    }
    
    // Fills in the pickerview with the list with the names of the all the players ever played before.
    func pickerView(pickerViewPlayer1: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return defaults.arrayForKey("players")![row] as! String
    }
    
    // If the button 'OK' is pressed by the players, the game will begin.
    @IBAction func beginGame(sender: AnyObject) {
        // Sets the status of the game with 'gamePlaying'.
        defaults.setObject("gamePlaying", forKey: "statusGame")
        
        // Reset the settings in the game.
        newGame.resetGame()
        
        // Sets the playernames and adds them to the players list with all the names.
        defaults.setObject(textFieldNamePlayer1.text!, forKey: "playerName1")
        defaults.setObject(textFieldNamePlayer2.text!, forKey: "playerName2")
        makePlayersList()
        
        // Sets the player who is on turn.
        defaults.setObject(textFieldNamePlayer1.text!, forKey: "turn")
    }
    
    // Sets the list with all the names of all the players ever played.
    func makePlayersList() {
        // Adds the new players to the list with the playernames in a new sorted list.
        var allPlayersList = defaults.arrayForKey("players")
        allPlayersList!.append(defaults.stringForKey("playerName1")!)
        allPlayersList!.append(defaults.stringForKey("playerName2")!)
        var sortedPlayersList = sortList(allPlayersList as! [String])
        defaults.setObject(sortedPlayersList, forKey: "players")
    }
    
    // Removes duplicates and sorts the incoming list en returns the sorted list without duplicates.
    func sortList(unsortedList: [String]) -> [String] {
        var arrayCheckNoDuplicates = Set<String>()
        var arrayNoDuplicates: [String] = []
        
        // If name is not already in the list, adds name to the unsorted list.
        for name in unsortedList {
            if(!arrayCheckNoDuplicates.contains(name)) {
                arrayCheckNoDuplicates.insert(name)
                arrayNoDuplicates.append(name)
            }
        }
        
        // Sorts the list.
        var sortedList = sorted(arrayNoDuplicates)
        return sortedList
    }
    
    // If this segmented control is set to a language by the players, the language is set in the NSUserdefaults.
    @IBAction func setChosenLanguage(sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            defaults.setObject(Lexicon.chosenLanguage!, forKey: "language")
        } else if (sender.selectedSegmentIndex == 1) {
            defaults.setObject(Lexicon.chosenLanguage!, forKey: "language")
        }
    }
    
    // If the button 'Previous game' is pressed by the players and there is a game playing, it performs a segue to the previous game.
    @IBAction func goToPreviousGame(sender: AnyObject) {
        shouldPerformSegueWithIdentifier("segueToPreviousGame", sender: self)
    }
    
    // If the button 'Highscore' is pressed by the players, a segue performs to the highscore list.
    @IBAction func goToHighscore(sender: AnyObject) {
        if(defaults.stringForKey("statusGame") == "noGame") {
            performSegueWithIdentifier("segueToHighscore", sender: self)
        } else {
            shouldPerformSegueWithIdentifier("segueToHighscore", sender: self)
        }
    }
    
    // If there is no game playing, it does not perform a segue. In the other cases it should perform a segue.
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if(defaults.stringForKey("statusGame") == "noGame") {
            return false
        } else {
            return true
        }
    }
}

