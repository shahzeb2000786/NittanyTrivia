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
    var questionList = QuestionList() //contains the list of questions to ask as well a the current question Number
    
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getQuestion()
        question.text? = questionList.questionList[questionList.questionNumber].question
//        question.text? = Question1.question
        
        
        
        
//        firstOption.setTitle(questionList.questionList[questionList.questionNumber].firstOption, for: .normal)
//
//        secondOption.setTitle(questionList.questionList[questionList.questionNumber].secondOption, for: .normal)
//
//        thirdOption.setTitle(questionList.questionList[questionList.questionNumber].thirdOption, for: .normal)
//
//        fourthOption.setTitle(questionList.questionList[questionList.questionNumber].fourthOption, for: .normal)
        
        
        
    }
    
    
    
    @IBAction func firstOptionSelect(_ sender: UIButton) {
        sender.backgroundColor = questionChecker.checkQuestion(selectedAnswer: sender.titleLabel?.text ?? "Error" , correctAnswer: questionList.questionList[questionList.questionNumber].correctAnswer)
    }
    
    @IBAction func secondOptionSelect(_ sender: UIButton) {
        sender.backgroundColor = questionChecker.checkQuestion(selectedAnswer: sender.titleLabel?.text ?? "Error" , correctAnswer: questionList.questionList[questionList.questionNumber].correctAnswer)
    }
    
    @IBAction func thirdOptionSelect(_ sender: UIButton) {
        sender.backgroundColor = questionChecker.checkQuestion(selectedAnswer: sender.titleLabel?.text ?? "Error" , correctAnswer: questionList.questionList[questionList.questionNumber].correctAnswer)
    }
    
    @IBAction func fourthOptionSelect(_ sender: UIButton) {
        sender.backgroundColor = questionChecker.checkQuestion(selectedAnswer: sender.titleLabel?.text ?? "Error" , correctAnswer: questionList.questionList[questionList.questionNumber].correctAnswer)
    }
    
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        nextQuestion()
    }
    

    func nextQuestion(){
        //if questionNumber exceeds the index of the total question amount, it redirects the user back to the first question by setting the current question Numberto 0
        if (questionList.questionNumber + 1 == questionList.questionList.count){
            questionList.questionNumber = 0
        } else{
        questionList.questionNumber = questionList.questionNumber  + 1
        }
        
        
        
        //UI updates below (reset question asked and answer options and reset button background colors)
        firstOption.backgroundColor = UIColor.black
        secondOption.backgroundColor = UIColor.black
        thirdOption.backgroundColor = UIColor.black
        fourthOption.backgroundColor = UIColor.black
        
        
        question.text? =
            questionList.questionList[questionList.questionNumber].question
        
//        firstOption.setTitle(questionList.questionList[questionList.questionNumber].firstOption, for: .normal)
//
//        secondOption.setTitle(questionList.questionList[questionList.questionNumber].secondOption, for: .normal)
//
//        thirdOption.setTitle(questionList.questionList[questionList.questionNumber].thirdOption, for: .normal)
//
//        fourthOption.setTitle(questionList.questionList[questionList.questionNumber].fourthOption, for: .normal)
    
    }
    
}
