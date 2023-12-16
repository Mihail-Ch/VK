//
//  GroupsViewController.swift
//  VK
//
//  Created by Михаил Чертов on 20.11.2023.
//

import UIKit

class GroupsViewController: UIViewController {
    
    private var groups: [Groups] = []
    lazy var vkApi = VKApi()
    private var fileCash = FileCache()
    
    //MARK: - Element UI
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: GroupTableViewCell.reuseId)
        return tableView
    }()

    //MARK: - Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groups = fileCash.fetchGroups()
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = .clear
        title = "Группы"
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        vkApi.getGroups { [weak self] result in
            switch result {
            case .success(let groups):
                self?.groups = groups
                self?.fileCash.addGroups(groups: groups)
                self?.tableView.reloadData()
            case .failure(_):
                self?.groups = self?.fileCash.fetchGroups() ?? []
                self?.showAlert()            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension GroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.reuseId, for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }
        let group = groups[indexPath.row]
        cell.configureCell(avatar: group.avatar, title: group.name, description: group.caption)
        return cell
    }
 
}

extension GroupsViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}


private extension GroupsViewController {
    
    func showAlert() {
        let alert = UIAlertController(title: "Не удалось получить данные",
                                      message: "Данные загружены из последнего обновления",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
