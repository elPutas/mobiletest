//
//  MainViewController.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        let nav = UINavigationController()
        let home = HomeViewController()
        nav.viewControllers = [home]
        nav.modalPresentationStyle = .fullScreen
        HomeConfiguration.configureModule(viewController: home)
        self.navigationController?.present(nav, animated: true)
    }
}
