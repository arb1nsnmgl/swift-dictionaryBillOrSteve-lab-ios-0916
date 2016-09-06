//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayFact: UILabel!
    @IBOutlet weak var endDisplay: UILabel!
    @IBOutlet weak var viewGame: UIView!
    @IBOutlet weak var displayCount: UILabel!
    
    var funFact = [ String : [String]]()
    var currentFact = ("", 0)
    var count = 1
    var score = 0
    
    @IBAction func steveButton(sender: UIButton) {
        
        if count < 9 {
            
            if let funFactSteve = funFact["Steve Jobs"] {
                if funFactSteve.contains(displayFact.text!) {
                    print("CORRECT!")
                    removeFact(currentFact); print(funFact)
                    addCount()
                } else {
                    print("Wrong! It's Bill Gates!")
                    removeFact(currentFact); print(funFact)
                    count += 1;
                    showFact(); displayCount.text = "\(count) / 9"
                }
                
            }
            
        } else if count == 9 {
            if funFact["Steve Jobs"]!.contains(displayFact.text!) {
                print("CORRECT!")
                score += 1
                endGame()
            } else {
                print("Wrong! It's Bill Gates!")
                endGame()
            }
            
        }
        
        
    }
    
    @IBAction func billButton(sender: UIButton) {
        
        if count < 9 {
            
            if let funFactBill = funFact["Bill Gates"] {
                if funFactBill.contains(displayFact.text!) {
                    print("CORRECT!")
                    removeFact(currentFact); print(funFact)
                    addCount()
                } else {
                    print("Wrong! It's Steve Jobs!")
                    removeFact(currentFact); print(funFact)
                    count += 1
                    showFact(); displayCount.text = "\(count) / 9"
                }
                
            }
            
            
        }  else if count == 9 {
            if funFact["Bill Gates"]!.contains(displayFact.text!) {
                print("CORRECT!")
                score += 1
                endGame()
            } else {
                print("Wrong! It's Steve Jobs!")
                endGame()
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewGame.userInteractionEnabled = true
        endDisplay.hidden = true
        displayCount.text = "\(count) / 9"
        createFacts();
        currentFact = getRandomFact()
        displayFact.text = funFact[currentFact.0]![currentFact.1]
        print(funFact)
        print("Fact #\(count) : \(currentFact.0) fact #\(currentFact.1 + 1)")
        print("Current fact is \(currentFact)")
        
    }
    
    func randomNumberFromZeroTo(number: Int) -> Int {
        return Int(arc4random_uniform(UInt32(number)))
    }
    
    func randomPerson() -> String {
        let randomNumber = arc4random_uniform(2)
        
        if randomNumber == 0 {
            return "Steve Jobs"
        } else {
            return "Bill Gates"
        }
    }
    
    func createFacts() {
        
        funFact["Bill Gates"] = ["He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.", "He scored 1590 (out of 1600) on his SATs.", "His foundation spends more on global health each year than the United Nation's World Health Organization.", "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.", "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."]
        funFact["Steve Jobs"] = ["He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.", "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.", "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.", "He was a pescetarian, meaning he ate no meat except for fish."]
    }
    
    func getRandomFact() -> (String, Int) {
        
        let person = randomPerson()
        let factNum = randomNumberFromZeroTo(funFact[person]!.count)
        if funFact[person]?.isEmpty == false {
            currentFact = (person, factNum)
            return currentFact
        } else {
            if funFact["Steve Jobs"]?.isEmpty == true {
                currentFact = ("Bill Gates", randomNumberFromZeroTo(funFact["Bill Gates"]!.count))
            } else if funFact["Bill Gates"]?.isEmpty == true {
                currentFact = ("Steve Jobs", randomNumberFromZeroTo(funFact["Steve Jobs"]!.count))
            }
            return currentFact
        }
        
    }
    
    func showFact() {
        let fact = getRandomFact()
        if let firstFact = funFact[fact.0] {
            print("Fact #\(count) : \(fact.0) fact #\(fact.1 + 1)")
            print("Current fact is \(currentFact)")
            displayFact.text = firstFact[fact.1]
        }
    }
    
    func endGame() {
        
        print("That's all folks")
        endDisplay.hidden = false
        endDisplay.text = "That's all folks"
        viewGame.userInteractionEnabled = false; displayFact.text = "Your score is \(score)."
    }
    
    func addCount() {
        count += 1; score += 1
        showFact(); displayCount.text = "\(count) / 9"
        
    }
    
    func removeFact(fact: (name: String, factNum: Int)) {
        funFact[fact.name]?.removeAtIndex(fact.factNum)
    }
}
