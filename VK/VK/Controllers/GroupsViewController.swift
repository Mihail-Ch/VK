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
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: GroupTableViewCell.reuseId)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Группы"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        vkApi.getGroups { [weak self] group in
            self?.groups = group
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

extension GroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.reuseId, for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }
        let group = groups[indexPath.row]
        cell.configureCell(avatar: group.avatar, title: group.name, description: nil)
        return cell
    }
 
}

extension GroupsViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
