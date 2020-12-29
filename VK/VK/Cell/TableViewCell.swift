//
//  TableViewCell.swift
//  VK
//
//  Created by Михаил Чертов on 28.12.2020.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let nib = UINib(nibName: "TableViewCell", bundle: nil)
    static let reuseId = "TableViewCell"
    
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(name: String, avatar: UIImage) {
        self.avatar.image = avatar
        self.label.text = name
    }

}
