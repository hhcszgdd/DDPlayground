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
            self.contentView.addSubview(row)
            row.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
//                row.heightAnchor.constraint(equalToConstant: row.height),
                row.topAnchor.constraint(equalTo: contentView.topAnchor),
                row.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//                row.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                row.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                row.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                contentView.bottomAnchor.constraint(equalTo: row.bottomAnchor),
//                contentView.topAnchor.constraint(equalTo: row.topAnchor),
//                contentView.leftAnchor.constraint(equalTo: row.leftAnchor),
//                contentView.rightAnchor.constraint(equalTo: row.rightAnchor)
            ])
//            setNeedsLayout()
//            setNeedsDisplay()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
//        row.frame = bounds
    }
    
//    override public func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let attribures = super.preferredLayoutAttributesFitting(layoutAttributes)
//        print("xxxx: \(attribures.bounds)")
//        attribures.size.width = UIScreen.main.bounds.width// CGSize(width: UIScreen.main.bounds.width, height: row.height) // row.bounds.size
//        return attribures
//    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        if self.reuseIdentifier == NSStringFromClass(type(of: row.self)) {
        }
        
    }
    
    func setRow(row: DDRow, in collectionView: DDCollectionView) {
        row.collectionView = collectionView
        guard row != self.row else { return }
        self.row = row
    }
}
