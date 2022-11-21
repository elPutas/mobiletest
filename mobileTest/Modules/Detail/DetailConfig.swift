//
//  DetailConfig.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import Foundation

class DetailConfiguration {
    static func configureModule(viewController: DetailViewController) {
        let view = DetailView()
        let interactor = DetailInteractorImplementation()
        let presenter = DetailPresenterImplementation()
        let router = DetailRouterImplementation()

        viewController.detailView = view
        viewController.detailInteractor = interactor

        interactor.presenter = presenter
        interactor.router = router

        presenter.viewControler = viewController
        router.navigationController = viewController.navigationController
    }
}
