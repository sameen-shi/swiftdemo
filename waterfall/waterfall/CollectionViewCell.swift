//
//  CollectionViewCell.swift
//  waterfall
//
//  Created by 石博 on 2020/9/17.
//

import Foundation
import UIKit
class CollectionViewCell: UICollectionViewCell {
    var waterimage:UIImageView!
    
    override init(frame:CGRect){
        super.init(frame:frame)
        self.waterimage = UIImageView()
        self.contentView.addSubview(self.waterimage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
