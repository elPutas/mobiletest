//
//  DetailInteractor.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import Foundation

protocol DetailInteractor: AnyObject {
    func getAllCommetsByPost(idPost: Int32)
    func getUserById(idUser: Int32, post: Post)
}

class DetailInteractorImplementation: DetailInteractor {
    var presenter: DetailPresenter?
    var router: DetailRouter?
    var services = ServicesJson()

    func getAllCommetsByPost(idPost: Int32) {
        services.getCommetsByPost(idPost: idPost) { [weak self] success, comments in
            if success {
                self?.presenter?.interactor(didGetAllComments: comments)
            } else {
                self?.presenter?.interactor(didFailAllComments: "error")
            }
        }
    }

    func getUserById(idUser: Int32, post: Post) {
        services.getUserInfo(idUser: idUser) { [weak self] success, user in
            if success {
                self?.presenter?.interactor(didGetUserInfo: user, post: post)
            } else {
                self?.presenter?.interactor(didFailUserInfo: "error", post: post)
            }
        }
    }

}
