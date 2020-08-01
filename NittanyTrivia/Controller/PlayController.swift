//
//  PlayController.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 7/22/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit

class PlayController: UIViewController {
   
    
    let questionChecker = QuestionChecker()//contains logic to check answers to questions
   
    var timeToDisplay = 15//the amount of time user has to answerquestion
    
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    @IBOutlet weak var timerText: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        var timerValue = 0//will be used to show the current time left for user to answer question
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.timeToDisplay == 0{
                timer.invalidate()
                self.timerText.text = "Time has ended"
            }
            else{
                self.timeToDisplay -= 1
                self.timerText.text? = String(self.timeToDisplay)
            }
        }//end of scheduled timer
        
        
        self.question.text? = questionToAskUser.question
        self.firstOption.setTitle(questionToAskUser.option1, for: .normal)
        self.secondOption.setTitle(questionToAskUser.option2, for: .normal)
        self.thirdOption.setTitle(questionToAskUser.option3, for: .normal)
        self.fourthOption.setTitle(questionToAskUser.option4, for: .normal)
        
        self.question.layer.cornerRadius = 20
        self.firstOption.layer.cornerRadius = 40
        self.secondOption.layer.cornerRadius = 40
        self.thirdOption.layer.cornerRadius = 40
        self.fourthOption.layer.cornerRadius = 40
    }
    
    

    
    @IBAction func firstOptionSelect(_ sender: UIButton) {
        sender.backgroundColor = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        self.nextQuestion()

    }
    
    @IBAction func secondOptionSelect(_ sender: UIButton) {
        sender.backgroundColor = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        self.nextQuestion()

    }
    
    @IBAction func thirdOptionSelect(_ sender: UIButton) {
        sender.backgroundColor = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        self.nextQuestion()
    }
    
    @IBAction func fourthOptionSelect(_ sender: UIButton) {
        sender.backgroundColor = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        self.nextQuestion()

    }
    
    
    @IBAction func nextQuestion(_ sender: UIButton) {

            self.nextQuestion()

    }
    

    
    
    
    
    
    func nextQuestion(){
        getQuestion() //changes the the global questionToAskUser variable
       // print(questionToAskUser)
        firstOption.backgroundColor = UIColor.white
        secondOption.backgroundColor = UIColor.white
        thirdOption.backgroundColor = UIColor.white
        fourthOption.backgroundColor = UIColor.white
           
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // updates ui with a delay, while firebase fetches data
          // Code you want to be delayed
           self.question.text? = questionToAskUser.question
           self.firstOption.setTitle(questionToAskUser.option1, for: .normal)
           self.secondOption.setTitle(questionToAskUser.option2, for: .normal)
           self.thirdOption.setTitle(questionToAskUser.option3, for: .normal)
           self.fourthOption.setTitle(questionToAskUser.option4, for: .normal)
       }//end of dispatchqeuue
        

    }//end of nextQuestion function
    

    
    
}//end of class


