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


struct Question {
    let question: String
    let option1 : String
    let option2 : String
    let option3 : String
    let option4 : String
    let correctOption: String
    let category: String
    let difficulty: String
}


//the questionToAskUser variable below, will be the question to show the user when they play and is initailized below
var questionToAskUser = Question(question: "", option1: "", option2: "", option3: "", option4: "", correctOption: "", category: "1", difficulty: "1")





//getQuestions reads items from the "questions" collection which contains trivia questions and randomly reassigns the value for the global "questionToAskUser" variable.
func getQuestion()  {
    var databaseReference = db.collection("Questions")
    let randomSortNum = Int.random(in: 0..<500)
    var questionsCollection = db.collection("Questions")
    var randomQuestion = questionsCollection.whereField("randomSortNum", isGreaterThan: randomSortNum)
        .order(by: "randomSortNum")
        .limit(to: 1)
    
    randomQuestion.getDocuments { (question, error) in
        if (error != nil){
            print(error!.localizedDescription)
        }
        else{
            if let questionToReturn = question{
                print(randomSortNum)
                if (questionToReturn.documents != []){
                    let questionData = questionToReturn.documents[0].data()
                    let question = ( questionData["question"]! as! String)
                    let option1 = ( questionData["option1"]! as! String)
                    let option2 = ( questionData["option2"]! as! String)
                    let option3 = ( questionData["option3"]! as! String)
                    let option4 = ( questionData["option4"]! as! String)
                    let correctOption = ( questionData["correctOption"]! as! String)
                    let category = ( questionData["category"]! as! String)
                    let difficulty = ( questionData["difficulty"]! as! String)
                    
                    
                    let randomlyGeneratedQuestion = returnQuestion(
                    question: question, option1: option1, option2: option2, option3:
                    option3, option4: option4, correctOption: correctOption,
                    category: category, difficulty: difficulty
                    )
                    
                    
                    
                    questionToAskUser = randomlyGeneratedQuestion
                    
               
                   // print(questionToAskUser)
                    
                }//end of inner if
            }//end of outer if
        }//end of else
    }// end of get documents
}//end of getQuestion

func returnQuestion(question: String, option1: String, option2: String, option3: String, option4: String, correctOption: String, category: String, difficulty: String) -> Question {
    let questionToReturn =  Question(question: question, option1: option1, option2: option2, option3: option3, option4: option4, correctOption: correctOption, category: category, difficulty: difficulty)
    print(questionToReturn)
    return questionToReturn
}




struct QuestionChecker {
    //function below checks if question is right and if it is returns green color, if not then it returns red
    func checkQuestion(selectedOption: String, correctOption: String) -> UIColor {
        if selectedOption == correctOption{
            print("correct")
            return UIColor.green
        }
        return UIColor.red
    }
    
    
    
    
}
