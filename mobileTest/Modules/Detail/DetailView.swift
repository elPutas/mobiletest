//
//  DetailView.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import UIKit

class DetailView: UIView {
    lazy var commentsTableView = UITableView()

    var titleText: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 30.0)
        return text
    }()

    var bodyText: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        return text
    }()

    var authorNameText: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 12.0)
        return text
    }()

    var authorEmailText: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 10.0)
        return text
    }()

    var authorUserNameText: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 12.0)
        return text
    }()

    var containerAuthorInformation: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    var containerPost: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .white
        let margin = CGFloat(15)

        self.addSubview(commentsTableView)
        self.addSubview(containerPost)
        self.addSubview(containerAuthorInformation)

        containerPost.addArrangedSubview(titleText)
        containerPost.addArrangedSubview(bodyText)

        containerAuthorInformation.addArrangedSubview(authorNameText)
        containerAuthorInformation.addArrangedSubview(authorUserNameText)
        containerAuthorInformation.addArrangedSubview(authorEmailText)

        containerPost.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        containerPost.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin).isActive = true
        containerPost.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: margin).isActive = true

        containerAuthorInformation.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        containerAuthorInformation.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin).isActive = true
        containerAuthorInformation.topAnchor.constraint(equalTo: containerPost.bottomAnchor, constant: margin).isActive = true

        commentsTableView.translatesAutoresizingMaskIntoConstraints = false
        commentsTableView.topAnchor.constraint(equalTo: containerAuthorInformation.bottomAnchor, constant: margin).isActive = true
        commentsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        commentsTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        commentsTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
