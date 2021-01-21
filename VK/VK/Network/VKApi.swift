//
//  VKApi.swift
//  VK
//
//  Created by Михаил Чертов on 18.01.2021.
//

import Foundation
import Alamofire


class VKApi {
    
    let baseUrl = "https://api.vk.com/method/"
   
    func getFriends(token: String, completion: @escaping ([User]) -> Void) {
        let path = "friends.get"
        let parameters: Parameters = [
            "access_token": token,
            "count": "20",
            "fields": "photo_50",
            "v": "5.126"
        ]
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else {return}
            let friends = try! JSONDecoder().decode(Response.self, from: data).response
            print(friends)
            completion(friends.userResponse)
            
        }
        
    }
    
    func getPhotos(token: String) {
        let path = "photos.getAll"
        let parameters: Parameters = [
            "access_token": token,
           // "owner_id": id,
            "count": "20",
            "v": "5.126"
        ]
        
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response)
        }
    }
    
    func getGroups(token: String) {
        let path = "groups.get"
        let parameters: Parameters = [
            "access_token": token,
            "count": "20",
            "fields": "photo_50",
            "v": "5.126"
        ]
        
        let url = baseUrl + path
    
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response)
        }
    }
    
    func searchGroups(token: String, textField: String) {
        let path = "groups.search"
        let parameters: Parameters = [
            "access_token": token,
            "q": textField,
            "count": "10",
            "v": "5.126"
        ]
        
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response)
        }
    }
    
    
}
