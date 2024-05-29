//
//  SettingViewController.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/22/24.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    private let tableView = UITableView()
    var name: String = AccountService.getAccountInfo() ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
      
        
        // Do any additional setup after loading the view.
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        tableView.register(ListSettingTableViewCell.self, forCellReuseIdentifier: ListSettingTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
//    @objc func getUserInfo(_ notification: Notification){
//        guard let userInfo = notification.userInfo else { return }
//           print(userInfo, "Notification received")
//        name = userInfo["username"] as? String
//        tableView.reloadData()
//        print(name)
//    }
}

//datasource
extension SettingViewController: UITableViewDataSource{
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
               guard let userCell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
                   fatalError("Failed to dequeue UserTableViewCell")
               }
        
            userCell.userNameLabel.text = name
               // Configure your userCell here
               return userCell
           } else {
               guard let settingCell = tableView.dequeueReusableCell(withIdentifier: ListSettingTableViewCell.identifier, for: indexPath) as? ListSettingTableViewCell else {
                   fatalError("Failed to dequeue ListSettingTableViewCell")
               }
               // Configure your settingCell here
               return settingCell
           }
        
    }
}


//delegate

extension SettingViewController: UITableViewDelegate{
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 1{
            AccountService.removeAccountInfo()
          let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            if let window = UIApplication.shared.windows.first{
                window.rootViewController = loginVC
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
            }
        }
        
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 100
        }
        else{
            return 50
        }
    }
}


extension SettingViewController: LoginViewControllerDelegate{
    func didLogin(with userName: String) {
        name = userName
        tableView.reloadData()
        print("loaded")
        print(userName)
    }
}
