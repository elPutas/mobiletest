//
//  HomeInteractor.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import Foundation

protocol HomeInteractor:AnyObject{
    func getAllPosts()
    func filterOnlyFavs(allPost:[Post])
    func setAsFav(post:[Post], index:IndexPath)
    func deletePost(post:[Post], index:IndexPath)
    //router
    func gotoDetail(post:Post)
}

class HomeInteractorImplementation: HomeInteractor {
    var presenter:HomePresenter?
    var router:HomeRouter?
    var services = ServicesJson()
    
    //actions
    func deletePost(post:[Post], index:IndexPath){
        self.presenter?.interactor(deletePost: post, index: index)
    }
    func setAsFav(post:[Post], index:IndexPath){
        self.presenter?.interactor(setPostAsFavAndArrange: post, index: index)
    }
    func filterOnlyFavs(allPost:[Post]){
        self.presenter?.interactor(deleteAllDataWithoutFavs: allPost)
    }
    
    //services
    func getAllPosts() {
        services.getPosts { [weak self] success, posts in
            if success{
                self?.presenter?.interactor(didGetAllPosts: posts)
            }else{
                self?.presenter?.interactor(didFailAllPosts: "error")
            }
        }
    }
    //router
    func gotoDetail(post:Post){
        router?.gotoDetail(post: post)
    }
}
