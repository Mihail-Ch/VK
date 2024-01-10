//
//  VKApi.swift
//  ВКонтакте
//
//  Created by Михаил Чертов on 31.12.2023.
//

import Foundation
import CoreData



final class VKApi {
    
    let session = Session.shared
    
    enum NetworkError: Error {
        case dataError
    }
    
    enum ApiMethod {
        case friends
        case groups
        case photos(id: Int)
        case user
        
        var path: String {
            switch self {
            case .friends:
                return "/method/friends.get"
            case .groups:
                return "/method/groups.get"
            case .photos:
                return "/method/photos.getAll"
            case .user:
                return "/method/users.get"
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
                    "fields": "description",
                    "extended": "1"
                ]
            case .photos(let id):
                return [
                    "owner_id": String(id)
                ]
            case .user:
                return ["fields": "photo_100"]
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
    
    //MARK: Get User
    
    func getUser(complition: @escaping(User) -> Void) {
        request(.user) { data in
            guard let data = data else {return}
            do {
                let response = try JSONDecoder().decode(ResponseUser<User>.self, from: data)
                guard let profile = response.response.first else {
                    return
                }
                complition(profile)
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: Get Friend
    
    func getFriends(complition: @escaping (Result<[Friends], Error>) -> Void) {
        request(.friends) { (data) in
            guard let data = data else {
                complition(.failure(Error.self as! Error))
                return
            }
            do {
                let response = try JSONDecoder().decode(Response<Friends>.self, from: data).response.items
                complition(.success(response))
            } catch {
                complition(.failure(NetworkError.dataError))
            }
        }
    }
    
    //MARK: Get Group
   
    func getGroups(complition: @escaping (Result<[Groups], Error>) -> Void) {
        request(.groups) { (data) in
            guard let data = data else {
                complition(.failure(Error.self as! Error))
                return
            }
            do {
                let response = try JSONDecoder().decode(Response<Groups>.self, from: data).response.items
                complition(.success(response))
            } catch {
                complition(.failure(NetworkError.dataError))
            }
        }
    }
    
    //MARK: Get Photo
    
    func getPhoto(ownerId: Int, complition: @escaping([Photo]) -> Void) {
        request(.photos(id: ownerId)) { (data) in
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

