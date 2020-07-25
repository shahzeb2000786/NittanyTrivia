//
//  Question.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 7/22/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit

struct Question {
    let question: String
    let firstOption: String
    let secondOption: String
    let thirdOption: String
    let fourthOption: String
    let correctAnswer: String
    
}


let Question1 = Question(question: "Who was Penn State's first President?", firstOption: "Donald Trump", secondOption: "Eric Barron" , thirdOption: "Lebron James", fourthOption: "Evan Pugh", correctAnswer: "Evan Pugh")

let Question2 = Question(question: "Which one of these celebrities is a Penn State Alumnus", firstOption: "Ty Burell", secondOption: "Daniel Radcliffe" , thirdOption: "Michael Vick", fourthOption: "Kanye West", correctAnswer: "Ty Burell")

let Question3 = Question(question: "What does the H in the HUB building stand for", firstOption: "Hazlenut", secondOption: "Harbaugh" , thirdOption: "Lebron James", fourthOption: "Hetzel", correctAnswer: "Hetzel")






struct QuestionList {
    var questionNumber = 0
    let questionList = [Question1, Question2, Question3]
}


struct QuestionChecker {
    //function below checks if question is right and if it is returns green color, if not then it returns red
    func checkQuestion(selectedAnswer: String, correctAnswer: String) -> UIColor {
        if selectedAnswer == correctAnswer{
            return UIColor.green
        }
        return UIColor.red
    }
    
    
    
}
