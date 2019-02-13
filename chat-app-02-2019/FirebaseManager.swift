//
//  FirebaseManager.swift
//  chat-app-02-2019
//
//  Created by WebLedDevelopment on 2/11/19.
//  Copyright © 2019 WebLedDevelopment. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager: NSObject {
    static let databaseRef = Database.database().reference()
    static var currentUserID:String = ""
//    static var currentUser:User? = nil
    static var currentUser: FirebaseAuth.User? = nil
    
    static func Login (email:String, password:String, completion: @escaping (_ success:Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
//                added the green bits, user, to make it work.. ?
//                print(authResult?.user.email as Any, "AUTH RESULT!")
                currentUser = authResult?.user
                currentUserID = (authResult?.user.uid)!
                print("currentUser: ", currentUser!.email!)
                print("currentUserID: ", currentUserID)
                completion(true)
            }
        })
    }
    
    static func CreateAccount(email: String, password: String, username: String, completion: @escaping (_ result: String)-> Void){
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            AddUser(email:email, username:username)
            Login(email:email, password:password){
                (success:Bool ) in
                if success {
                    print("login successful")
                } else {
                    print("login unsuccessful")
                }
            }
            completion("")
        })
    }
    
    static func AddUser(email:String, username:String) {
        let uid = Auth.auth().currentUser?.uid
        let post = [
            "uid": uid,
            "username": username,
            "email": email,
            "profileImageURL": ""
        ]
        
        databaseRef.child("users").child(uid!).setValue(post)
    }
}
