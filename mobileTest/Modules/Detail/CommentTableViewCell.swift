//
//  CommentTableViewCell.swift
//  mobileTest
//
//  Created by Gio Valdes on 10/11/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    var titleText: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setupUI() {
        self.addSubview(titleText)

        let margin = CGFloat(15)

        titleText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        titleText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin).isActive = true
        titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: margin).isActive = true
        titleText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -margin).isActive = true
    }

}
