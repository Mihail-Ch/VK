//
//  UIImageView+Extension.swift
//  VK
//
//  Created by Михаил Чертов on 27.11.2023.
//

import UIKit


extension UIImageView {
    
    func getPhoto(url: String) {
        guard let url = URL(string: url) else { return }
        
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let imageDate = cache.cachedResponse(for: request)?.data {
            self.image = UIImage(data: imageDate)
        } else {
            URLSession.shared.dataTask(with: request) { [unowned self] (data, response, _) in
                guard let data = data, let response = response else {
                    return
                }
                let cachResponse = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachResponse, for: request)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
