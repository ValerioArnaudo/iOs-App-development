//
//  ViewController.swift
//  Apple Pie
//
//  Created by Nesrine Kortas on 17.11.19.
//  Copyright © 2019 Nesrine Kortas. All rights reserved.
//

import UIKit

struct Game{
    var aWord:String
    var leftMoves:Int
    var guessedLetters:[Character]
    
    mutating func letterGuessed(aLetter:Character){
        guessedLetters.append(aLetter)
        if !aWord.contains(aLetter){
            leftMoves -= 1
        }
    }
    
    func formattedWord() -> String {
        var formatted:String = ""
        for aLetter in aWord{
            if guessedLetters.contains(aLetter){
                formatted += "\(aLetter)"
            }
            else{
                formatted += "_"
            }
        }
        return formatted
    }
}

class ViewController: UIViewController {
    @IBOutlet var treeImage: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords:[String] = ["hello","ciao","miao"]
    let incorrectMoves:Int = 7
    var wins:Int = 0 {
        didSet{
            newRound()
        }
    }
    var losses:Int = 0 {
        didSet{
            newRound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var actualGame:Game!
    
    func newRound(){
        if !listOfWords.isEmpty{
            let newWord:String = listOfWords.removeFirst()
            actualGame = Game(aWord: newWord, leftMoves: incorrectMoves,guessedLetters: [])
            enableButtons(true)
            UpdateUi()
        }
        else{
            enableButtons(false)
        }
    }
    
    func enableButtons(_ aBool:Bool){
        for button in letterButtons{
            button.isEnabled = aBool
        }
    }
    
    func UpdateUi(){
        var letters:[String] = []
        for aLetter in actualGame.formattedWord(){
            letters.append(String(aLetter))
        }
        let lettersWithSpace = letters.joined(separator: " ")
        correctWordLabel.text = lettersWithSpace
        scoreLabel.text = "Wins: \(wins) and Losses: \(losses)"
        treeImage.image = UIImage(named: "Tree \(actualGame.leftMoves)")
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterButton:String = sender.title(for: .normal)!
        let letter: Character = Character(letterButton.lowercased())
        actualGame.letterGuessed(aLetter: letter)
        updateStats()
    }
    
    func updateStats(){
        if actualGame.aWord == actualGame.formattedWord(){
            wins += 1
        }
        else if actualGame.leftMoves == 0{
            losses += 1
        }
        UpdateUi()
    }
    
}

