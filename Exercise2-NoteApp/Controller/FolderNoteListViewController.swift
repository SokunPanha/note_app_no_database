//
//  EntryViewController.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/22/24.
//

import UIKit
import SnapKit

class FolderNoteListViewController: UIViewController {
//    var entryType: checkAction? = nil
    var notesInFolder: [Note] = []
    var selectedFolder: String!
    private let detailTextField = UITextView()
    private let noteTextField = UITextField()
    private let viewContainer = UIView()
    private let noteManager = NoteManager.shared
    private let tableView = UITableView()
    override func viewWillAppear(_ animated: Bool) {
        reloadNote()
        noteManager.selectedFolder = selectedFolder
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableViewUI()
        tableView.delegate = self
        tableView.dataSource = self
        
       print(notesInFolder)
        if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(pushEntryScreen))
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
    
}

// Mark: Objc Function
extension FolderNoteListViewController{
    @objc func pushEntryScreen(){
        let entryNoteVC = EntryNoteViewController()
        entryNoteVC.title = "Create Note"
        entryNoteVC.hidesBottomBarWhenPushed = true
        entryNoteVC.delegate = self
        entryNoteVC.entryType = .save
        navigationController?.pushViewController(entryNoteVC, animated: true)
    }
}

// Mark: Ui Config
extension FolderNoteListViewController {
    func tableViewUI(){
        view.addSubview(tableView)
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints{ make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}

//datasource

extension FolderNoteListViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesInFolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as! NoteTableViewCell

        cell.titleLabel.text = notesInFolder[indexPath.row].title
        cell.detailLabel.text = notesInFolder[indexPath.row].detail
        return cell
    }
}


//delegate
extension FolderNoteListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {[weak self] (action, view, completion) in
            
            self?.noteManager.deleteNote(noteIndex: indexPath.row)
            self?.reloadNote()
            self?.tableView.reloadData()
            // Handle delete action
            completion(true)
        }
        
        let edit = UIContextualAction(style: .normal, title: "Edit"){ [weak self] (action, view, completion) in
            let entryNote = EntryNoteViewController()
            entryNote.entryType = .update
            entryNote.noteIndex = indexPath.row
            entryNote.note = self?.notesInFolder[indexPath.row]
            entryNote.title = "Update Note"
            entryNote.delegate = self
            self?.navigationController?.pushViewController(entryNote, animated: true)
            completion(true)
        }
        edit.backgroundColor = UIColor(red: 0, green: 0.4431, blue: 0.9176, alpha: 1.0)
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, edit])
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// Mark: EntryNoteDelegate

extension FolderNoteListViewController: EntryNoteDelegate{
    func didSaveNote(newNote: Note) {
        print("newNote",newNote)
        noteManager.createNote(newNote: newNote)
        reloadNote()
        tableView.reloadData()
    }
    func didEditNote(newNote: Note, noteIndex: Int) {
        noteManager.updateNote(newNote: newNote, noteIndex: noteIndex)
        reloadNote()
        tableView.reloadData()
    }
}

// MARK: User-defined Function

extension FolderNoteListViewController {
    func reloadNote(){
        notesInFolder =  noteManager.getNotes(folderName: selectedFolder)
    }
}


