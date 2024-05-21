//
//  ListSettingTableViewCell.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/22/24.
//

import UIKit

class ListSettingTableViewCell: UITableViewCell {
    
    static let identifier = "listSetting"
    
    let label = UILabel()
    let icon = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addUI()
        labelUI()
        iconUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ListSettingTableViewCell{
    func labelUI(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Log out"
        
        let leading = label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        let centerY = label.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        NSLayoutConstraint.activate([leading, centerY])
        
    }
    
    func iconUI(){
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            icon.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        }
        
        let width = icon.widthAnchor.constraint(equalToConstant: 30)
        let height = icon.heightAnchor.constraint(equalToConstant: 30)
        let trailing = icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        let centerY = icon.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        NSLayoutConstraint.activate([width, height, trailing, centerY])
    }
    
    func addUI(){
        addSubview(label)
        addSubview(icon)
    }
}

