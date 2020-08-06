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

class WelcomeViewController: UIViewController, GIDSignInDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.
    @IBOutlet weak var googleButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self //sets view controler as gidsignin delegate
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()         // Automatically sign in the user.
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
                
//                creates a default user on sign in.
                db.collection("Users").document(self.appDelegate.email).setData([
                    "id": self.appDelegate.userId,
                    "firstName": self.appDelegate.givenName,
                    "lastName": self.appDelegate.fullName,
                    "email": self.appDelegate.email,
                    "points": 0,
                    "lives": 3,
                    "coins": 100,
                    "gems": 1
                ])
                self.performSegue(withIdentifier: "toHomePage", sender: self)
                
               }
               else{
                   print("User could not be authenticated")
               }
           }
       } // google sign in method
}
