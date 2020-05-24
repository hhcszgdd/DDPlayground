//
//  RXStudentListVC.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/5/24.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
class RXStudentListVC: DDViewController {
 
    // MARK: setting
    override var naviBarStyle: DDNavigationBarStyle { return .blue }
    
    // MARK: data model
    var students: Results<RXStudentModel>?
    var viewModel: StudentVCViewModel = StudentVCViewModel()
    
    
    // MARK: view components
    lazy var tableView: UITableView = {
        let result = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        result.delegate = self
        result.dataSource = self
        return result
    }()
    let bag: DisposeBag = DisposeBag()
    
    // MARK: life circel
    override func viewDidLoad() {
        super.viewDidLoad()
        view.add(subview: tableView, pin: .all)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: UIBarButtonItem.Style.plain, target: self , action: #selector(addStudent))
        getStudentFromNetwork()
    }
    
    // MARK: actions
    func getStudentFromNetwork() {
        viewModel.studentsPublishSubject.subscribe(onNext: { (resultsStudent) in
            self.students = resultsStudent
            self.tableView.reloadData()
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }) {
            print("dispaseeee")
        }.disposed(by: bag)
    }
    
    @objc func addStudent() {
        let vc = RXStudentDetailVC()
         vc.viewModel = self.viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: tableview delegate and datasource
extension RXStudentListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let c = tableView.dequeueReusableCell(withIdentifier: "DDCell") {
            cell = c
        }else {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "DDCell")
        }
        cell.textLabel?.text = students?[indexPath.row].name ?? ""
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "delete") { (action , indexPath) in
            
            self.deleteStudent(student: self.students![indexPath.row])
        }
        let edit = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "edit") { (action , indexPath) in
            
        }
        return [delete, edit]
    }
    
    func deleteStudent(student: RXStudentModel) {
        try? StudentRealmTool.getDB().write{
            StudentRealmTool.getDB().delete(student)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentDetail = RXStudentDetailVC()
        studentDetail.student = students![indexPath.row]
        studentDetail.viewModel = self.viewModel
        navigationController?.pushViewController(studentDetail, animated: true)
    }
    
}
