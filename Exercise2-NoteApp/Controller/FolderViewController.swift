import UIKit
import SnapKit
class FolderViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    var folderName: [String] = []
    let noteManager = NoteService.shared
    
    // MARK: - Initialization
    init() {
        // Initialize with a flow layout
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Folder"
        reloadFolderData()
        collectionView.register(FolderCollectionViewCell.self, forCellWithReuseIdentifier: FolderCollectionViewCell.identifier)
        
        if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .done, target: self, action: #selector(addFolder))
        }
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Actions
    @objc func addFolder() {
        createFolder()
    }
}

// MARK: - UICollectionViewDataSource
extension FolderViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folderName.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCollectionViewCell.identifier, for: indexPath) as! FolderCollectionViewCell
        cell.label.text = folderName[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FolderViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFolder = folderName[indexPath.row]
        let detailVC = FolderNoteListViewController()
        detailVC.title = selectedFolder
        detailVC.selectedFolder = selectedFolder
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FolderViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ( (collectionView.frame.size.width - 20) / 4 ) - 10
        let height = 100.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


// MARK: - UIContextMenuInteractionDelegate
extension FolderViewController {
   
    @available(iOS 13.0, *)
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPath: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        print(indexPath)
        let index = indexPath[0]
        print(index)
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let editAction = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil.circle")) { [weak self] _ in
                self?.editFolder(at: index)
            }
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash")) { [weak self] _ in
                self?.deleteFolder(at: index)
            }
            
            return UIMenu(title: "", children: [editAction, deleteAction])
        }
    }
    }


    




// MARK: - User-defined Methods
extension FolderViewController {
    func deleteFolder(at indexPath: IndexPath) {
        let deletedFolder = folderName[indexPath.row]
        let remover = UIAlertController(title: "", message: "\(deletedFolder) will be deleted!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            self?.noteManager.deleteFolder(folderName: deletedFolder)
            self?.reloadFolderData()
            self?.collectionView.deleteItems(at: [indexPath])
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        remover.addAction(ok)
        remover.addAction(cancel)
        present(remover, animated: true)
    }
    
    func createFolder() {
        popUpForm(title: "Create folder", folderName: nil) { [weak self] newFolder in
            guard let self = self else { return }
            let (message, success) = noteManager.createFolder(folderName: newFolder)
            if success {
                self.reloadFolderData()
                let indexPath = IndexPath(row: folderName.count - 1, section: 0)
                self.collectionView.insertItems(at: [indexPath])
            }else{
                print("test")
                self.emptyTextFieldAlert(message: message)
            }
           
        }
    }
    
    func editFolder(at indexPath: IndexPath) {
        let currentFolder = folderName[indexPath.row]
        
        popUpForm(title: "Edit Folder", folderName: currentFolder) { [weak self] newFolderName in
            guard let self = self else { return }
            let (message, success) = noteManager.updateFolder(newFolderName: newFolderName, currentFolder: currentFolder)
            if success{
                self.reloadFolderData()
                self.collectionView.reloadData()
            }else{
                self.emptyTextFieldAlert(message: message)
            }
        }
    }
    
    func popUpForm(title: String, folderName: String?, completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Folder name"
            textField.text = folderName
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let text = alertController.textFields?.first?.text {
                completion(text)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func emptyTextFieldAlert(message: String) {
        let validateAlert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .destructive)
        validateAlert.addAction(okAction)
        present(validateAlert, animated: true)
    }
    
    func reloadFolderData(){
        folderName = noteManager.folderKeys
    }
}

