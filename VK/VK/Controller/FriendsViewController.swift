//
//  FriendsViewController.swift
//  VK
//
//  Created by Михаил Чертов on 28.12.2020.
//

import UIKit

class FriendsViewController: UIViewController {
    
    var friends = UserData.friendsFactory()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseId)

    }
}

//MARK: - DataSource

extension FriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let friend = friends[indexPath.row]
        cell.configure(name: friend.userName, avatar: UIImage(named: friend.avatar)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: - Delegate

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selected = friends[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "FriendsPhotoViewControllerKey") as! FriendsPhotoViewController
        vc.photo = selected
        self.show(vc, sender: nil)
        
    }
}
