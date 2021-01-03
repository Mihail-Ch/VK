//
//  FriendsPhotoViewController.swift
//  VK
//
//  Created by Михаил Чертов on 28.12.2020.
//

import UIKit

class FriendsPhotoViewController: UIViewController {
    
    var photo: User?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - DataSource

extension FriendsPhotoViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo!.userPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.userPhoto.image = UIImage(named: photo!.userPhoto[indexPath.row])
        return cell
    }
}

//MARK: - Delegate

extension FriendsPhotoViewController: UICollectionViewDelegate {
    
}
