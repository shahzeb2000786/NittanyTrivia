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
    
    @IBOutlet weak var topBarView: UIView!
    
    @IBOutlet weak var question: UITextView!
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
   
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.timer()
            self.nextQuestion() //updates the questionToAskUser to a random question from the questions database
        }//end of dispatchqueue
        
    
        self.question.text? = questionToAskUser.question
        self.firstOption.setTitle(questionToAskUser.option1, for: .normal)
        self.secondOption.setTitle(questionToAskUser.option2, for: .normal)
        self.thirdOption.setTitle(questionToAskUser.option3, for: .normal)
        self.fourthOption.setTitle(questionToAskUser.option4, for: .normal)
        self.scoreText?.text = "0"
        
        self.question.layer.cornerRadius = 20
        self.firstOption.layer.cornerRadius = 40
        self.secondOption.layer.cornerRadius = 40
        self.thirdOption.layer.cornerRadius = 40
        self.fourthOption.layer.cornerRadius = 40
        self.scoreText.layer.masksToBounds = true
        self.scoreText.layer.cornerRadius = scoreText.frame.width/4
        self.gameOverView.isHidden = true
        
    }//end of viewdidload
    
    

    
    @IBAction func firstOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        sender.backgroundColor = color
        isGameOver(Color: color)
        //nextQuestion()

    }
    
    @IBAction func secondOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        sender.backgroundColor = color
       isGameOver(Color: color)
        //nextQuestion()

    }
    
    @IBAction func thirdOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        sender.backgroundColor = color
        isGameOver(Color: color)
        //nextQuestion()
    }
    
    @IBAction func fourthOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionToAskUser.correctOption)
        sender.backgroundColor = color
        isGameOver(Color: color)
        //nextQuestion()
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
           self.changeBarUI(category: questionToAskUser.category)
            self.questionsCountAdder()
            self.timer()
       }//end of dispatchqeuue
        

    }//end of nextQuestion function
}//end of class



extension PlayController{//extension with question timer functionality
   
    func timer(){
        var timeToDisplay = 15//the amount of time user has to answerquestion
        var timerValue = 0//will be used to show the current time left for user to answer question
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if timeToDisplay == 0{
                timer.invalidate()
                self.gameOverView.isHidden = false
            }
            else{
                timeToDisplay -= 1
                self.timerText.text? = String(timeToDisplay)
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
