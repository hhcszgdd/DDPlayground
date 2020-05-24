//
//  StudentDetailVC.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/5/24.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

enum ModelActionType {
    case add
    case edit
}

import UIKit
import RealmSwift
import Realm
class StudentDetailVC: DDViewController {
    
    // MARK: setting
    override var naviBarStyle: DDNavigationBarStyle { return .red }
    
    // MARK: data model
    var student: StudentModel?
    var modelActionType: ModelActionType = .add
    
    // MARK: components
    lazy var tableView: UITableView = {
        let result = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        result.delegate = self
        result.dataSource = self
        return result
    }()
    lazy var studentName: UITextField = {
        let result = UITextField(frame: CGRect(x: 0, y: 0, width: 333, height: 66))
        result.placeholder = "place input student name"
        result.backgroundColor = .cyan
        return result
    }()
    
    // MARK: life circel
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = student == nil ? "AddStudent" : "EditStudent"
        modelActionType = student == nil ? .add : .edit
        if student == nil  {
            student = StudentModel()
        } else {
            studentName.text = student?.name
        }
        view.add(subview: tableView, pin: .all)
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: "DDDarkAndWhireColor")
        } else {
            // Fallback on earlier versions
            view.backgroundColor = UIColor.darkGray
        }
        tableView.tableHeaderView = studentName
        let add = UIBarButtonItem(title: "AddBook", style: UIBarButtonItem.Style.plain, target: self , action: #selector(addBook))
        let save = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self , action: #selector(saveStudent))
        navigationItem.rightBarButtonItems = [add, save]
    }
    
    // MARK: actions
    @objc func addBook() {
        let bookDetailVC = BookDetailVC()
        bookDetailVC.saveBookAction = { [weak self] book in
            print(book.name)
            RLMRealm.default().beginWriteTransaction()
            self?.student?.books.append(book)
            try? RLMRealm.default().commitWriteTransaction()
            self?.saveStudent()
        }
        navigationController?.pushViewController(bookDetailVC, animated: true)
    }
    @objc func saveStudent() {
        if modelActionType == .edit {
            RLMRealm.default().beginWriteTransaction()
            student?.name = studentName.text ?? "NotSet"
            try? RLMRealm.default().commitWriteTransaction()
        } else {
            student?.name = studentName.text ?? "NotSet"
        }
        try? StudentRealmTool.getDB().write{
            if modelActionType == .edit {
                StudentRealmTool.getDB().add(student! ,update:  .modified )
            } else {
                StudentRealmTool.getDB().add(student!)
            }
        } 
    }
    
    func deleteBook(book: BookModel) {
        try? StudentRealmTool.getDB().write{
            StudentRealmTool.getDB().delete(book)
        }
    }
    
}

// MARK: tableview delete and datasource
extension StudentDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return student?.books.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let c = tableView.dequeueReusableCell(withIdentifier: "DDCell") {
            cell = c
        }else {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "DDCell")
        }
        cell.textLabel?.text = student?.books[indexPath.row].name ?? nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "delete") {[weak self] (action , indexPath) in
            if let book = self?.student?.books[indexPath.row] {
                self?.deleteBook(book: book)                
            }
        }
        let edit = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "edit") { (action , indexPath) in
            
        }
        return [delete, edit]
    }
    
    @available(iOS 13.0, *)
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let actionProvider : UIContextMenuActionProvider =  { suggest in
            
            let editMenu = UIMenu(title: "Edit...", children: [
                UIAction(title: "Copy", handler: { (action) in
                    print("copy")
                }),
                UIAction(title: "paste", handler: { (action) in
                    print("paste")
                })
            ])
            return UIMenu(title: "share...", children: [
                UIAction(title: "share", handler: { (action) in
                    print("share")
                }),
                editMenu,
                UIAction(title: "delete", handler: { (action) in
                    print("delete")
                })
            ])
            
        }
        return UIContextMenuConfiguration(identifier: "Unique-ID" as NSCopying, previewProvider: nil , actionProvider: actionProvider)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = student?.books[indexPath.row]
        let bookVC = BookDetailVC()
        bookVC.book = book
        bookVC.saveBookAction = { book in
            print(book.name)
        }
        navigationController?.pushViewController(bookVC, animated: true)
    }
    
}
