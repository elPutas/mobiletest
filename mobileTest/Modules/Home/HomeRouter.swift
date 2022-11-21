//
//  HomeRouter.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import UIKit

protocol HomeRouter:AnyObject {
    var navigationController:UINavigationController?{get}
    
    func gotoDetail(post:Post)
}

class HomeRouterImplementation:HomeRouter{
    var navigationController: UINavigationController?
    
    func gotoDetail(post: Post) {
        let detailPost = DetailViewController(post:post)
        DetailConfiguration.configureModule(viewController: detailPost)
        navigationController?.pushViewController(detailPost, animated: true)
    }
}
