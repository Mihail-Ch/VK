//
//  PhotosViewController.swift
//  VK
//
//  Created by Михаил Чертов on 20.11.2023.
//

import UIKit

class PhotosViewController: UIViewController {
    
    lazy var vkApi = VKApi()
    private let id = Session.shared
    private var photo: [Photo] = []
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collecitonView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collecitonView.translatesAutoresizingMaskIntoConstraints = false
        collecitonView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseId)
        return collecitonView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Фото"
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        vkApi.getPhoto(ownerId: id.userId) { [weak self] photo in
            self?.photo = photo
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

//MARK: - DataSource

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseId, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        let photo = photo[indexPath.row]
        let photos = photo.sizes
        for photo in photos {
            cell.configure(image: photo.url)
        }
        return cell
    }
    
    
}

//MARK: - DelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width / 2) - 2
        let height = width - 30
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
