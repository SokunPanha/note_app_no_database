//
//  TabBarViewController.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/22/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let folderVC = UINavigationController(rootViewController: FolderViewController())
        let settingVC = SettingViewController()
        
        if #available(iOS 13.0, *) {
            folderVC.tabBarItem = UITabBarItem(title: "Folder", image: UIImage(systemName: "folder"), tag: 0)
        }
        
        if #available(iOS 13.0, *) {
            settingVC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gear"), tag: 0)
        }
        
   
        tabBar.backgroundColor = .white
        setViewControllers([folderVC, settingVC], animated: true)
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
