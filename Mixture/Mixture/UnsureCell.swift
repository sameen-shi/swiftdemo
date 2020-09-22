//
//  UnsureCell.swift
//  Mixture
//
//  Created by 石博 on 2020/9/18.
//

import Foundation
import UIKit
class UnsureCell: UICollectionViewCell {
    var pictureView: UIImageView!
    override init(frame:CGRect){
        super.init(frame:frame)
        pictureView = UIImageView()
        self.contentView.addSubview(pictureView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
