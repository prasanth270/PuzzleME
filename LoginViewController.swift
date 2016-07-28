//
//  LoginViewController.swift
//  PuzzleMe
//
//  Created by Prasanth Ramineni on 7/18/16.
//  Copyright © 2016 Prasanth Ramineni. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    
    @IBOutlet weak var appTitleLael: UILabel!
    @IBOutlet weak var googleSignIn: GIDSignInButton!
    @IBOutlet weak var appIconImageView: UIImageView!
    
    // Take User to Profile Page if Already Signed In
    override func viewWillAppear(animated: Bool) {
        
        // Google Sign In Instance
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Check if user is signed in
        FIRAuth.auth()?.addAuthStateDidChangeListener{ auth, user in
            if let user = user { // User Logged In
                print("USer Id" + user.uid)
                if let view = self.storyboard!.instantiateViewControllerWithIdentifier( "UserProfileViewController") as? UserProfileViewController {
                    self.presentViewController(view, animated: true, completion: nil)
                    view.userName = user.displayName
                    view.imageURl = user.photoURL
                    view.userID = user.uid
                }
            } else { // User Not Logged In
                // Log Info and Stay in the Same page
                print("User Not Signed")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //try! FIRAuth.auth()!.signOut()
        
        // Sign In User automatically
        // GIDSignIn.sharedInstance().signInSilently()
    }
    
//    // Sign Out from Firebase
//    @IBAction func signOutUser(sender: UIButton) {
//        print("Log Out Clicked")
//        GIDSignIn.sharedInstance().signOut()
//        try! FIRAuth.auth()!.signOut()
//        
//    }

}
