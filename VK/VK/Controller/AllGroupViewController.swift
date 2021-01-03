//
//  AllGroupViewController.swift
//  VK
//
//  Created by Михаил Чертов on 29.12.2020.
//

import UIKit

class AllGroupViewController: UIViewController {

    var groups = GroupData.groupFactory()
        
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseId)
    }
}

//MARK: - DataSource

extension AllGroupViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.label.text = groups[indexPath.row].groupName
        cell.avatar.image = UIImage(named: groups[indexPath.row].avatar)
        return cell
    }
    
    // MARK: - Navigation

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "AddGroup", sender: nil)
        }
}

//MARK: - Delegate

extension AllGroupViewController: UITableViewDelegate {
    
}
