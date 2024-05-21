//
//  NoteTableViewCell.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/23/24.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    static let identifier = "NoteTableViewCell"
    
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let stackView = UIStackView()
    
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
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 1
     
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.font = UIFont.systemFont(ofSize: 10)
        detailLabel.textColor = .gray
        
        let titleLeading = titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30)
        let titleTrailing = titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        
        let detailLeading = titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30)
        let detailTrailing = titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        
        let stackViewLeading = stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
        let stackViewTrailing = stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        let centerY = stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        NSLayoutConstraint.activate([titleLeading, titleTrailing, detailLeading, detailTrailing, stackViewLeading, stackViewTrailing, centerY])        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



