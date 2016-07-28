//
//  ViewController.swift
//  PuzzleMe
//
//  Created by Prasanth Ramineni on 7/6/16.
//  Copyright © 2016 Prasanth Ramineni. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    // Initialiaze Handshake with FireBase Db
    var rootRef = FIRDatabase.database().reference()
    var userID : String!
    var currQuestion: String!
    
    // Initiliaze variables to hold question and user data
    var questionJson: Array<AnyObject>!
    var userJson: Array<AnyObject>!
    
    var question: String!
    var option1: String!
    var option2: String!
    var option3: String!
    var option4: String!
    var answer: Int!
    
    // UI Attributes
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var optionOne: UITextView!
    @IBOutlet weak var optionTwo: UITextView!
    @IBOutlet weak var optionThree: UITextView!
    @IBOutlet weak var optionFour: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var questionLabelView: UILabel!
    
    // ** Tap Touch Event Handlers //
    @IBAction func optionOneTap(sender: AnyObject) {
        print("Option 1")
        hintButton.setTitle("Heyyyaa", forState: .Normal)
        if answer == 1 {
            // Load a Success View Controller
            self.loadSuccessViewController()
        }
    }
    
    @IBAction func optionTwoTap(sender: AnyObject) {
        print("Option 2")
        if answer == 2 {
            // Load a Success View Controller
            self.loadSuccessViewController()
        }
    }
    
    @IBAction func optionThreeTap(sender: AnyObject) {
        print("Option 3")
        if answer == 3 {
            // Load a Success View Controller
            self.loadSuccessViewController()
        }
    }
    
    @IBAction func optionFourTap(sender: AnyObject) {
        print("Option 4")
        if answer == 4 {
            // Load a Success View Controller
            self.loadSuccessViewController()
        }
    }
    
    @IBAction func nextBtnClickAction(sender: AnyObject) {
        print("Next Button Clicked")
    }
    
    @IBAction func hintBtnClickAction(sender: AnyObject) {
        print("Hint Button Clicked")
    }
    // Tap Touch Event Handlers ** //
    
    
    // Setting attributes after view load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Set attributes before view load
    override func viewDidAppear(animated: Bool) {
        // Get User ID from here
        if let user = FIRAuth.auth()?.currentUser {
            print(user.uid)
        }
        
        print("Start of View Did Appear")
        // Call Completion Handler - Synchronous Code
        loadQuestionData()
//        loadUserData({
//            success in
//            if success {
//                self.loadQuestionData()
//            } else {
//                print("Error in User Data Completion Handler...")
//            }
//        })
        
        // Set UITextView Properties
        
        questionTextView.editable = false
        optionOne.editable = false
        optionTwo.editable = false
        optionThree.editable = false
        optionFour.editable = false
        
        // Set Label Attribute
        labelView.text = "Options"
        questionLabelView.text = "Question"
        
        print("End of View Did Appear")
    }
    
    // Completion Handler - Synchronous Code
//    private func loadUserData(completion: (Bool) -> ()){
//        print("Start of loadUserData()")
//        rootRef.child("0").child("users")
//            .queryOrderedByChild("userId")
//            .queryEqualToValue("578ab1a0e9c2389b23a0e870")
//            .observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//                
//                for child in snapshot.children {
//                    self.currQuestion = child.value["currentQuestion"] as! Int
//                }
//                print("Current Question is \(self.currQuestion)")
//                completion(true)
//                //print(snapshot.value as! Array<AnyObject>)
//                }, withCancelBlock : { error in
//                    print(error.description)
//            })
//        print("End of loadUserData()")
//    }
    
    // Load Question From Firebase
    private func loadQuestionData() {
        print("Loading Question Data...")
        print(currQuestion)
        rootRef.child("0").child("questions")
            .queryOrderedByChild("id")
            .queryEqualToValue(Int(currQuestion)).observeSingleEventOfType(.Value, withBlock: {
                (snapshot) in
                //print(snapshot.children)
                for child in snapshot.children {
                    self.question = child.value["question"] as! String
                    self.answer = child.value["answer"] as! Int
                    for option in child.value["options"] as! Array<[String: String]> {
                        for (key, value) in option {
                            if key.hasPrefix("option1"){
                                self.option1 = value
                            } else if key.hasPrefix("option2"){
                                self.option2 = value
                            } else if key.hasPrefix("option3"){
                                self.option3 = value
                            } else {
                                self.option4 = value
                            }
                        }
                    }
                }
                // Set UI Text Field Values
                print("Setting UI View Data to Variables...")
                self.questionTextView.text = self.question
                self.optionOne.text = self.option1
                self.optionTwo.text = self.option2
                self.optionThree.text = self.option3
                self.optionFour.text = self.option4
                
                // Reload Views After the Values are Set
                print("Reloading UI View Data...")
                self.reloadInputViews()
                
                })
        print("End of loadQuestionData")
    }
    
    // Load Success View Controller
    private func loadSuccessViewController(){
        if let view = self.storyboard?.instantiateViewControllerWithIdentifier("SuccessViewController") as? SuccessViewController {
            presentViewController(view, animated: true, completion: nil)
        }
    }
    
    // On Correct Choice, Update Current Question for userID
    private func updateCurrQuestion(){
        var nextQuestion = Int(currQuestion)!
        nextQuestion += 1
        
        //Update Child
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
