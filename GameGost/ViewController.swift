//
//  ViewController.swift
//  GameGost
//
//  Created by Hannah Lim on 30-09-15.
//  Copyright (c) 2015 Hannah Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var namePlayer1: UITextField!
    @IBOutlet weak var namePlayer2: UITextField!
    @IBOutlet weak var pickerViewPlayer1: UIPickerView!
    @IBOutlet weak var pickerViewPlayer2: UIPickerView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
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
        Player.name1 = namePlayer1.text
        Player.name2 = namePlayer2.text
        var allPlayersList = defaults.arrayForKey("players")
        var name1 = namePlayer1.text
        var name2 = namePlayer2.text
        allPlayersList!.append(name1)
        allPlayersList!.append(name2)
        defaults.setObject(allPlayersList!, forKey: "players")
        var turnPlayer = name1
        defaults.setObject(turnPlayer!, forKey: "turn")
    }
    
    func pickerView(pickerViewPlayer: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerViewPlayer.restorationIdentifier! == "PickerView1"){
            namePlayer1.text = defaults.arrayForKey("players")![row] as! String
        } else{
            namePlayer2.text = defaults.arrayForKey("players")![row] as! String
        }
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
    
    //COMMENTS
    func numberOfComponentsInPickerView(pickerViewPlayer1: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerViewPlayer1: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return defaults.arrayForKey("players")!.count;
    }
    
    func pickerView(pickerViewPlayer1: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return defaults.arrayForKey("players")![row] as! String
    }
    
    func numberOfComponentsInPickerView2(pickerViewPlayer2: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView2(pickerViewPlayer2: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return defaults.arrayForKey("players")!.count;
    }
    
    func pickerView2(pickerViewPlayer2: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return defaults.arrayForKey("players")![row] as! String
    }

}

