//
//  FriendsViewController.swift
//  VK
//
//  Created by Михаил Чертов on 20.11.2023.
//

import UIKit

class FriendsViewController: UIViewController {
    
    private var friends: [Friends] = []
    lazy var vkApi = VKApi()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.reuseId)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Друзья"
        view.addSubview(tableView)
        navigationController?.navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.delegate = self
       
        vkApi.getFriends { [weak self] friend in
            self?.friends = friend
            DispatchQueue.main.async {
                    self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
   
}


//MARK: TableView DataSource

extension FriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseId, for: indexPath) as? FriendsTableViewCell else { return UITableViewCell() }
        let friend = friends[indexPath.row]
        cell.configure(avatar: friend.avatar, firstName: friend.firstName, lastName: friend.lastName, city: friend.city?.title, online: friend.online)
       
        return cell
    }
    
    
}

//MARK: TableView Delegate

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ChatViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}


