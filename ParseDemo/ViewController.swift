//
//  ViewController.swift
//  ParseDemo
//
//  Created by Deepak on 11/28/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

var _CurrentUser : PFUser!

class ViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSignup(sender: AnyObject) {
//        var testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (succeeded: Bool!, error: NSError!) -> Void in
//            if error != nil {
//                println("error \(error)")
//            } else {
//                println("error \(error)")
//                println("succeeded \(succeeded)")
//            }
//        }
        
        var user = PFUser()
        user.username = userNameField.text
        user.password = passwordField.text
        user.email = emailField.text
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                println("Signed Up successfully")
                //Perform Segue to login Screen
                self.performSegueWithIdentifier("chatSegue", sender: self)
            } else {
                //let errorString = error.userInfo["error"]? as NSString
                // Show the errorString somewhere and let the user try again.
                println(" Sign up error")
            }
        }
    }

    @IBAction func onSignin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userNameField.text, password:passwordField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                println("Signed In successfully")
                _CurrentUser = user
                self.performSegueWithIdentifier("chatSegue", sender: self)
            } else {
                // The login failed. Check error to see why.
                println(" Sign in error")
            }
        }
        
    }
}

