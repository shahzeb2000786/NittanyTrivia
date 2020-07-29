//
//  Question.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 7/22/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import UIKit
import Firebase
let db = Firestore.firestore()

struct Question {
    let question: String
    let option1 : String
    let option2 : String
    let option3 : String
    let option4 : String
    let correctAnswer: String
  //  let category: String
//    let difficulty: String
}


//getQuestion draws reads items from the "questions" collection which contains trivia questions
func returnQuestion(question: String, option1: String, option2: String, option3: String, option4: String, correctAnswer: String) -> Question {
    let questionToReturn =  Question(question: question, option1: option1, option2: option2, option3: option3, option4: option4, correctAnswer: correctAnswer)
    print(questionToReturn)
    return questionToReturn
}

func getQuestion()  {
    
    db.collection("Questions").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            var totalQuestions: [Any]
            totalQuestions = []
            for document in querySnapshot!.documents {
               // print(document.data().values)
                totalQuestions.append(document.data().values.description)
            }//end of for loop
            
//            print(type(of: totalQuestions[0]))
//            print(totalQuestions[0])
//            let randQuestion = ((totalQuestions[1] as AnyObject))
//            print(type(of: randQuestion))

        }//end of else statement
        
    }//end of db.collection.getDocuments
}//end of getQuestion



let Question1 = Question(question: "Who was Penn State's first President?", option1: "Donald Trump", option2: "Eric Barron" , option3: "Lebron James", option4: "Evan Pugh", correctAnswer: "Evan Pugh")

let Question2 = Question(question: "Which one of these celebrities is a Penn State Alumnus", option1: "Ty Burell", option2: "Daniel Radcliffe" , option3: "Michael Vick", option4: "Kanye West", correctAnswer: "Ty Burell")

let Question3 = Question(question: "What does the H in the HUB building stand for", option1: "Hazlenut", option2: "Harbaugh" , option3: "Hannah", option4: "Hetzel", correctAnswer: "Hetzel")






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
