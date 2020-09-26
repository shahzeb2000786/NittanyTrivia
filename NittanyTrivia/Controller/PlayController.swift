//
//  PlayController.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 7/22/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PlayController: UIViewController {
    
   let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.
    
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
    enableOrDisableOptions(enable: false)
    self.nextQuestion() //updates the questionsToAskUser to a random question from the questions database
    
        
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
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionsToAskUser[0].correctOption)
        
        sender.backgroundColor = color
        isGameOver(Color: color)

    }
    
    @IBAction func secondOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionsToAskUser[0].correctOption)
        sender.backgroundColor = color
       isGameOver(Color: color)

    }
    
    @IBAction func thirdOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionsToAskUser[0].correctOption)
        sender.backgroundColor = color
        isGameOver(Color: color)
    }
    
    @IBAction func fourthOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionsToAskUser[0].correctOption)
        sender.backgroundColor = color
        isGameOver(Color: color)
    }
    


    
    func nextQuestion(){
        getQuestion(numOfQuestions: 1) //changes the the global questionsToAskUser variable
        firstOption.backgroundColor = UIColor.white
        secondOption.backgroundColor = UIColor.white
        thirdOption.backgroundColor = UIColor.white
        fourthOption.backgroundColor = UIColor.white
           
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // updates ui with a delay, while firebase fetches data
            self.enableOrDisableOptions(enable: true)
            self.question.text? = (questionsToAskUser[0]).question
            self.firstOption.setTitle(questionsToAskUser[0].option1, for: .normal)
           self.secondOption.setTitle(questionsToAskUser[0].option2, for: .normal)
           self.thirdOption.setTitle(questionsToAskUser[0].option3, for: .normal)
           self.fourthOption.setTitle(questionsToAskUser[0].option4, for: .normal)
           self.changeBarUI(category: questionsToAskUser[0].category)
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
            let userDocRef = db.collection("Users").document(appDelegate.email)
            userDocRef.getDocument { (document, error) in
                if let document = document {
                    print(document.data())
                    let currentPoints = document.get("points") as! Int //user's total points from fbase
                    let finalPoints = currentPoints + self.currentScore
                    document.reference.updateData(["points" : finalPoints])//
                }//end of if
            }//end of userDocref
        
        }//end of if Color == UIColor.red

        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.nextQuestion() //updates the questionsToAskUsers to a random question from the questions database
            }//end of dispatchqueue
        }//end of else
    }//end isGameOver
}//end of extension




//extension deals with changing top bar color and category image depending on the question category.
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

//extension deals with disabling/enabling user interaction with option choices to prevent game from crashing if user clicks on an option before the question is loaded
extension PlayController{
    func enableOrDisableOptions(enable: Bool){
            self.firstOption.isUserInteractionEnabled = enable
            self.secondOption.isUserInteractionEnabled = enable
            self.thirdOption.isUserInteractionEnabled = enable
            self.fourthOption.isUserInteractionEnabled = enable
    }
}
