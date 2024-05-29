//
//  ViewController.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/21/24.
//

import UIKit
import SnapKit

extension Notification.Name{
    static let userInfo = Notification.Name("userInfo")
}
protocol LoginViewControllerDelegate{
    func didLogin(with userName: String)
}
class LoginViewController: UIViewController {

    //property view
    let mainView = UIView()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    //element UI
    let usernameeTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let loginBanner = UIImageView()
    
    // assignment
    var scrollViewBottomConstraint:NSLayoutConstraint?
    var delegate: LoginViewControllerDelegate?
    
   
    override func viewDidLoad() {
  
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 50, green: 50, blue: 50, alpha: 0.9)
        // Do any additional setup after loading the view.
        addingView()
        scrollViewUI()
        mainViewUI()
        stackViewUI()
        loginBannerUI()
        textFieldUI()
        buttonLoginUI()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)

        let data = "2024"
        KeyChainHelper.save(key: "aditi", data: data)
    }
    
   
}



//UIConfig
extension LoginViewController{
    func scrollViewUI(){
      
       
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.snp.makeConstraints{ [weak self] make in
            guard let self = self else {return}
            make.edges.equalTo(view.safeAreaLayoutGuide)
            self.scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            scrollViewBottomConstraint?.isActive = true
        }
        let top = scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        let trailing = scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        let bottom = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        scrollViewBottomConstraint = bottom
        let leading = scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        
        NSLayoutConstraint.activate([top, bottom, trailing, leading])
    }
    
    func mainViewUI(){
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.snp.makeConstraints{ make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
            make.height.equalTo(scrollView.frameLayoutGuide.snp.height).priority(.low)
        }
        
    }
    
    func stackViewUI(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
   
        stackView.snp.makeConstraints{ make in
            make.top.greaterThanOrEqualTo(mainView.snp.top).offset(30)
            mainView.snp.makeConstraints{ make in
                make.bottom.greaterThanOrEqualTo(stackView.snp.bottom).offset(30)
            }
            make.trailing.equalTo(mainView.snp.trailing).offset(-10)
            make.leading.equalTo(mainView.snp.leading).offset(10)
            make.center.equalToSuperview()
        }
        
       
    }
    func loginBannerUI(){
        loginBanner.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            loginBanner.image = UIImage(systemName: "person.fill")
        }
        loginBanner.contentMode = .scaleAspectFit
               loginBanner.translatesAutoresizingMaskIntoConstraints = false
               let height = loginBanner.heightAnchor.constraint(equalToConstant: 100)
               let width = loginBanner.widthAnchor.constraint(equalToConstant: 100)
               NSLayoutConstraint.activate([height, width])
           
    }
    func textFieldUI(){
        usernameeTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameeTextField.borderStyle = .roundedRect
        usernameeTextField.placeholder = "Username"
        usernameeTextField.font = UIFont.systemFont(ofSize: 14)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.font = UIFont.systemFont(ofSize: 14)
        
     
        
    }
    
    func buttonLoginUI(){
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 5
//        loginButton.backgroundColor = .cyan
        loginButton.translatesAutoresizingMaskIntoConstraints  = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
    }
    func addingView(){
        
        stackView.addArrangedSubview(loginBanner)
        stackView.addArrangedSubview(usernameeTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        mainView.addSubview(stackView)
        scrollView.addSubview(mainView)
        view.addSubview(scrollView)
    }
}


//functionality

extension LoginViewController {
    
    @objc func showKeyboard(notification: Notification){
        guard let userInfo = notification.userInfo, let keyboard = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        scrollViewBottomConstraint?.constant = -keyboard.height
        view.layoutIfNeeded()
    }
    
    @objc func hideKeyboard(){
        scrollViewBottomConstraint?.constant = 0
        view.layoutIfNeeded()
    }
    
    @objc func loginButtonTapped(){
        guard let username = usernameeTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        let alertMessage = ["empty": "Username and Password can't be empty!", "incorrect": "Incorrect password!"]
        
        let emptyAlert = UIAlertController(title: "",message: "", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Ok", style: .destructive)
        emptyAlert.addAction(cancelButton)
        
        if (usernameeTextField.text?.count ?? 0 < 1) || (passwordTextField.text?.count ?? 0 < 1){
            emptyAlert.message = alertMessage["empty"]
            present(emptyAlert, animated: true)
        }
        else if AccountService.validateCredentail(username: username, password: password){
            let homeVC = TabBarViewController()
            homeVC.modalPresentationStyle = .fullScreen
            homeVC.modalTransitionStyle = .coverVertical
            homeVC.navigationItem.hidesBackButton = true
            
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = homeVC
                UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil)
            }
        }
        else {
            emptyAlert.message = alertMessage["incorrect"]
            present(emptyAlert, animated: true)
            
        }
    }
}
