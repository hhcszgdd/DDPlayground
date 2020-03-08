//
//  DDCollectionViewController.swift
//  DDUIKit
//
//  Created by JohnConnor on 2020/3/8.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

public class DDCollectionViewController: DDViewController {
    public override var naviBarStyle: DDNavigationBarStyle { return .green }
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 46)
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
        registerCell()
        view.backgroundColor = .red
    }
    
    private func _addSubviews() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ])
    }
    
}
extension DDCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func registerCell() {
        collectionView.sections.flatMap { (section) -> [DDRow] in
            section.rows
        }.forEach { (row) in
            collectionView.register(DDCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(type(of: row.self)))
        }
    }
    
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

