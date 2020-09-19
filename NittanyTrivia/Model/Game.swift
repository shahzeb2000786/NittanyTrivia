//
//  Firebase.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 8/5/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//

import Foundation
import Firebase


var currentGameID: Int?


//struct which contains stats of players
struct playerStats {
    var coins: Int
    var points: Int
    var draws: Int
    var wins: Int
    var losses: Int
    var gamesPlayed: Int
}

struct Game{
    var isChallenger: Bool
    var enemy: String
    var questionsAnswered: Int
    var enemyQuestionsAnswered: Int
    var id: Int
}


let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.


var randomEnemy: [String: Any] = ["email": "JaneDoe@mail.com:"] //will contain a random user when getRandomEnemy is executed
var userToReturn: [String: Any] = ["email": "JaneDoe@mail.com"]


//getRandomEnemy queries the Users database and randomly finds an opponent foer the user to go against when the user clicks new game for versus mode. Creates a randomSortNum which is compared to the "randomSortNum" field in the user's collection to find a possible list random users and then draws a one random user from this list and assigns it to the variable "randomEnemy"
func deleteGames(userName: String, EnemyName: String){
    
}
func getRandomEnemy()  {
    var usersCollection = db.collection("Users")
    let randomSortNum = Int.random(in: 0..<500)//used to query collection to find

    var randomUsers = usersCollection.whereField("randomSortNum", isGreaterThan: randomSortNum)
    .order(by: "randomSortNum")
    randomUsers.getDocuments { (users, error) in
        if let err = error {
            print(error!.localizedDescription)
        }//if
        else{
            if let users = users {
                var userList =  (users.documents)
                for users in userList{
                    if (users.data()["email"] as! String == appDelegate.email){
                        userList.remove(at: userList.firstIndex(of: users)!)
                    }//if
                }//for
                var user = userList.randomElement()
                

                if (user == nil){//chooses new enemy if user is nil by calling getNewEnemy
                    print("Another enemy needs to be found")
                    getNewRandomEnemy(randomSortNum: randomSortNum)
                    print(randomEnemy["email"])
                }
                else{
                    randomEnemy = user?.data() as! [String : Any]
                }
                print(randomEnemy)
            }//if
        }//else
    }//getDocuments
}//getRandomEnemy




//getNewRandonEnemy is called inside of  the function getRandomEnemy, if getRandomEnemy ended up not returning any user. getNewRandomUser searches for enemies whose id values are less than the randomSortNum while getRandomEnemy searches id values greater than randomSortNum, guaranteeing that an enemy is found.
func getNewRandomEnemy(randomSortNum: Int)  {
    let usersCollection = db.collection("Users")
    var randomUsers = usersCollection.whereField("randomSortNum", isLessThan: randomSortNum)
        .order(by: "randomSortNum")
    randomUsers.getDocuments { (users, error) in
        if let error = error {
            print (error)
        }//if
        else{
            if let users = users{
                var userList = users.documents
                for users in userList{
                    if (users.data()["email"] as! String == appDelegate.email){
                        userList.remove(at: userList.firstIndex(of: users)!)
                    }//if
                }//for
                var userData = userList.randomElement()?.data()
                print(userData as! [String: Any])
            
                randomEnemy = userData as! [String: Any]
                
            }//if
        }//else
    }//getDocuments
}//getNewRandomEnemy


//createGame adds a new game into the user's "game" field when they click on the play button, and end up challenging someone random. 
func createGame(questionsAnswered: Int){//questionsAnswered is num of question user answered correctly
    getRandomEnemy()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        var currentGames = [Any]()
        var currentEnemyGames = [Any]()
        let currentUser = db.collection("Users").document(appDelegate.email)
        let currentEnemy = db.collection("Users").document(randomEnemy["email"] as! String)
        
        
        currentUser.getDocument { (document , error) in
            if let error = error {
                print (error)
            }//if
            else{
                if let document = document{
                    currentGames = document.get("versus.games") as! [Any]
                    let  gameID = Int.random(in: 0...100000)
                    currentGames.append(["isChallenger": true, "enemy": randomEnemy["email"], "questionsAnswered": questionsAnswered, "enemyQuestionsAnswered": 0, "id": gameID])
                    currentUser.updateData(["versus.games" : currentGames])
                    createEnemyGame(id: gameID, opponentQuestionsAnswered: questionsAnswered)
                }//if
            }//else
        }//getDocument
    }//dispatchqueue
}//createGame


//createEnemyGame creates a game for a randomlu chosen "enemy" when another clicks the play button and is called in "createGame" to silmulataneously create two games, for both users when one user clicks "play". opponentQuestionsAnswered is the num of questions the opponent for the enemy answered
func createEnemyGame(id: Int, opponentQuestionsAnswered: Int){
    var currentEnemyGames = [Any]()
    let currentEnemy = db.collection("Users").document(randomEnemy["email"] as! String)
    currentEnemy.getDocument { (document, error) in
        if let error = error {
            print(error.localizedDescription)
        }//if
        else{
            if let document = document{
                currentEnemyGames = document.get("versus.games") as! [Any]
                currentEnemyGames.append(["isChallenger": false, "enemy": appDelegate.email, "questionsAnswered": 0, "enemyQuestionsAnswered": opponentQuestionsAnswered, "id": id])
                currentEnemy.updateData(["versus.games" : currentEnemyGames])
            }//if
        }//else
    }//get document
}//createEnemyGame



//The gamdID will be set passed into function through variable stored in this game.swift file, which gets changed  when a user clicks on a challenger's game. The questionsAnswered parameter is the number of questions that the user answered NOT the enemy challenger's questions.
func endGame(gameID: Int, questionsUserAnswered: Int,isGameBeingDeleted: Bool){
    let currentUser = db.collection("Users").document(appDelegate.email)
    currentUser.getDocument { (document, error) in
        if let error = error {
            print(error.localizedDescription)
        }//if
        else{
            

            if let document = document{
                var currentGames = document.get("versus.games") as! [NSDictionary]//gets all of user's games
                var gameLogs = document.get("versus.gameLogs") as! [NSDictionary]//gets game logs
                if gameLogs.count == 10 && isGameBeingDeleted == false {
                    gameLogs.remove(at: gameLogs.count - 1 )
                }
                var gameIndex = 0
                
                for var game in currentGames {//finds the game with the designated id within the array
                    if game.value(forKey: "id") as! Int == gameID {
                        
                        currentGames.remove(at: gameIndex)
                        if (isGameBeingDeleted == false){//executes if game is accepted and finished
                            game.setValue(questionsUserAnswered, forKey: "questionsAnswered")
                            gameLogs.append(game)
                           
                        }//if
                        print("HELOOOOOOOOO")
                        print("HELOOOOOOOOO")
                        print("HELOOOOOOOOO")
                        print("HELOOOOOOOOO")
                        print("HELOOOOOOOOO")
                        print("HELOOOOOOOOO")

                        currentUser.updateData(["versus.games" : currentGames, "versus.gameLogs": gameLogs])
                        endEnemyGame(enemyAnswered: game.value(forKey: "enemyQuestionsAnswered") as! Int, userAnswered: questionsUserAnswered, enemyName: game.value(forKey: "enemy") as! String, currentUserSnapshot: document, gameID: gameID, isGameBeingDeleted: isGameBeingDeleted)
                       
                        break
                    }//if
                gameIndex += 1
            }//for
        }//else
    }//getDocument
}//endgame


//this function will will end the game for the challenger. enemyAnswered refers to the number of questions that the challenger answered and userAnswered refers to the number fo questions that the non challenger answered.
    func endEnemyGame(enemyAnswered: Int, userAnswered: Int, enemyName: String, currentUserSnapshot: DocumentSnapshot, gameID: Int, isGameBeingDeleted: Bool ){
    let currentUser = db.collection("Users").document(appDelegate.email)
    let enemyUserReference = db.collection("Users").document(enemyName)
    enemyUserReference.getDocument { (enemyUser, error) in
        if let error = error {
            print(error.localizedDescription)
            return
        }//if
        if let enemyUser = enemyUser {
            
            let stats = updateWins(enemyAnswered: enemyAnswered, userAnswered: userAnswered, currentUserSnapshot: currentUserSnapshot, enemyUserSnapshot: enemyUser)
            let userStats = stats[0]
            let enemyStats = stats[1]
            
            var currentEnemyGames = enemyUser.get("versus.games") as! [NSDictionary]
            var gameLogs = enemyUser.get("versus.gameLogs") as! [NSDictionary]//gets game logs
            if gameLogs.count == 10 && isGameBeingDeleted == false{
                gameLogs.remove(at: gameLogs.count - 1 )
            }
            
            var gameIndex = 0
            for var game in currentEnemyGames {//finds the game with the designated id within the array
                if game.value(forKey: "id") as! Int == gameID {
                   
                    currentEnemyGames.remove(at: gameIndex)
                    if (isGameBeingDeleted == true){
                        enemyUserReference.updateData(["versus.games" : currentEnemyGames, "versus.gameLogs": gameLogs])
                        return
                    }
                    game.setValue(userAnswered, forKey: "enemyQuestionsAnswered")
                    gameLogs.append(game)
                    
                    enemyUserReference.updateData(["coins": enemyStats.coins, "points": enemyStats.points, "versus.games" : currentEnemyGames, "versus.gameLogs": gameLogs, "versus.wins": enemyStats.wins, "versus.losses": enemyStats.losses, "versus.draws": enemyStats.draws, "versus.gamesPlayed": enemyStats.gamesPlayed ])
                    
                    currentUser.updateData(["coins": userStats.coins, "points": userStats.points, "versus.wins": userStats.wins, "versus.losses": userStats.losses, "versus.draws": userStats.draws, "versus.gamesPlayed": userStats.gamesPlayed])
                    break
                }//if
            gameIndex += 1
            }//for
        }//if
    }//getDocument
}//endEnemyGame
}

    


func updateWins(enemyAnswered: Int, userAnswered: Int, currentUserSnapshot: DocumentSnapshot, enemyUserSnapshot: DocumentSnapshot ) -> [playerStats] {

    var enemyVersusDoc = enemyUserSnapshot.get("versus") as! NSDictionary
    var userVersusDoc = currentUserSnapshot.get("versus") as! NSDictionary
    
    var userWins = userVersusDoc.value(forKey: "wins") as! Int
    var userLosses = userVersusDoc.value(forKey: "losses") as! Int
    var userDraws = userVersusDoc.value(forKey: "draws") as! Int
    var userGamesPlayed = userVersusDoc.value(forKey: "gamesPlayed") as! Int
    var userCoins = currentUserSnapshot.get("coins") as! Int
    var userPoints = currentUserSnapshot.get("points") as! Int
    
    var enemyWins = enemyVersusDoc.value(forKey: "wins") as! Int
    var enemyLosses = enemyVersusDoc.value(forKey: "losses") as! Int
    var enemyDraws = enemyVersusDoc.value(forKey: "draws") as! Int
    var enemyGamesPlayed = enemyVersusDoc.value(forKey: "gamesPlayed") as! Int
    var enemyCoins = enemyUserSnapshot.get("coins") as! Int
    var enemyPoints = enemyUserSnapshot.get("points") as! Int
    
    enemyGamesPlayed += 1
    userGamesPlayed += 1
    if userAnswered > enemyAnswered{//occurs if the challenger loses
        
        userWins += 1
        enemyLosses += 1
        userCoins += 40
        userPoints += 20
          
       }//if
       else if (userAnswered < enemyAnswered){//occurs if challenger wins
           userLosses += 1
           enemyWins += 1
           enemyCoins += 40
           enemyPoints += 20
       }//else if
       else{//takes into account a tie between users
           userDraws += 1
           enemyDraws += 1
        
           userCoins += 10
           enemyCoins += 10
        
           enemyPoints += 10
           userPoints += 10
       }//else
    
    let enemyStats =  playerStats(coins: enemyCoins, points: enemyPoints, draws: enemyDraws, wins: enemyWins, losses: enemyLosses, gamesPlayed: enemyGamesPlayed)
    let userStats = playerStats(coins: userCoins, points: userPoints, draws: userDraws, wins: userWins, losses: userLosses, gamesPlayed: userGamesPlayed )
    return [userStats,enemyStats]
}//updateWins



