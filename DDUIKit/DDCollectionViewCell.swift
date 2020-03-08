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
                row.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                row.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
    
    override public func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutAttributes.size.width = UIScreen.main.bounds.width
        switch row.rowHeight {
        case .auto:
            layoutIfNeeded()
            layoutAttributes.frame.size.height = contentView.systemLayoutSizeFitting(layoutAttributes.size).height
        case .caculattion(let height):
            layoutAttributes.frame.size.height = height
        }
        return layoutAttributes;
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        if self.reuseIdentifier == NSStringFromClass(type(of: row.self)) {
        }
        
    }
    
    func setRow(row: DDRow, in collectionView: DDCollectionView) {
        row.collectionView = collectionView
        // TODO: to be set model to row
        guard row != self.row else {  return }
        self.row = row
    }
}
