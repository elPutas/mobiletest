//
//  DataManager.swift
//  mobileTest
//
//  Created by Gio Valdes on 17/11/22.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "mobileTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //Core Data Saving support
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func postOffline(userId: Int32, id: Int32, title: String, body: String, isFavorite: Bool?) -> PostOffline {
        let post = PostOffline(context: persistentContainer.viewContext)
        post.userId = userId
        post.id = id
        post.title = title
        post.body = body
        post.isFavorite = isFavorite ?? false
        return post
    }
    
    func authorOffline(id: Int32, name: String, username: String, email: String, post:PostOffline?) -> AuthorUserOffline {
        let author = AuthorUserOffline(context: persistentContainer.viewContext)
        author.id = id
        author.name = name
        author.username = username
        author.email = email
        author.post = post
        return author
    }
    
    func postsOffline() -> [PostOffline] {
        let request: NSFetchRequest<PostOffline> = PostOffline.fetchRequest()
        var fetchedPostOffline: [PostOffline] = []
        do {
            fetchedPostOffline = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            debugPrint("Error fetching postOffline \(error)")
        }
        return fetchedPostOffline
    }
    
    func authorsOffline() -> [AuthorUserOffline] {
        let request: NSFetchRequest<AuthorUserOffline> = AuthorUserOffline.fetchRequest()
        var fetchedAuthorUserOffline: [AuthorUserOffline] = []
        do {
            fetchedAuthorUserOffline = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            debugPrint("Error fetching postOffline \(error)")
        }
        return fetchedAuthorUserOffline
    }
    
    func deleteAllPost(){
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: PostOffline.fetchRequest())
        do {
            try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: persistentContainer.viewContext)
        } catch let error as NSError {
            debugPrint("Error delete postOffline \(error)")
        }
    }
    
    func setAsFavPostsOffline(post: PostOffline, isFavorite:Bool) {
        post.setValue(isFavorite, forKey: "isFavorite")
        save()
    }
    
    
    func saveCacheData(_ allPosts:[Post]){
        var postArr = [PostOffline]()
        let postsSaved = DataManager.shared.postsOffline()
        for _post in allPosts {
            if !postsSaved.contains(where: {$0.id == _post.id}) {
                let postOffline = postOffline(userId: _post.userId, id: _post.id, title: _post.title, body: _post.body, isFavorite: _post.isFavorite)
                postArr.append(postOffline)
            }
        }
        save()
    }
}
