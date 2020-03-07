//
//  DDCollectionViewCell.swift
//  test
//
//  Created by JohnConnor on 2020/2/20.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

public class DDCollectionViewCell: UICollectionViewCell {
    var row = DDRow() {
        didSet{
            row.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(row)
            NSLayoutConstraint.activate([
                row.topAnchor.constraint(equalTo: contentView.topAnchor),
                row.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                row.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                row.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                contentView.bottomAnchor.constraint(equalTo: row.bottomAnchor),
            ])
        }
    }
    
    
override public func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    let attribures = super.preferredLayoutAttributesFitting(layoutAttributes)
    attribures.size.width = UIScreen.main.bounds.width
    switch row.rowHeight {
    case .auto:
        break
    case .caculattion(let h):
        attribures.bounds.size.height = h
    }
    return attribures
}
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        if self.reuseIdentifier == NSStringFromClass(type(of: row.self)) {
        }
        
    }
    
    func setRow(row: DDRow, in collectionView: DDCollectionView) {
        row.collectionView = collectionView
        // TODO: to be set model to row
        guard row != self.row else { return }
        self.row = row
    }
}
