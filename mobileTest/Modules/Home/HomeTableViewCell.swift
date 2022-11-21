//
//  HomeTableViewCell.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var titleText:UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var starIcon:UIImageView = {
       let image = UIImageView()
        image.isHidden = true
        image.image = UIImage(systemName: "star")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var isFavorite = false{
        didSet{
            starIcon.isHidden = !isFavorite
        }
    }
    
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
    
    func setupUI(){
        self.addSubview(titleText)
        self.addSubview(starIcon)
        
        let startSize = CGFloat(20)
        let margin = CGFloat(15)
        let marginBtwObjects = CGFloat(5)
        
        starIcon.widthAnchor.constraint(equalToConstant: startSize).isActive = true
        starIcon.heightAnchor.constraint(equalToConstant: startSize).isActive = true
        starIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        starIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: margin).isActive = true
        
        titleText.leftAnchor.constraint(equalTo: starIcon.rightAnchor, constant: marginBtwObjects).isActive = true
        titleText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin).isActive = true
        titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: margin).isActive = true
        titleText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -margin).isActive = true
    }

}
