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
        case photos(id: Int)
        
        var path: String {
            switch self {
            case .friends:
                return "/method/friends.get"
            case .groups:
                return "/method/groups.get"
            case .photos:
                return "/method/photos.getAll"
            }
        }
        
        var parameters: [String: String] {
            switch self {
            case .friends:
                return [
                    "fields": "photo_50, city, online",
                    "count": "120",
                ]
            case .groups:
                return [
                    "count": "10",
                    "extended": "1"
                ]
            case .photos(let id):
                return [
                    "owner_id": String(id)
                ]
            }
        }
    }
    
    //MARK: - Request
    
    private func request(_ method: ApiMethod, complition: @escaping (Data?) -> Void ) {
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
        
        guard let url = components.url else {
            complition(nil)
            return
        }
        print(url)
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                complition(data)
            }
        }
        task.resume()
    }
    
    //MARK: Get Friend
    
    func getFriends(complition: @escaping ([Friends]) -> Void) {
        request(.friends) { [weak self] (data) in
            guard let data = data else {return}
            do {
                let response = try JSONDecoder().decode(Response<Friends>.self, from: data).response.items
                complition(response)
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: Get Group
   
    func getGroups(complition: @escaping ([Groups]) -> Void) {
        request(.groups) { [weak self] (data) in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Response<Groups>.self, from: data).response.items
                complition(response)
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: Get Photo
    
    func getPhoto(ownerId: Int, complition: @escaping([Photo]) -> Void) {
        request(.photos(id: ownerId)) { [weak self] (data) in
            guard let data = data else {return}
            do {
                let response = try JSONDecoder().decode(Response<Photo>.self, from: data).response.items
                complition(response)
            } catch {
                print(error)
            }
        }
    }
    
}
