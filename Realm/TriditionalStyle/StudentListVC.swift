//
//  StudentListVC.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/5/24.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import RealmSwift
class StudentListVC: DDViewController {
    
    // MARK: setting
    override var naviBarStyle: DDNavigationBarStyle { return .blue }
    
    // MARK: data model
    var students: Results<StudentModel> = {
        let studentsFromDB = StudentModel.getStudents()
        return studentsFromDB
    }()
    
    // MARK: view components
    lazy var tableView: UITableView = {
        let result = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        result.delegate = self
        result.dataSource = self
        return result
    }()
    
    // MARK: life circel
    override func viewDidLoad() {
        super.viewDidLoad()
        view.add(subview: tableView, pin: .all)
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: "DDDarkAndWhireColor")
        } else {
            // Fallback on earlier versions
            view.backgroundColor = UIColor.darkGray
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: UIBarButtonItem.Style.plain, target: self , action: #selector(addStudent))
    }
    
    // MARK: actions
    @objc func addStudent() {
        navigationController?.pushViewController(StudentDetailVC(), animated: true)
    }
}


// MARK: tableview delegate and datasource
extension StudentListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let c = tableView.dequeueReusableCell(withIdentifier: "DDCell") {
            cell = c
        }else {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "DDCell")
        }
        cell.textLabel?.text = students[indexPath.row].name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "delete") { (action , indexPath) in
            
            self.deleteStudent(student: self.students[indexPath.row])
        }
        let edit = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "edit") { (action , indexPath) in
            
        }
        return [delete, edit]
    }
    
    func deleteStudent(student: StudentModel) {
        try? StudentRealmTool.getDB().write{
            StudentRealmTool.getDB().delete(student)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentDetail = StudentDetailVC()
        studentDetail.student = students[indexPath.row]
        navigationController?.pushViewController(studentDetail, animated: true)
    }
    
}
extension ViewController {
    func testRealm() {
//        navigationController?.pushViewController(StudentListVC(), animated: true)
        navigationController?.pushViewController(RXStudentListVC(), animated: true)
    }
}
