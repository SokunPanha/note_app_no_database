//
//  NoteDetailViewController.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/29/24.
//

import UIKit
import SnapKit

class NoteDetailViewController: UIViewController {


    var detailText: String = ""
    let detailLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(detailLabel)
        detailLabel.text = detailText
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.snp.makeConstraints{make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
       
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


