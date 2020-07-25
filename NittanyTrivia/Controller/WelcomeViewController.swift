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
let appDelegate = UIApplication.shared.delegate as! AppDelegate//creates a delegate of the UIapplication and downcasts it to be of type AppDelegate which will allow access to google sign in info variables in the appdelegate class.

class WelcomeViewController: UIViewController {

    
    func random() -> [String] {
        let userName = appDelegate.fullName
        let userEmail = appDelegate.email
        let userGivenName = appDelegate.givenName //given name is equivalent to firstname/nickname
        let userInfo = [userName,userEmail,userGivenName]
        return userInfo
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        print(random())
    }
    

}
