//
//  VKApi.swift
//  VK
//
//  Created by Михаил Чертов on 22.11.2023.
//

import Foundation


final class VKApi {
    
    let session = Session.shared
    
    enum ApiMethod {
        case friends
        case groups
        case myPhoto
        
        
        var path: String {
            switch self {
            case .friends:
                return "/method/friends.get"
            case .groups:
                return "/method/groups.get"
            case .myPhoto:
                return "/method/photos.get"
            }
        }
        
        var parameters: [String: String] {
            switch self {
            case .friends:
                return [
                    "fields": "photo_50",
                    "count": "10"
                ]
            case .groups:
                return [
                    "count": "10",
                    "extended": "1"
                ]
            case .myPhoto:
                return [
                    "album_id": "profile",
                    "count": "10"
                ]
            }
        }
    }
    
    private func request(_ method: ApiMethod) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = method.path
        
        let defaultQueryItems = [
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.199")
        ]
        
        let methodQueryItems = method.parameters.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        components.queryItems = defaultQueryItems + methodQueryItems
        
        guard let url = components.url else { return }
        print(url)
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed)
            print(json as Any)
        }
        task.resume()
    }
    
    
    func getJSON(get: ApiMethod) {
        request(get)
    }
}
