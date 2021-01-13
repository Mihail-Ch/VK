//
//  FriendsViewController.swift
//  VK
//
//  Created by Михаил Чертов on 28.12.2020.
//

import UIKit

struct Section<T> {
    let letter: String
    let names: [T]
}

class FriendsViewController: UIViewController {
    
    var sections = [Section<User>]()
    var friends = UserData.friendsFactory()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeSortedSection()
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseId)

    }
    
    func makeSortedSection() {
        let friendsDictionary = Dictionary.init(grouping: friends) { $0.userName.prefix(1) }
        sections = friendsDictionary.map{ Section(letter: String($0.key), names: $0.value) }
        sections.sort { $0.letter < $1.letter }
    }
}

//MARK: - DataSource

extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].letter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let friend = sections[indexPath.section]
        cell.configure(name: friend.names[indexPath.row].userName, avatar: UIImage(named: friend.names[indexPath.row].avatar)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map { $0.letter }
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
