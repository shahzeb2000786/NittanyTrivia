//
//  Versus.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 8/15/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit

class Versus: UIViewController{
    
    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var finalScoreText: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var timerText: UILabel!
    @IBOutlet weak var gameOverView: UIView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    
    var timeToDisplay = 15//the total amount of time user has to answer question
    var timerValue = 0// timeToDisplay - timerValue will be the will be the current time user has left
    var currentScore = 0
    var questionIndex = -1
    let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.
    
    override func viewDidLoad(){
        super.viewDidLoad()
        timer()
        self.question.layer.masksToBounds = true
         self.question.layer.cornerRadius = 40
        // self.question.minimum
         self.question.numberOfLines = 2
         self.question.adjustsFontSizeToFitWidth = true
        
        getQuestion(numOfQuestions: 10)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
           print(questionsToAskUser)
           print(randomEnemy["email"])
            self.nextQuestion()
        }//dispatchQueue
    }//viewDidLoad
    
    @IBAction func firstOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionsToAskUser[questionIndex].correctOption)
        
        sender.backgroundColor = color// updates color depending if user got question correct or not
        self.scoreAdder(colorToCheck: color)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.nextQuestion()
        }
    }//firstOptionSelect
    
    @IBAction func secondOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionsToAskUser[questionIndex].correctOption)
        sender.backgroundColor = color
        self.scoreAdder(colorToCheck: color)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.nextQuestion()
        }
    }//secondOptionSelect
    
    
    @IBAction func thirdOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionsToAskUser[questionIndex].correctOption)
        sender.backgroundColor = color
        self.scoreAdder(colorToCheck: color)
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           self.nextQuestion()
       }
    }//thirdOptionSelect
    
    @IBAction func fourthOptionSelect(_ sender: UIButton) {
        let color = questionChecker.checkQuestion(selectedOption: sender.titleLabel?.text ?? "Error" , correctOption: questionsToAskUser[questionIndex].correctOption)
        sender.backgroundColor = color
        self.scoreAdder(colorToCheck: color)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.nextQuestion()
        }
    }//fourthOptionSelect
    
    
    func nextQuestion(){
         firstOption.backgroundColor = UIColor.white
         secondOption.backgroundColor = UIColor.white
         thirdOption.backgroundColor = UIColor.white
         fourthOption.backgroundColor = UIColor.white
        self.questionsCountAdder()//updates score/score ui
        if self.isGameOver() == true {
            return
        }

         DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // updates ui with a delay
            self.question.text? = String(self.questionIndex + 1) + ".) " +  (questionsToAskUser[self.questionIndex]).question
            self.firstOption.setTitle(questionsToAskUser[self.questionIndex].option1, for: .normal)
            self.secondOption.setTitle(questionsToAskUser[self.questionIndex].option2, for: .normal)
            self.thirdOption.setTitle(questionsToAskUser[self.questionIndex].option3, for: .normal)
            self.fourthOption.setTitle(questionsToAskUser[self.questionIndex].option4, for: .normal)
            self.changeBarUI(category: questionsToAskUser[self.questionIndex].category)
            
             self.timeToDisplay = 15
             self.timerText.text? = String(self.timeToDisplay)
        }//end of dispatchqeuue

     }//end of nextQuestion function

}//end of class




extension Versus{//extension to deal with number of questions user has answered, keeping track of question index, also continuing or ending the game depending on user's answer
    
    func questionsCountAdder () {//gets triggered regardless of answer correctness
        self.questionIndex = self.questionIndex + 1
    }
    
    func scoreAdder(colorToCheck: UIColor){//gets executed if user answered question write
        if colorToCheck == UIColor.green {
            currentScore = currentScore + 1
            scoreText?.text = String(currentScore)
            finalScoreText?.text = "Score: " + String(currentScore)
        }
        
    }
    
    
    func isGameOver() -> Bool {
        if (questionIndex >= questionsToAskUser.count ){
            gameOverView.isHidden = false
           // timerText.text  = "0"
            createGame(questionsAnswered: self.currentScore)
            let userDocRef = db.collection("Users").document(appDelegate.email)
            userDocRef.getDocument { (document, error) in
                if let document = document {
                    //let currentPoints = document.get("points") as! Int //user's total points from fbase
                    //let finalPoints = currentPoints + self.currentScore
                   // document.reference.updateData(["points" : finalPoints])//
                }//end of if
            }//end of userDocref
            print (questionsToAskUser.count)
            return true
        }//end of if
        else {
            return false
        }
    }//end isGameOver
}//end of extension




//extension deals with changing top bar color and category image depending on the question category.
extension Versus {
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







extension Versus{//extension with question timer functionality
   
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



//extension Versus {
//    func giveFeedBack(finalScore: Int){
//        switch finalScore {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
//}
