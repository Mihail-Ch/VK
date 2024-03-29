//
//  ChatViewController.swift
//  ВКонтакте
//
//  Created by Михаил Чертов on 31.12.2023.
//

import UIKit

class ChatViewController: UIViewController {

    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChatTextTableViewCell.self, forCellReuseIdentifier: ChatTextTableViewCell.reuseId)
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.backgroundColor = Theme.currentTheme.backgroundColor
        title = "Сообщения"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}


extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTextTableViewCell.reuseId, for: indexPath) as? ChatTextTableViewCell else { return UITableViewCell() }
        
        if indexPath.row % 2 == 0 {
            cell.configureLeft()
        } else {
            cell.configureRight()
        }
        return cell
        
    }
 
}

extension ChatViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
