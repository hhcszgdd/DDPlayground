//
//  RXStudentDetailVC.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/5/24.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
class RXStudentDetailVC: DDViewController {
 
    // MARK: setting
    override var naviBarStyle: DDNavigationBarStyle { return .red }
    
    // MARK: data model
    var student: RXStudentModel?
    var modelActionType: ModelActionType = .add
    var viewModel: StudentVCViewModel?
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
            student = RXStudentModel()
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
        let bookDetailVC = RXBookDetailVC()
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
        try? RealmTool.getDB().write{
            if modelActionType == .edit {
                RealmTool.getDB().add(student! ,update:  .modified )
            } else {
                RealmTool.getDB().add(student!)
            }
        }
        viewModel?.studentsPublishSubject.accept(RXStudentModel.getStudents())// 触发刷新
        self.navigationController?.popViewController(animated: true)
    }
    
    func deleteBook(book: RXBookModel) {
        try? RealmTool.getDB().write{
            RealmTool.getDB().delete(book)
        }
    }
    
}

// MARK: tableview delete and datasource
extension RXStudentDetailVC : UITableViewDelegate, UITableViewDataSource {
    
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
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = student?.books[indexPath.row]
        let bookVC = RXBookDetailVC()
        bookVC.book = book
        bookVC.saveBookAction = { book in
            print(book.name)
        }
        navigationController?.pushViewController(bookVC, animated: true)
    }
    
}
