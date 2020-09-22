//
//  TextCell.swift
//  Mixture
//
//  Created by 石博 on 2020/9/18.
//

import Foundation
import UIKit

class TextCell: UICollectionViewCell {
    var textView:UILabel!
    override init(frame:CGRect){
        super.init(frame:frame)
        textView = UILabel()
        self.contentView.addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
