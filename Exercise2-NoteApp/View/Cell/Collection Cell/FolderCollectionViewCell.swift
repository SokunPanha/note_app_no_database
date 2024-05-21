//
//  FolderCollectionViewCell.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/22/24.
//

import UIKit
import SnapKit
class FolderCollectionViewCell: UICollectionViewCell {
    static let identifier = "FolderCollectionViewCell"
    let stackView = UIStackView()
    let label = UILabel()
    let icon = UIImageView()
    var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addUI()
        labelUI()
        iconUI()
        stackViewUI()
        
       
       
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


extension FolderCollectionViewCell{
    func labelUI(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "test"
        label.textAlignment = .center
        label.font =  UIFont.systemFont(ofSize: 14)
    }
    
    func iconUI(){
        icon.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            icon.image = UIImage(systemName: "note.text")
        }
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints{ make in
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }
    
    func stackViewUI(){
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        
        stackView.snp.makeConstraints{make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
    }
    
    func addUI(){
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(label)
        contentView.addSubview(stackView)
    }
}
