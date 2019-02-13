//
//  PostManager.swift
//  chat-app-02-2019
//
//  Created by WebLedDevelopment on 2/11/19.
//  Copyright © 2019 WebLedDevelopment. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PostManager: NSObject {
    static let databaseRef = Database.database().reference()
    static var posts = [Post]()
    
    static func createPost(username: String, text: String, fromId: String, toId:String){
        let p = Post(username: username, text: text, toId: toId)
        if p.text != "" {
            let uid = Auth.auth().currentUser?.uid
            let post = [
                "uid": uid,
                "username": p.username,
                "text": p.text,
                "toId": p.toId
            ]
            databaseRef.child("posts").childByAutoId().setValue(post)
        }
    }
    
    static func fillPosts(uid:String?, toId:String, completion: @escaping (_ result:String) -> Void) {
        posts = []
//        let allPosts = databaseRef.child("posts")
//        let _ = databaseRef.child("posts").queryOrdered(byChild: "uid").queryEqual(toValue: FirebaseManager.currentUser?.uid).observe(.childAdded, with: { snapshot in
//        })
        databaseRef.child("posts").queryOrdered(byChild: "uid").queryEqual(toValue: FirebaseManager.currentUser?.uid).observe(.childAdded, with: {
            snapshot in
            if let result = snapshot.value as? [String: AnyObject]{
                let toIdCloud = result["toId"] as! String
                if toIdCloud == toId {
                    let p = Post(username: result["username"] as! String, text: result["text"] as! String, toId: result["toId"] as! String)
                    PostManager.posts.append(p)
                }
            }
            completion("")
        })
        
    }
    
}

class Post {
    var username:String = ""
    var text:String = ""
    var toId:String = ""
    
    init(username: String, text: String, toId: String) {
        self.username = username
        self.text = text
        self.toId = toId
    }
}
