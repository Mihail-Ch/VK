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
    private var fileCash = FileCache()
   
    //MARK: - Element UI
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.reuseId)
        return tableView
    }()

    //MARK: - Live Cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        friends = fileCash.fetchFriends()
        title = "Друзья"
        view.addSubview(tableView)
        
        setupView()
      
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        
        getRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.backgroundColor = Theme.currentTheme.backgroundColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - Request
    
    private func getRequest() {
        
        vkApi.getFriends { [weak self] result in
            switch result {
            case .success(let friends):
                self?.friends = friends
                self?.fileCash.addFriends(friends: friends)
                self?.tableView.reloadData()
            case .failure(_):
                self?.friends = self?.fileCash.fetchFriends() ?? []
                self?.showAlert()
            }
        }
    }
    
    @objc func update() {
            vkApi.getFriends { [weak self] result in
                switch result {
                case .success(let friends):
                    self?.friends = friends
                    self?.fileCash.addFriends(friends: friends)
                    self?.tableView.reloadData()
                case .failure(_):
                    self?.friends = self?.fileCash.fetchFriends() ?? []
                    self?.showAlert()
                }
            }
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
            }
    }
    
    //MARK: - Method && @objc
    
    private func setupView() {
        let profileRightButton = createCustomButton(imageName: "person", selector: #selector(clickButton))
        self.navigationItem.rightBarButtonItem = profileRightButton
    }

    
    @objc func clickButton() {
        let profileController = ProfileViewController(isUserProfile: true)
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
        cell.buttonChat = {
            let chatController = ChatViewController()
            self.navigationController?.pushViewController(chatController, animated: true)
        }
        cell.tapProfileController = { [weak self] text, photo in
            self?.navigationController?.pushViewController(ProfileViewController(name: text, photo: photo, isUserProfile: false), animated: true)
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


private extension FriendsViewController {
    
    func showAlert() {
        let alert = UIAlertController(title: "Не удалось получить данные",
                                      message: "Данные загружены из последнего обновления",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
