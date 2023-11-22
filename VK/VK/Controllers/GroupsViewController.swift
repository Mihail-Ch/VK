//
//  GroupsViewController.swift
//  VK
//
//  Created by Михаил Чертов on 20.11.2023.
//

import UIKit

class GroupsViewController: UIViewController {
    
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
        
        vkApi.getJSON(get: .groups)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension GroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.reuseId, for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }
        cell.configureCell(avatar: "logo", title: "ВКонтакте", description: "Social network")
        return cell
    }
 
}

extension GroupsViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
