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

    @IBOutlet weak var googleButton: GIDSignInButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        googleButton.layer.cornerRadius = 20
        googleButton.sizeToFit()
       // print(setUserInfo())
       
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
         
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
                   print("howdy there")
                   self.performSegue(withIdentifier: "toHomePage", sender: self)
               }
               else{
                   print("not successful")
               }
           }
       } // google sign in method
}
