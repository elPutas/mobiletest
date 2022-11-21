//
//  DetailPresenter.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import Foundation

protocol DetailPresenter:AnyObject{
    func interactor(didGetAllComments allComments:[Comment])
    func interactor(didFailAllComments error:String)
    
    func interactor(didGetUserInfo user:AuthorUser, post:Post)
    func interactor(didFailUserInfo error:String, post:Post)
}

class DetailPresenterImplementation: DetailPresenter {
    weak var viewControler:DetailPresenterOutput?
    
    func interactor(didGetAllComments allComments:[Comment]) {
        viewControler?.presenter(didGetAllComments: allComments)
    }
    
    func interactor(didFailAllComments error:String) {
        viewControler?.presenter(didFailAllComments: error)
    }
    
    func interactor(didGetUserInfo user:AuthorUser, post:Post){
        
        let posts = DataManager.shared.postsOffline()
        let selectedPost = posts.filter { $0.id == post.id }
        let userOffline = DataManager.shared.authorOffline(id: user.id, name: user.name, username: user.username, email: user.email, post: nil)
        
        selectedPost[0].author = userOffline
        DataManager.shared.save()
        viewControler?.presenter(didGetUserInfo: user)
    }
    
    func interactor(didFailUserInfo error:String, post:Post){
        let posts = DataManager.shared.postsOffline()
        let selectedPost = posts.filter { $0.id == post.id }
        
        //find in coreData
        if let userOffline = selectedPost[0].author{
            let user = AuthorUser(id: userOffline.id, name: userOffline.name ?? "no namme", username: userOffline.username ?? "no username", email: userOffline.email ?? "no email")
            viewControler?.presenter(didGetUserInfo: user)
        }else{
            viewControler?.presenter(didFailUserInfo: nil)
        }
        
        
    }
    
    
}
