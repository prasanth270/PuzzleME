//
//  UserProfileViewController.swift
//  PuzzleMe
//
//  Created by Prasanth Ramineni on 7/20/16.
//  Copyright © 2016 Prasanth Ramineni. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class UserProfileViewController: UIViewController {
    
    // Initialiaze Handshake with FireBase Db
    var rootRef = FIRDatabase.database().reference()
    
    var userName: String!
    var imageURl: NSURL!
    var userID: String!
    var currentQuestion: String!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var letsGobutton: UIButton!
    @IBOutlet weak var logoutUser: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        welcomeLabel.text = "Welcome"
        userNameLabel.text = userName
        userImage.image = UIImage(data: NSData(contentsOfURL: imageURl)!)
        //Check if user already exists in Database
        checkUser()
    }
    
    @IBAction func logoutUser(sender: UIButton) {
        print("LogOut User")
        
        // Signout from Google
        GIDSignIn.sharedInstance().signOut()
        
        //Signout From Firebase
        try! FIRAuth.auth()!.signOut()
    }
    
    private func checkUser(){
        print(userID)
        rootRef.child("users")
            .queryOrderedByChild("userId")
            .queryEqualToValue(userID)
            .observeSingleEventOfType(.Value, withBlock :{ (snapshot) in
                print("Snapshot")
                if snapshot.hasChildren() {
                    for children in snapshot.children {
                        self.currentQuestion = children.value["currentQuestion"] as! String
                    }
                } else {
                    // Insert new User
                    self.newUser()
                }
        })
    }
    
    private func newUser(){
        print("Updating new User")
        
        //Generate AutoKey
        let key = rootRef.child("users").childByAutoId().key
        
        // Post Data
        let postData = [
            "userId" : userID,
            "currentQuestion" : "0"
        ]
        
        // Update Path
        let childUpdates = ["/users/\(key)/" : postData]
        
        // Update Children
        rootRef.updateChildValues(childUpdates)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "letsGoSegue" {
            if let destinationViewController  = segue.destinationViewController as? ViewController {
                //destinationViewController.dummy = currentQuestion
                destinationViewController.currQuestion = currentQuestion
                destinationViewController.userID = userID
            }
        }
        
        // Give an identifier for segue
        // Use Identifier to load view and send data to that view
        
    }
}
