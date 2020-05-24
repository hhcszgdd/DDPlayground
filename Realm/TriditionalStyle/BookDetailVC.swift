//
//  BookDetailVC.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/5/24.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import RealmSwift
class BookDetailVC: DDViewController {
    
    // MARK: setting
    var modelActionType: ModelActionType = .add
    var saveBookAction: ((BookModel)->())?
    
    // MARK: properties
    var book: BookModel?
    lazy var bookName: UITextField = {
        let result = UITextField(frame: CGRect(x: 0, y: 0, width: 333, height: 66))
        result.placeholder = "place input book name"
        result.backgroundColor = .cyan
        return result
    }()
    override var naviBarStyle: DDNavigationBarStyle { return .red }
    
    // MARK: life circel
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = book == nil ? "AddBook" : "EditBook"
        modelActionType = book == nil ? .add : .edit
        if book == nil  {
            book = BookModel()
        } else {
            bookName.text = book?.name
        }
        view.add(subview: bookName, pin: [.left, .top, .right], margin: DDMargins(top: 100, left: 10, bottom: 0, right: -10))
        bookName.setHeight(64)
        let save = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self , action: #selector(saveBook))
        navigationItem.rightBarButtonItems = [ save]
    }
    
    // MARK: action
    @objc func saveBook() {
        self.book?.name = self.bookName.text ?? "nil"
        saveBookAction?(self.book!)
    }
     
}
