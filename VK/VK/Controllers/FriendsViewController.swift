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
        view.backgroundColor = .systemBackground
        title = "Друзья"
        view.addSubview(tableView)
        setupView()
      
        tableView.dataSource = self
        tableView.delegate = self
       
        vkApi.getFriends { [weak self] friend in
            self?.friends = friend
            self?.tableView.reloadData()
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupView() {
        
        let profileRightButton = createCustomButton(imageName: "person", selector: #selector(clickButton))
        
        self.navigationItem.rightBarButtonItem = profileRightButton
        
    }
    
    @objc func clickButton() {
        let profileController = ProfileViewController()
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.type = .fade
        animation.duration = 1.5
        navigationController?.view.layer.add(animation, forKey: nil)
        self.navigationController?.pushViewController(profileController, animated: false)
        
    }
   
}

//MARK: - NavigationBarButton

extension FriendsViewController {
    
    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
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
        cell.button = {
            let chatController = ChatViewController()
            self.navigationController?.pushViewController(chatController, animated: true)
        }
       
        return cell
    }
    
    
}

//MARK: TableView Delegate

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}


