//
//  ViewController.swift
//  Mixture
//
//  Created by 石博 on 2020/9/17.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
    var unsureimage:UIImage!
    let textData: [String] = ["I was there for you before I'll be there for you again I'll always be there for you","The Wheel turns,nothing is ever new","When life gets too strange, too impossible, too frightening, there is always one last hope. When all else fails, there are two men sitting arguing in a scruffy flat.","hello shibo"]
    var unsureNumber: Int = 3
    
    private lazy var collectionView : UICollectionView = {
            let layout = CollectionLayout ()
            layout.scrollDirection = UICollectionView.ScrollDirection.vertical
            layout.delegate = self
            let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
            view.addSubview(collectionView)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(PictureCell.self,forCellWithReuseIdentifier: "PictureCell")
            collectionView.register(UnsureCell.self,forCellWithReuseIdentifier: "UnsureCell")
            collectionView.register(TextCell.self,forCellWithReuseIdentifier: "TextCell")
            collectionView.backgroundColor = UIColor.white
            return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        
        self.unsureimage  = UIImage(named: "happy.png")

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        if(section == 1){
            return unsureNumber > 5 ? (unsureNumber/5)*5 : unsureNumber
        }
        if(section == 2){
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as!PictureCell
            
            return cell
        }
        if(indexPath.section == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UnsureCell", for: indexPath) as!UnsureCell
            cell.pictureView.image = unsureimage
            let size = self.collectionView.layoutAttributesForItem(at: indexPath)!.frame.size
            cell.pictureView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            return cell
        }
        if(indexPath.section == 2){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as!TextCell
            cell.textView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 12, height: self.getHeight(withLabelText: textData[indexPath.row],width: UIScreen.main.bounds.width-12,font: UIFont.init(name: "Georgia", size: 30)!))
            cell.textView.text = textData[indexPath.item]
            cell.textView.font = UIFont.init(name: "Georgia", size: 30)
            cell.textView.numberOfLines = 0
            
            cell.contentView.layer.addSublayer(self.getCicleAngle(bound:cell.contentView.bounds))
            return cell
        }
        let cells:UICollectionViewCell = UICollectionViewCell()
        return cells
    }

}

extension ViewController: CollectionLayoutProtocol {
  func collectionView(
      _ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    if(indexPath.section == 0){
        return (UIScreen.main.bounds.width-2.0*6)*2/3
    }
    if(indexPath.section == 1){
        if(unsureNumber < 5){
            return UIScreen.main.bounds.width/CGFloat(unsureNumber)
        }
        else{return UIScreen.main.bounds.width/5.0}
    }
    if(indexPath.section == 2){
        return self.getHeight(withLabelText: textData[indexPath.row],width: UIScreen.main.bounds.width-12,font:  UIFont.init(name: "Georgia", size: 30)!)
    }
    return 180
  }
  func Column(
        _ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath: IndexPath) -> Int {
    if(indexPath.section == 0 || indexPath.section == 2){
        return 1
    }
    if(indexPath.section == 1){
        if(unsureNumber<5){
            return unsureNumber
        }
        else{return 5}
    }
    return 0
  }
  func getHeight(withLabelText text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT)))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
            
        return label.frame.height
  }
    func getCicleAngle(bound:CGRect) -> CAShapeLayer{
        let path = UIBezierPath.init(roundedRect:bound, byRoundingCorners: [.topRight , .bottomRight,.topLeft,.bottomLeft] , cornerRadii: CGSize(width: 5,height: 5))
        let layer = CAShapeLayer.init()
        layer.path = path.cgPath
        layer.lineWidth = 1
        layer.lineCap = CAShapeLayerLineCap.square
        layer.strokeColor = UIColor.gray.cgColor
        let color = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
        layer.fillColor = color
        return layer
    }
}

extension UIImage {
    func reSizeImage(reSize:CGSize)->UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }
}
