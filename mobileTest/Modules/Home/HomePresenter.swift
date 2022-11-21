//
//  HomePresenter.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import Foundation

protocol HomePresenter: AnyObject {
    func interactor(didGetAllPosts allPosts: [Post])
    func interactor(didFailAllPosts error: String)
    func interactor(deleteAllDataWithoutFavs allPosts: [Post])
    func interactor(setPostAsFavAndArrange allPosts: [Post], index: IndexPath)
    func interactor(deletePost allPosts: [Post], index: IndexPath)
}

class HomePresenterImplementation: HomePresenter {
    weak var viewControler: HomePresenterOutput?

    func interactor(deletePost allPosts: [Post], index: IndexPath) {
        var posts = allPosts
        posts.remove(at: index.row)
        let post = allPosts[index.row]
        // TODO: delete one post in coreData
        viewControler?.presenter(didDeleteOnePost: posts, index: index)
    }
    func interactor(setPostAsFavAndArrange allPosts: [Post], index: IndexPath) {
        var posts = allPosts
        let currentFav = allPosts[index.row].isFavorite ?? false
        posts[index.row].isFavorite = !currentFav

        posts.sort { $0.isFavorite ?? false && !($1.isFavorite ?? false) }
        // TODO: save favorites one in coreData
        viewControler?.presenter(didPostAsFav: posts)
    }
    func interactor(deleteAllDataWithoutFavs allPosts: [Post]) {
        let justFavs = allPosts.filter { $0.isFavorite ?? false }
        // TODO: delete all in CoreData
        viewControler?.presenter(didGetFavsPost: justFavs)
    }

    func interactor(didGetAllPosts allPosts: [Post]) {
        /// save in coreData
        // TODO: if exists return Coredata data
        DataManager.shared.saveCacheData(allPosts)
        viewControler?.presenter(didGetAllPosts: allPosts)
    }

    func interactor(didFailAllPosts error: String) {
        // TODO: handle error, decide if it's showed
        let posts = DataManager.shared.postsOffline()
        var arrCachePost = [Post]()
        for _post in posts {
            let postOffline = Post(userId: _post.userId, id: _post.id, title: _post.title ?? "", body: _post.body ?? "", isFavorite: _post.isFavorite, author: nil)
            arrCachePost.append(postOffline)
        }
        viewControler?.presenter(didFailAllPosts: arrCachePost)
    }

}
