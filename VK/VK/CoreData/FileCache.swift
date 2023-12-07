//
//  FileCache.swift
//  VK
//
//  Created by Михаил Чертов on 07.12.2023.
//

import CoreData

final class FileCache {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print(error)
            }
        }
        return persistentContainer
    }()
    
    func save() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func addFriends(friends: [Friends]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendModelCD")
        for friend in friends {
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [friend.id])
            let result = try? persistentContainer.viewContext.fetch(fetchRequest)
            guard result?.first == nil else {
                continue
            }
            let friendModel = FriendModelCD(context: persistentContainer.viewContext)
            friendModel.id = Int64(friend.id)
            friendModel.firstName = friend.firstName
            friendModel.lastName = friend.lastName
            friendModel.avatar = friend.avatar
            friendModel.online = Int16(friend.online)
        }
        save()
        //addFriendData()
        }
    
    func fetchFriends() -> [Friends] {
        let fetchRequest: NSFetchRequest<FriendModelCD> = FriendModelCD.fetchRequest()
        guard let friends = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return []
        }
        var newFriends: [Friends] = []
        for friend in friends {
            newFriends.append(Friends(id: Int(friend.id), firstName: friend.firstName, lastName: friend.lastName, online: Int(friend.online)))
        }
        return newFriends
    }
    
    func addFriends(groups: [Groups]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GroupModelCD")
        for group in groups {
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [group.id])
            let result = try? persistentContainer.viewContext.fetch(fetchRequest)
            guard result?.first == nil else {
                continue
            }
            let groupModel = GroupModelCD(context: persistentContainer.viewContext)
            groupModel.id = Int64(group.id)
            groupModel.name = group.name
            groupModel.avatar = group.avatar
        }
        save()
        //addFriendData()
        }
    
    func fetchGroups() -> [Groups] {
        let fetchRequest: NSFetchRequest<GroupModelCD> = GroupModelCD.fetchRequest()
        guard let groups = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return []
        }
        var newGroups: [Groups] = []
        for group in groups {
            newGroups.append(Groups(id: Int(group.id), name: group.name ?? "", avatar: group.avatar ?? "", description: group.caption ?? ""))
        }
        return newGroups
    }
}

