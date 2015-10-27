//
//  GuessViewController.swift
//  Hangman
//
//  Created by Colby on 10/18/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var guesses : [String] = [String]()
    var pickerList: [[String]] = [[String]]()
    var lastLetter : String = "a"
    var game = Hangman()
    var wrongCount = 0
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var guessHistoryLabel: UILabel!
    @IBOutlet weak var wordSoFar: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var startOverButton: UIBarButtonItem!
    @IBOutlet weak var hangmanImage: UIImageView!
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func startOverButtonPressed(sender: AnyObject) {
        self.viewDidLoad()
    }
    
    @IBAction func guessButtonPressed(sender: AnyObject) {
        if lastLetter != "" {
            let result = game.guessLetter(lastLetter.uppercaseString)
            if result == false {
                guessHistoryLabel.text! += "\n" + lastLetter
                wrongCount++
                hangmanImage.image = UIImage(named: "hangman" + String(wrongCount + 1) + ".gif")
                if wrongCount > 6 {
                    let alertController = UIAlertController(title: "Out of guesses!", message: "Have you considered something less hardcore, like Words with Friends?", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Whatever", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    guessButton.hidden = true
                    picker.hidden = true
                    hangmanImage.image = UIImage(named: "hangman7.gif")
                }
            } else {
                wordSoFar.text! = game.knownString!
                if game.knownString!.rangeOfString("_") == nil {
                    let alertController = UIAlertController(title: "Victory!", message: "Wheel of Fortune here we come!", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Damn Straight", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    guessButton.hidden = true
                    picker.hidden = true
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.picker.delegate = self
        self.picker.dataSource = self
        guessButton.hidden = false
        picker.hidden = false
        for i in 0...4 {
            picker.selectRow(0, inComponent: i, animated: true)
        }
        hangmanImage.image = UIImage(named: "hangman1.gif")
        
        game = Hangman()
        game.start()
        wordSoFar.text! = game.knownString!
        guessHistoryLabel.text! = "Incorrect:"
        wrongCount = 0
        guesses = [String]()
        
        pickerList = [["" , "" , "" , "" , "" ],
                      ["a", "e", "i", "o", "u"],
                      ["b", "f", "j", "p", "v"],
                      ["c", "g", "k", "q", "w"],
                      ["d", "h", "l", "r", "x"],
                      ["" , "" , "m", "s", "y"],
                      ["" , "" , "n", "t", "z"]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row][component]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lastLetter = pickerList[row][component]
    }
    
}
