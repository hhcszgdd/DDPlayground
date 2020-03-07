//
//  DDViewController.swift
//  test
//
//  Created by JohnConnor on 2020/2/19.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

open class DDViewController: UIViewController {
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//
//        layout.minimumInteritemSpacing = 10
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        return layout
    }()
    open lazy var collectionView: DDCollectionView = {
        let result = DDCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        result.delegate = self
        result.dataSource = self
        return result
    }()
    override public func viewDidLoad() {
        super.viewDidLoad()
        _addSubviews()
//        collectionView.sections = [ DDSection(rows: [ DDRow(), DDRow1(), DDRow2(), DDRow3() ]) ]
        registerCell()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    
    private func _addSubviews() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ])
    }
    
    private func test () {
//        DDRow(t: <#T##_#>)
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
extension DDViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func registerCell() {
        collectionView.sections.flatMap { (section) -> [DDRow] in
            section.rows
        }.forEach { (row) in
            collectionView.register(DDCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(type(of: row.self)))
        }
        collectionView.sections.forEach { (section) in
            section.rows.forEach { (row) in
                
            }
        }
        collectionView.register(DDCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(DDCollectionViewCell.self))
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let row = self.collectionView.sections[indexPath.section].rows[indexPath.item] 
//        return CGSize(width: UIScreen.main.bounds.width, height: row.height)
//    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  self.collectionView.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.collectionView.sections[section].rows.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = self.collectionView.sections[indexPath.section].rows[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(type(of: row.self)), for: indexPath) as! DDCollectionViewCell
        cell.setRow(row: row,in: self.collectionView)
        cell.backgroundColor = [UIColor.red, UIColor.green, UIColor.blue, UIColor.orange].randomElement()
        return cell
    }
    
    
}
