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


class WelcomeViewController: UIViewController {

    @IBOutlet weak var googleButton: GIDSignInButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        googleButton.layer.cornerRadius = 20
        googleButton.sizeToFit()
       // print(setUserInfo())
        
    }
    

}
