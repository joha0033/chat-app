//
//  ProfileManager.swift
//  FirebaseAuth
//
//  Created by WebLedDevelopment on 2/12/19.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ProfileManager: NSObject {
    static let databaseRef = Database.database().reference()
    static let uid = Auth.auth().currentUser?.uid
    static var users = [User]()
    
    static func getCurrentUser(uid:String)->User?{
        if let i = users.index(where: { $0.uid == uid }){
            return users[i]
        }
        return nil
    }
    
    static func fillUsers (completion: @escaping () -> Void){
        users = []
        databaseRef.child("users").observe(.childAdded, with: {
            snapshot in
            if let result = snapshot.value as? [String: AnyObject]{
                print(result, "<< The result that throws the error... wtf?")
                let uid = result["uid"]! as! String
                let username = result["username"]! as! String
                let email = result["email"]! as! String
                let profileImageURL = result["profileImageURL"]! as! String
                
                let u = User(uid: uid, username:username, email: email,profileImageURL: profileImageURL)
                ProfileManager.users.append(u)
            }
            completion()
        })
    }
    
}
