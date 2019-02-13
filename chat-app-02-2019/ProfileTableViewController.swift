//
//  ProfileTableViewController.swift
//  chat-app-02-2019
//
//  Created by WebLedDevelopment on 2/11/19.
//  Copyright © 2019 WebLedDevelopment. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    var selectedUser: User?
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.reloadData()
        ProfileManager.fillUsers {
            () in
            DispatchQueue.main.async {
                print("reload data?!")
                self.tableView.reloadData()
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileManager.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableViewCell
        
        let u = ProfileManager.users[indexPath.row]
        
        cell.cellName.text = u.username
        
        if u.profileImageURL != "" {
            cell.cellImage.image = u.getProfileImage()
        } else {
//          use default
            cell.cellImage.image = UIImage(named: "profile")
        }

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = ProfileManager.users[indexPath.row]
        self.performSegue(withIdentifier: "ShowChatView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChatView",
            let destinationViewController = segue.destination as? ChatController {
            destinationViewController.selectedUser = selectedUser
        } else if segue.identifier == "ShowSettingsView",
            let destinationViewController = segue.destination as? SettingsController {
            destinationViewController.selectedUser = ProfileManager.getCurrentUser(uid: FirebaseManager.currentUserID)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

@IBDesignable
extension UIImageView
{
    private struct AssociatedKey
    {
        static var rounded = "UIImageView.rounded"
    }
    
    @IBInspectable var rounded: Bool
        {
        get
        {
            if let rounded = objc_getAssociatedObject(self, &AssociatedKey.rounded) as? Bool
            {
                return rounded
            }
            else
            {
                return false
            }
        }
        set
        {
            objc_setAssociatedObject(self, &AssociatedKey.rounded, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            layer.cornerRadius = CGFloat(newValue ? 1.0 : 0.0)*min(bounds.width, bounds.height)/2
        }
    }
}
