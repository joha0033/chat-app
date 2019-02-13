//
//  ChatController.swift
//  chat-app-02-2019
//
//  Created by WebLedDevelopment on 2/11/19.
//  Copyright © 2019 WebLedDevelopment. All rights reserved.
//

import UIKit

class ChatController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedUser: User?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userInput: UITextField!
    var cellHeight = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PostManager.fillPosts(uid: FirebaseManager.currentUser?.uid, toId:(selectedUser?.uid)!) { (result: String) in
            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PostManager.posts = []
    }
    
    @IBAction func sendButton_Tap(_ sender: AnyObject) {
        PostManager.createPost(username: (selectedUser?.username)!, text: userInput.text!, fromId: (FirebaseManager.currentUser?.uid)!, toId: (selectedUser?.uid)!)
        
        userInput.text = ""
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostManager.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
        let post = PostManager.posts[indexPath.row]
        cellHeight = Int(cell.messageText.contentSize.height)
        cell.messageText?.delegate = self
        cell.messageText?.text = post.text
        return cell
    }
}

extension ChatController:UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
}
