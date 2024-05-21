//
//  EntryNoteViewController.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/23/24.
//

import UIKit
import SnapKit

enum EntryType{
    case save
    case update
}

protocol EntryNoteDelegate {
    func didSaveNote(newNote: Note)
    func didEditNote(newNote: Note, noteIndex: Int)
}



class EntryNoteViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let mainView = UIView()
    private let stackView = UIStackView()
    private let titleTextField = UITextField()
    private let detailTextField = UITextView()
    private let saveButton = UIButton()
    private let noteManager = NoteManager.shared
    
    var delegate: EntryNoteDelegate?
    var entryType: EntryType?
    var noteIndex: Int? = nil
    var note: Note?
    
    private var bottomScrollViewConstraint: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        if entryType == .update {
            titleTextField.text = note?.title
            detailTextField.text = note?.detail
        }
        
        UIAdder()
        scrollViewUI()
        mainViewUI()
        stackViewUI()
        textFieldUI()
        saveButtonUI()
        // Do any additional setup after loading the view.

        if #available(iOS 13.0, *) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: createCustomeRightBarButton(title: "Back", icon: UIImage(systemName: "chevron.backward")))
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
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


//@objc function
extension EntryNoteViewController{
    @objc func popScreen (){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func showKeyboard(notification: Notification){
        guard let userInfo = notification.userInfo, let keyboard = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        bottomScrollViewConstraint?.constant = -keyboard.height + 20
        print(keyboard.height)
        view.layoutIfNeeded()
        
    }
    
    @objc func hideKeyboard(){
        bottomScrollViewConstraint?.constant = 0
        view.layoutIfNeeded()
    }
    
    @objc func saveOrUpdateNote(){
        let titleText = titleTextField.text?.trimmingCharacters(in: .whitespaces)
        let detailText = detailTextField.text?.trimmingCharacters(in: .whitespaces)
        if let title = titleText, let detail = detailText, !title.isEmpty {
            let note = Note(title: title , detail: detail )
            switch entryType {
            case .save:
                delegate?.didSaveNote(newNote: note)
            case .update:
                guard let index = noteIndex else {return}
                delegate?.didEditNote(newNote: note, noteIndex: index)


            default:
                print("error")
            }
           
            navigationController?.popViewController(animated: true)
        }else{
            let validateAlert = UIAlertController(title: "", message: "Title can't be empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .cancel)
            validateAlert.addAction(okAction)
            present(validateAlert,animated: true)
            
        }
    }
}

//UI config
extension EntryNoteViewController{
    
    func createCustomeRightBarButton(title: String, icon: UIImage?)-> UIButton{
        let customeButton = UIButton(type: .system)
        if let icon = icon {
            customeButton.setImage(icon, for: .normal)
        }
        customeButton.setTitle(title, for: .normal)
        customeButton.tintColor = .systemBlue
        customeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        customeButton.addTarget(self, action: #selector(popScreen), for: .touchUpInside)
        return customeButton
    }
    func mainViewUI(){
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.snp.makeConstraints{ make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
            make.height.equalTo(scrollView.frameLayoutGuide.snp.height).priority(.low)
        }
      
    }
    
    func textFieldUI(){
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.borderStyle = .roundedRect
        titleTextField.placeholder = "Enter note"
        titleTextField.font = UIFont.systemFont(ofSize: 14)
        
        detailTextField.translatesAutoresizingMaskIntoConstraints = false
        detailTextField.isEditable = true
        detailTextField.layer.borderColor = UIColor.lightGray.cgColor
        detailTextField.layer.borderWidth = 0.5
        detailTextField.layer.cornerRadius = 5
        detailTextField.snp.makeConstraints{ make in
            make.width.equalTo(stackView.snp.width)
            make.height.greaterThanOrEqualTo(100)
        }
    }

    func saveButtonUI(){
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("save", for: .normal)
        saveButton.backgroundColor = UIColor(red: 0, green: 0.4431, blue: 0.9176, alpha: 1.0)
        saveButton.layer.cornerRadius = 5
        saveButton.addTarget(self, action: #selector(saveOrUpdateNote), for: .touchUpInside)
    }
    func stackViewUI(){
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.snp.makeConstraints{ make in
            make.top.equalTo(mainView.snp.top).offset(10)
            mainView.snp.makeConstraints{make in
                make.bottom.equalTo(stackView.snp.bottom).offset(10)
            }
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.center.equalToSuperview()
            
        }
      
    }
    
    func scrollViewUI(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.snp.makeConstraints{[weak self] make in
            guard let self = self else {return}
            make.edges.equalTo(view.safeAreaLayoutGuide)
            self.bottomScrollViewConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            self.bottomScrollViewConstraint?.isActive = true
        }
       
    }
    
    func UIAdder(){
        
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(detailTextField)
        stackView.addArrangedSubview(saveButton)
        mainView.addSubview(stackView)
        scrollView.addSubview(mainView)
        view.addSubview(scrollView)
    }
}
