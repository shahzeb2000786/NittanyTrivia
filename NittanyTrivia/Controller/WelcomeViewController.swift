//
//  WelcomeViewController.swift
//  NittanyTrivia
//
//  Created by Shahzeb Ahmed on 7/21/20.
//  Copyright © 2020 Shahzeb Ahmed. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import GoogleSignIn
import AuthenticationServices


class WelcomeViewController: UIViewController, GIDSignInDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.

    
    @IBOutlet weak var appleView: UIButton!
    @IBOutlet weak var googleButton: GIDSignInButton!
   
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var signInStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var title = "Nittany Trivia"
        var time = 0.20
        for var letter in title {
            var letter = String(letter)
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.titleLabel?.text = (self.titleLabel?.text)! + (letter)
            }
            time += 0.20
        }
        
        appleView.isHidden = false
        setupAppleButton()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self //sets view controler as gidsignin delegate
        let savedEmail = appDelegate.userDefaults.value(forKey: "email")
        let savedAppleUID = appDelegate.userDefaults.value(forKey: "appleUID")
        if savedEmail != nil{
                GIDSignIn.sharedInstance()?.restorePreviousSignIn()         // Automatically sign in the user.
        }
        
//        if savedAppleUID != nil{
//            createAppleIDUser(userIdentifier: savedAppleUID as! String, firstName: "", lastName: "", email: "")
//        }

        titleLabel.minimumScaleFactor = 0.2
        titleLabel.adjustsFontSizeToFitWidth = true
        googleButton.layer.cornerRadius = 20
        googleButton.sizeToFit()
    
        navigationController?.navigationBar.isHidden = true
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        let db = Firestore.firestore()

         if let error = error {
           return
         }
         print("successful sign in")
         guard let authentication = user.authentication else { return }
         let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
  
         let idToken = user.authentication.idToken // Safe to send to the server
           Auth.auth().signIn(with: credential) { (User, Error) in    //authenticates user's sign in info
               if let userInfo = User {
                //sets global vars defined in app delegate, then performs segue to homepage
                self.appDelegate.email = user.profile.email
                self.appDelegate.userId = user.userID
                self.appDelegate.fullName = user.profile.name
                self.appDelegate.givenName = user.profile.givenName
                
                
                
                self.createUser(email: self.appDelegate.email)
                
               self.performSegue(withIdentifier: "toHomePage", sender: self)
                
               }
               else{
                   print("User could not be authenticated")
               }//else
           }
       } // google sign in method
    
    func createUser(email: String){
        db.collection("Users").whereField("email", isEqualTo: self.appDelegate.email)
        .getDocuments() { (querySnapshot, err) in
           if let err = err {
               print("Error getting documents: \(err)")
           } else {
               if (querySnapshot!.documents == []){
                db.collection("Users").document(email).setData([
                    "id": self.appDelegate.userId,
                    "firstName": self.appDelegate.givenName,
                    "lastName": self.appDelegate.fullName,
                    "email": self.appDelegate.email,
                    "points": 0,
                    "lives": 3,
                    "coins": 100,
                    "gems": 1,
                    "randomSortNum": Int.random(in: 0...100000),
                    "versus": ["wins": 0, "losses": 0, "draws": 0, "winRate": 0.0, "games": Array<Any>(), "gameLogs": Array<Any>(), "gamesPlayed": 0]
                    
                ])//setData
               }//if
           }//else
         }//getDocuments
    }//createUser function
    
    
    
    
    func setupAppleButton() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
       
        authorizationButton.frame = CGRect(x:0, y: 0, width: self.view.frame.width - 20, height: 50)
        self.signInStack.addSubview(authorizationButton)
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        print("button press logged")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    

    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let emails = appleIDCredential.email
            
            
            createAppleIDUser(userIdentifier: userIdentifier, firstName: fullName?.givenName ?? "h", lastName: fullName?.familyName ?? "h" , email: emails ?? "h", UID: userIdentifier)
        
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
           
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    
    
    func createAppleIDUser(userIdentifier: String, firstName: String, lastName: String, email: String, UID: String){
        db.collection("Users").whereField("id", isEqualTo: userIdentifier)
        .getDocuments() { (querySnapshot, err) in
           if let err = err {
               print("Error getting documents: \(err)")
           } else {
            if (querySnapshot!.documents == []){
                self.appDelegate.userDefaults.setValue(userIdentifier, forKey: "appleUID")
                self.appDelegate.email = email
                self.appDelegate.fullName = lastName
                self.appDelegate.givenName = firstName
                self.appDelegate.userId = UID
                db.collection("Users").document(email).setData([
                    "id": userIdentifier,
                    "firstName": firstName,
                    "lastName": lastName,
                    "email": email,
                    "points": 0,
                    "lives": 3,
                    "coins": 100,
                    "gems": 1,
                    "randomSortNum": Int.random(in: 0...100000),
                    "versus": ["wins": 0, "losses": 0, "draws": 0, "winRate": 0.0, "games": Array<Any>(), "gameLogs": Array<Any>(), "gamesPlayed": 0]
                    
                ])//setData
                self.performSegue(withIdentifier: "toHomePage", sender: self)
            }//if querysnapshot == []
            else{// occurs if querysnapshot is not null
                if let user = (querySnapshot?.documents[0].data()) {//user is dictionar
                    let appleUID = user["id"] as! String
                    
                    self.appDelegate.userDefaults.setValue(appleUID, forKey: "appleUID")
                    self.appDelegate.email = user["email"] as! String
                    self.appDelegate.fullName = user["lastName"] as! String
                    self.appDelegate.givenName = user["firstName"] as! String
                    self.appDelegate.userId = appleUID
                }
                self.performSegue(withIdentifier: "toHomePage", sender: self)
               
            }//else
           }//outer else
   
        }
    }//createAppleIdUser
    
    
}
    


    
