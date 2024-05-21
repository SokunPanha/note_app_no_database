//
//  UserTableViewCell.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/22/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    static let identifier = "userCell"
    
    let userNameLabel = UILabel()
    let userImage = UIImageView()
    let containerView = UIView()
    let arrowIcons = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Setup your cell views and constraints
        
        addingView()
        userImageUI()
        userNameLabelUI()
        viewUI()
        arrowIconsUI()
  
      
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            contentView.backgroundColor = .white
        }else{
            contentView.backgroundColor = .clear
        }
        // Configure the view for the selected state
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted{
            contentView.backgroundColor = .white
        }
        
        else{
            contentView.backgroundColor = .clear
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // Making the view rounded
        containerView.layer.cornerRadius = containerView.frame.height / 2
        containerView.clipsToBounds = true // Ensures that the corner radius is applied
    }

}

//config UI
extension UserTableViewCell {
    func viewUI(){
       
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(red: 0.1098, green: 0.102, blue: 0.098, alpha: 0.04)

        let leading = containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        let centerY = containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        let width = containerView.widthAnchor.constraint( equalToConstant: 60)
        let height = containerView.heightAnchor.constraint( equalToConstant: 60)
        
         NSLayoutConstraint.activate([leading, centerY, width, height])
        
    }
    
    func userImageUI(){
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.contentMode = .scaleAspectFit
        
     
        if #available(iOS 13.0, *) {
            userImage.image = UIImage(systemName: "person")
        }
        
        let centerY = userImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        let centerX = userImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let width = userImage.widthAnchor.constraint(equalToConstant:  40)
        let height = userImage.heightAnchor.constraint(equalToConstant: 40)
        
         NSLayoutConstraint.activate([centerX, centerY, width, height])
        

    }
    
    func userNameLabelUI(){
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let top = userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30)
        let leading = userNameLabel.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20)
        NSLayoutConstraint.activate([top, leading])
    }
    
    func arrowIconsUI(){
        arrowIcons.translatesAutoresizingMaskIntoConstraints = false
        arrowIcons.contentMode = .scaleAspectFit
        
        if #available(iOS 13.0, *) {
            arrowIcons.image = UIImage(systemName: "square.and.pencil.circle")
        }
        
        let trailing = arrowIcons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        let centerY = arrowIcons.centerYAnchor.constraint(equalTo: centerYAnchor)
        let width = arrowIcons.widthAnchor.constraint(equalToConstant:  30)
        let height = arrowIcons.heightAnchor.constraint(equalToConstant: 30)
        
        NSLayoutConstraint.activate([trailing, centerY, width, height])
    }
    func addingView(){
        
        containerView.addSubview(userImage)
        addSubview(containerView)
        addSubview(userNameLabel)
        addSubview(arrowIcons)
    }
}
