//
//  UserViewController.swift
//  A3
//
//  Created by Руслан Ахриев on 19.09.2018.
//  Copyright © 2018 Руслан Ахриев. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        downloadUserList()
    }
    
    func downloadUserList() {
        DataService.instance.getUsers { (request) in
            self.users = request
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhoto" {
            if let destinationVC = segue.destination as? UsersPhotoViewController {
                if let user = sender as?  User {
                    destinationVC.user = user
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        performSegue(withIdentifier: "ShowPhoto", sender: user)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
