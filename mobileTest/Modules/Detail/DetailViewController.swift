//
//  DetailViewController.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import UIKit

protocol DetailPresenterOutput:AnyObject {
    func presenter(didGetAllComments allPosts:[Comment])
    func presenter(didFailAllComments error:String)
    
    func presenter(didGetUserInfo user:AuthorUser)
    func presenter(didFailUserInfo userCache:AuthorUser?)
}
class DetailViewController: UIViewController {
    
    var detailView:DetailView?
    var detailInteractor:DetailInteractor?
    let cellComment = "cellComment"
    var userAuthor:AuthorUser?
    var myPost:Post?
    var myComments:[Comment]?
    
    init(post:Post){
        myPost = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        if let myPost = myPost{
            detailInteractor?.getAllCommetsByPost(idPost: myPost.id)
            detailInteractor?.getUserById(idUser: myPost.userId, post: myPost)
            
            detailView?.titleText.text = myPost.title
            detailView?.bodyText.text = myPost.body
        }
    }
    
    func setupTable(){
        detailView?.commentsTableView.delegate = self
        detailView?.commentsTableView.dataSource = self
        detailView?.commentsTableView.estimatedRowHeight = 20.0
        detailView?.commentsTableView.estimatedRowHeight = UITableView.automaticDimension
        detailView?.commentsTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: cellComment)
    }
}

//MARK: table
extension DetailViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myComments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellComment, for: indexPath) as? CommentTableViewCell else {
            let cell = CommentTableViewCell(style: .default, reuseIdentifier: cellComment)
            return configCell(cell,indexPath)
        }
        return configCell(cell,indexPath)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func configCell(_ cell:CommentTableViewCell, _ indexPath:IndexPath) ->CommentTableViewCell
    {
        cell.titleText.text = myComments?[indexPath.row].name
        return cell
    }
}

//MARK: presenter output
extension DetailViewController:DetailPresenterOutput{
    func presenter(didGetAllComments allPosts:[Comment]) {
        myComments = allPosts
        detailView?.commentsTableView.isHidden = false
        detailView?.commentsTableView.reloadData()
    }
    
    func presenter(didFailAllComments error:String) {
        myComments = nil
        detailView?.commentsTableView.isHidden = true
    }
    
    func presenter(didGetUserInfo user:AuthorUser){
        userAuthor = user
        detailView?.authorNameText.text = userAuthor?.name
        detailView?.authorUserNameText.text = userAuthor?.username
        detailView?.authorEmailText.text = userAuthor?.email
    }
    func presenter(didFailUserInfo userCache:AuthorUser?){
        userAuthor = userCache
    }
    
}

