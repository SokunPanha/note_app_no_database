//
//  NoteManger.swift
//  Exercise2-NoteApp
//
//  Created by Panha on 5/26/24.
//

import Foundation

class NoteManager {
    static let shared = NoteManager()
    var selectedFolder: String?
    private var folders: [(folderName: String, notes: [Note])] = []
    var folderKeys: [String] {
        var folderName: [String] = []
        for folder in folders {
            folderName.append(folder.folderName)
        }
        return folderName
    }
    
    private init(){}
}

// MARK: folder management
extension NoteManager {
    private func response(message: String, status: Bool) -> (String, Bool){
        return (message, status)
    }
    
    private func findFolderIndex(folderName: String) -> Int? {
        return folders.firstIndex(where: { $0.folderName == folderName }) ?? nil
    }
    
    private func validateData(folderName: String) -> (String, Bool) {
        if folderName.isEmpty {
            return response(message: "Folder name can't be empty!", status: false)
        }else if folderKeys.contains(folderName){
            return response(message: "\(folderName) already exist!", status:false)
        }else{
            return response(message: "", status: true)
        }
    }
    
    func createFolder(folderName: String)-> (String, Bool) {
        let name = folderName.trimmingCharacters(in: .whitespaces)
        if !folderKeys.contains(name) && !name.isEmpty {
       
            folders.append((folderName: name, notes: []))
            return response(message: "", status: true)
        }
        else{
            let validation = validateData(folderName: name)
            return validation
        }
    }
    
    func updateFolder(newFolderName: String, currentFolder: String)-> (String, Bool){
        let name = newFolderName.trimmingCharacters(in: .whitespaces)
        guard let folderIndex = findFolderIndex(folderName: currentFolder) else {return ("", false)}
        if  !name.isEmpty && !folderKeys.contains(newFolderName) {
            folders[folderIndex].folderName = newFolderName
        }else if currentFolder == newFolderName{
            return response(message: "", status: true)
        }
        else {
            let validation = validateData(folderName: name)
            return validation
        }
        
        return response(message: "", status: true)
        
    }
    
    func deleteFolder(folderName: String){
        guard let folderIndex = findFolderIndex(folderName: folderName) else { return  }
        folders.remove(at: folderIndex)
    }
    
    
}

// MARK: Note management
extension NoteManager{
    func createNote(newNote: Note){
        guard let selectedFolder = selectedFolder else {return}
        guard let index = findFolderIndex(folderName: selectedFolder) else {return }
        folders[index].notes.append(newNote)
    }
    
    func updateNote(newNote: Note, noteIndex: Int){
        guard let selectedFolder = selectedFolder else {return}
        guard let index = findFolderIndex(folderName: selectedFolder) else {return }
        folders[index].notes[noteIndex] = newNote
    }
    
    func deleteNote(noteIndex: Int){
        folders[noteIndex].notes.remove(at: noteIndex)
    }
    
    func getNotes(folderName: String)-> [Note]{
        guard let index = findFolderIndex(folderName: folderName) else {return []}
        return folders[index].notes
    }
    
}


