//
//  HomeViewController.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import UIKit

protocol HomePresenterOutput: AnyObject {
    func presenter(didGetAllPosts allPosts: [Post])
    func presenter(didGetFavsPost favPost: [Post])
    func presenter(didPostAsFav allPost: [Post])
    func presenter(didDeleteOnePost allPost: [Post], index: IndexPath)
    func presenter(didFailAllPosts allPostOffline: [Post])
}
class HomeViewController: UIViewController {

    var homeView: HomeView?
    var homeInteractor: HomeInteractor?
    var myAllPosts: [Post]?
    let cellHome = "cellHome"

    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupButtons()
        homeInteractor?.getAllPosts()
    }

    func setupButtons() {
        homeView?.refreshButton.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
        homeView?.deleteAllButton.addTarget(self, action: #selector(deleteDataWithoutFavs), for: .touchUpInside)
    }
    @objc func deleteDataWithoutFavs() {
        guard let myAllPosts = myAllPosts else { return }
        homeInteractor?.filterOnlyFavs(allPost: myAllPosts)
    }
    @objc func refreshData() {
        myAllPosts = nil
        homeInteractor?.getAllPosts()
    }

    func setupTable() {
        homeView?.homeTableView.delegate = self
        homeView?.homeTableView.dataSource = self
        homeView?.homeTableView.estimatedRowHeight = 20.0
        homeView?.homeTableView.estimatedRowHeight = UITableView.automaticDimension
        homeView?.homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellHome)
    }
}

// MARK: table
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions:
                                        [makeArchiveContextualAction(forRowAt: indexPath),
                                         makeDeleteContextualAction(forRowAt: indexPath)])
    }

    func makeArchiveContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal,
                                        title: "") {[weak self](_: UIContextualAction, _: UIView, completionHandler: (Bool) -> Void) in

            if let allPost = self?.myAllPosts, let homeInteractor = self?.homeInteractor {
                homeInteractor.setAsFav(post: allPost, index: indexPath)
            }
            completionHandler(true)
        }
        let post = myAllPosts?[indexPath.row]
        action.backgroundColor = .blue
        action.image = (post?.isFavorite ?? false) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        return action
    }

    func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive,
                                        title: "") {[weak self] (_: UIContextualAction, _: UIView, completionHandler: (Bool) -> Void) in

            if let allPost = self?.myAllPosts, let homeInteractor = self?.homeInteractor {
                homeInteractor.deletePost(post: allPost, index: indexPath)
            }
            completionHandler(true)
        }
        action.backgroundColor = .red
        action.image = UIImage(systemName: "trash")
        return action
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let post = myAllPosts?[indexPath.row] {
            homeInteractor?.gotoDetail(post: post)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAllPosts?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellHome, for: indexPath) as? HomeTableViewCell else {
            let cell = HomeTableViewCell(style: .default, reuseIdentifier: cellHome)
            return configCell(cell, indexPath)
        }
        return configCell(cell, indexPath)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func configCell(_ cell: HomeTableViewCell, _ indexPath: IndexPath) -> HomeTableViewCell {
        cell.titleText.text = myAllPosts?[indexPath.row].title
        cell.isFavorite = myAllPosts?[indexPath.row].isFavorite ?? false
        return cell
    }
}

// MARK: presenter output
extension HomeViewController: HomePresenterOutput {
    func presenter(didDeleteOnePost allPost: [Post], index: IndexPath) {
        myAllPosts = allPost
        self.homeView?.homeTableView.deleteRows(at: [index], with: .automatic)
    }
    func presenter(didPostAsFav allPost: [Post]) {
        myAllPosts = allPost
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {// wait cell back
            self.homeView?.homeTableView.reloadData()
        }
    }
    func presenter(didGetFavsPost favPost: [Post]) {
        myAllPosts = favPost
        homeView?.homeTableView.reloadData()
    }
    func presenter(didGetAllPosts allPosts: [Post]) {
        myAllPosts = allPosts
        homeView?.homeTableView.reloadData()
    }

    func presenter(didFailAllPosts allPostOffline: [Post]) {
        myAllPosts = allPostOffline
        homeView?.homeTableView.reloadData()
    }
}
