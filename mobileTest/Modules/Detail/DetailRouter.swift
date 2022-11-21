//
//  DetailRouter.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import UIKit

protocol DetailRouter: AnyObject {
    var navigationController: UINavigationController? {get}

}

class DetailRouterImplementation: DetailRouter {
    var navigationController: UINavigationController?
}
