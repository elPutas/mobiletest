//
//  HomeConfig.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import UIKit

class HomeConfiguration {
    static func configureModule(viewController: HomeViewController) {
        let view = HomeView()
        let interactor = HomeInteractorImplementation()
        let presenter = HomePresenterImplementation()
        let router = HomeRouterImplementation()

        viewController.homeView = view
        viewController.homeInteractor = interactor

        interactor.presenter = presenter
        interactor.router = router

        presenter.viewControler = viewController
        router.navigationController = viewController.navigationController
    }
}
