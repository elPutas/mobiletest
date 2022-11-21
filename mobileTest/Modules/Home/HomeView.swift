//
//  HomeView.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import UIKit

class HomeView: UIView {

    lazy var homeTableView = UITableView()

    var deleteAllButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setImage(UIImage(systemName: "trash.circle"), for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.setTitle("Delete all \n(except favorires)", for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        return button
    }()
    var refreshButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setImage(UIImage(systemName: "arrow.uturn.down.circle"), for: .normal)
        button.backgroundColor = .white
        button.setTitle("Reload all post", for: .normal)
        return button
    }()

    var containerOptions: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
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
        let heightContainer = CGFloat(100)
        let marginContainer = CGFloat(20)

        self.backgroundColor = .red
        self.addSubview(containerOptions)
        containerOptions.addArrangedSubview(refreshButton)
        containerOptions.addArrangedSubview(deleteAllButton)

        self.addSubview(homeTableView)

        containerOptions.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        containerOptions.heightAnchor.constraint(equalToConstant: heightContainer).isActive = true
        containerOptions.leftAnchor.constraint(equalTo: self.leftAnchor, constant: marginContainer).isActive = true
        containerOptions.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -marginContainer).isActive = true

        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        homeTableView.topAnchor.constraint(equalTo: containerOptions.bottomAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        homeTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        homeTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
