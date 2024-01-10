//
//  PhotosCollectionViewCell.swift
//  ВКонтакте
//
//  Created by Михаил Чертов on 31.12.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "photosCollectionViewCell"
    
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImage)
        contentView.clipsToBounds = true
        contentView.backgroundColor = Theme.currentTheme.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        NSLayoutConstraint.activate([
            
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
            
        ])
    }
    
    func configure(image: String) {
        self.photoImage.getPhoto(url: image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImage.image = nil
        
    }
}
