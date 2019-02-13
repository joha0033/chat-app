//
//  User.swift
//  chat-app-02-2019
//
//  Created by WebLedDevelopment on 2/12/19.
//  Copyright © 2019 WebLedDevelopment. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class User: NSObject {
    var username: String
    var email: String
    var uid: String
    var profileImageURL: String
    
    init(uid:String, username:String, email:String, profileImageURL: String) {
        self.username = username
        self.email = email
        self.uid = uid
        self.profileImageURL = profileImageURL
    }
    
    func getProfileImage() -> UIImage {
        if let url = NSURL(string: profileImageURL){
            if let data = NSData(contentsOf: url as URL){
                return UIImage(data: data as Data)!
            }
        }
        return UIImage()
    }
    
    func uploadProfileImage(_ profileImage: UIImage) {
        let profileImageRef = Storage.storage().reference().child("profileImages").child("\(NSUUID().uuidString).jpg")
        
        if let imageData = profileImage.jpegData(compressionQuality: 0.25) {
            profileImageRef.putData(imageData, metadata:nil) {
                metadata, error in
                if error != nil {
                    return
                } else{
                    profileImageRef.downloadURL {
                        url, error in
                        let downloadUrl = (url?.absoluteString)!
                        if self.profileImageURL == "" {
                            self.profileImageURL = downloadUrl
                            FirebaseManager.databaseRef.child("users").child(self.uid).updateChildValues(["profileImageURL": downloadUrl])
                        }
                        
                    }
                }
            }
        }
    }
}
        

