//
//  ViewController.swift
//  waterfall
//
//  Created by 石博 on 2020/9/17.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private lazy var collectionView : UICollectionView = {
            let layout = Waterlayout()
            layout.delegate = self
            let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(CollectionViewCell.self,forCellWithReuseIdentifier: "cell")
            collectionView.backgroundColor = UIColor.white
            return collectionView
        }()
    var imagedata: [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        for index in 1...7{
            var tempimage = UIImage(named: String(index)+".jpg")
            let size = CGSize(width: self.view.bounds.width/2.0, height: (self.view.bounds.width/2.0)*tempimage!.size.height/tempimage!.size.width)
            tempimage = tempimage!.reSizeImage(reSize: size)
            imagedata.append(tempimage!)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!CollectionViewCell
        cell.waterimage.image = self.imagedata[indexPath.row]
        cell.waterimage.frame = CGRect(x: 0, y: 0, width: self.imagedata[indexPath.row].size.width, height: self.imagedata[indexPath.row].size.height)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension UIImage {
    func reSizeImage(reSize:CGSize)->UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
}

extension ViewController: WaterLayoutDelegate {
  func collectionView(
      _ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    return self.imagedata[indexPath.row].size.height
  }
}
