//
//  MyGroupViewController.swift
//  VK
//
//  Created by Михаил Чертов on 29.12.2020.
//

import UIKit

class MyGroupViewController: UIViewController {
 
    var groups = [Group]()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseId)
    }
    
    //MARK: - Navigation
    
    @IBAction func unwindFromAllGroups(_ sender: UIStoryboardSegue) {
        guard let controller = sender.source as? AllGroupViewController,
              let indexPath = controller.tableView.indexPathForSelectedRow else {
            return
        }
        let group = controller.groups[indexPath.row]
        guard !groups.contains(group) else {
            return
        }
        groups.append(group)
        tableView.reloadData()
    }

}

//MARK: - DataSource

extension MyGroupViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let group = groups[indexPath.row]
        cell.configure(name: group.groupName, avatar: UIImage(named: group.avatar)!) 
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: - Delegate

extension MyGroupViewController: UITableViewDelegate {
    
}
