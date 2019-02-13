//
//  ViewController.swift
//  chat-app-02-2019
//
//  Created by WebLedDevelopment on 2/11/19.
//  Copyright © 2019 WebLedDevelopment. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButton_Tap(_ sender: Any) {
        FirebaseManager.Login(email: email.text!, password: password.text!) { (success) in
            if success {
                self.performSegue(withIdentifier: "ShowProfile", sender: sender)
            } else {
                print("something didnt work...")
            }
        }
    }
    
    @IBAction func createAccountButton_Tap(_ sender: AnyObject) {
        FirebaseManager.CreateAccount(email: email.text!, password: password.text!, username: username.text!) {
            (result:String) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "ShowProfile", sender: sender)
            }
        }
    }
    
}

