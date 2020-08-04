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
   
    var currentScore = -1
    let questionChecker = QuestionChecker()//contains logic to check answers to questions
    var timeToDisplay = 15//the total amount of time user has to answer question
    var timerValue = 0// timeToDisplay - timerValue will be the will be the current time user has left
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    @IBOutlet weak var timerText: UILabel!
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var finalScoreText: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var gameOverView: UIView!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        
    topBarView.backgroundColor = UIColor(named: "celebritiesColor")
        
    self.nextQuestion() //updates the questionToAskUser to a random question from the questions database
    
        
    self.question.layer.cornerRadius = 20
    self.firstOption.layer.cornerRadius = 40
    self.secondOption.layer.cornerRadius = 40
    self.thirdOption.layer.cornerRadius = 40
    self.fourthOption.layer.cornerRadius = 40
    self.scoreText.layer.masksToBounds = true
    self.scoreText.layer.cornerRadius = scoreText.frame.width/4
    self.gameOverView.isHidden = true
        
        self.question.layer.masksToBounds = true
        self.question.layer.cornerRadius = 40
       // self.question.minimum
        self.question.numberOfLines = 2
        self.question.adjustsFontSizeToFitWidth = true
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.timer()
    }
    }//end of viewdidload
    
    

    
    @IBAction func firstOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        sender.backgroundColor = color
        isGameOver(Color: color)

    }
    
    @IBAction func secondOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        sender.backgroundColor = color
       isGameOver(Color: color)

    }
    
    @IBAction func thirdOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        sender.backgroundColor = color
        isGameOver(Color: color)
    }
    
    @IBAction func fourthOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        sender.backgroundColor = color
        isGameOver(Color: color)
    }
    


    
    func nextQuestion(){
        getQuestion() //changes the the global questionToAskUser variable
        firstOption.backgroundColor = UIColor.white
        secondOption.backgroundColor = UIColor.white
        thirdOption.backgroundColor = UIColor.white
        fourthOption.backgroundColor = UIColor.white
           
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // updates ui with a delay, while firebase fetches data
           self.question.text? = questionToAskUser.question
           self.firstOption.setTitle(questionToAskUser.option1, for: .normal)
           self.secondOption.setTitle(questionToAskUser.option2, for: .normal)
           self.thirdOption.setTitle(questionToAskUser.option3, for: .normal)
           self.fourthOption.setTitle(questionToAskUser.option4, for: .normal)
           self.changeBarUI(category: questionToAskUser.category)
            self.questionsCountAdder()
            self.timeToDisplay = 15
            self.timerText.text? = String(self.timeToDisplay)
       }//end of dispatchqeuue
        

    }//end of nextQuestion function
}//end of class



extension PlayController{//extension with question timer functionality
   
    func timer(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.timeToDisplay == 0{
                timer.invalidate()
                self.gameOverView.isHidden = false
            }
            else{
                self.timeToDisplay -= 1
                self.timerText.text? = String(self.timeToDisplay)
            }
        }//end of scheduled timer
    }//end of timer() function
}//end of extension



extension PlayController{//extension to deal with number of questions user has answered, also continuing or ending the game depending on user's answer
    func questionsCountAdder () {
        currentScore = currentScore + 1
        scoreText?.text = String(currentScore)
        finalScoreText?.text = "Score: " + String(currentScore)
    }
    
    func isGameOver(Color: UIColor){
        if Color == UIColor.red{
            gameOverView.isHidden = false
            timerText.text  = "0"
        }

        else{

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.nextQuestion() //updates the questionToAskUser to a random question from the questions database
            }//end of dispatchqueue
        }//end of else
    }//end isGameOver
}//end of extension





extension PlayController {
    func changeBarUI(category: String) {//changes topbarview color and category image depending on question category
        switch category {
        case "Sports":
            self.topBarView.backgroundColor = UIColor(named: "sportsColor") ?? UIColor.gray
            self.categoryImage.image = UIImage(systemName: "sportscourt")
        case "Misc":
            self.topBarView.backgroundColor = UIColor(named: "miscColor") ?? UIColor.gray
            self.categoryImage.image = UIImage(systemName: "questionmark")
        case "Celebrities":
            self.topBarView.backgroundColor = UIColor(named: "celebritiesColor") ?? UIColor.gray
            self.categoryImage.image = UIImage(systemName: "person")
        case "History":
            self.topBarView.backgroundColor = UIColor(named: "historyColor") ?? UIColor.gray
            self.categoryImage.image = UIImage(systemName: "book")
        default:
            self.topBarView.backgroundColor = UIColor.gray
        }
        
    }
}
