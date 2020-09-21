//
//  PictureCell.swift
//  Mixture
//
//  Created by 石博 on 2020/9/18.
//

import Foundation
import UIKit
class PictureCell: UICollectionViewCell,UICollectionViewDelegate, UICollectionViewDataSource{
    var pictureData: [UIImage] = []
    var cycleCollectionView: UICollectionView?
    var pageControl = UIPageControl()
    var flowlayout = UICollectionViewFlowLayout()
    var timer = Timer()
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createSubviews(){
        for i in 1...4{
            var tempImage = UIImage(named: String(i)+".JPG")
            tempImage = tempImage!.reSizeImage(reSize: CGSize(width: UIScreen.main.bounds.width-12, height: (UIScreen.main.bounds.width-12)*2.0/3.0))
            pictureData.append(tempImage!)
        }
        cycleCollectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-12, height: (UIScreen.main.bounds.width-12)*2.0/3.0),collectionViewLayout:flowlayout)
        flowlayout.itemSize = CGSize(width: UIScreen.main.bounds.width-12, height: (UIScreen.main.bounds.width-12)*2.0/3.0);
        flowlayout.minimumInteritemSpacing = 0;
        flowlayout.minimumLineSpacing = 0;
        flowlayout.scrollDirection = UICollectionView.ScrollDirection.horizontal;
        cycleCollectionView!.backgroundColor = UIColor.white
        cycleCollectionView!.isPagingEnabled = true
        cycleCollectionView!.dataSource  = self
        cycleCollectionView!.delegate = self
        cycleCollectionView!.showsHorizontalScrollIndicator = false
        cycleCollectionView!.showsVerticalScrollIndicator = false
        cycleCollectionView!.register(CycleCell.self, forCellWithReuseIdentifier: "cellId")
        self.contentView.addSubview(cycleCollectionView!)
        pageControl = UIPageControl.init(frame: CGRect(x:0, y:0, width:(UIScreen.main.bounds.width-12) / 2, height: 30))
        pageControl.center = CGPoint(x: (UIScreen.main.bounds.width-12) / 2, y: (UIScreen.main.bounds.width-12)*2.0/3.0 - 20)
        pageControl.numberOfPages = pictureData.count
        self.contentView.addSubview(pageControl)
        self.addTimer()
        }
    func addTimer(){
        timer = Timer.init(timeInterval: 2, target: self, selector: #selector(nextPageView), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }
    
    @objc func nextPageView(){
        let indexPath = cycleCollectionView!.indexPathsForVisibleItems.last
        var item = indexPath!.row + 1;
        if item == pictureData.count {
            item = 0
        }
        self.pageControl.currentPage = item;
        let nextIndexPath = NSIndexPath.init(row: item, section: 0)
        cycleCollectionView!.scrollToItem(at: nextIndexPath as IndexPath, at: UICollectionView.ScrollPosition.left, animated: true)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            self.addTimer()
        }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            self.removeTimer()
    }
    func removeTimer(){
            self.timer.invalidate()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CycleCell
        cell.imageView = UIImageView(image: pictureData[indexPath.row])
        cell.addSubview(cell.imageView)
        return cell
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
            return 1
        }
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        pageControl.numberOfPages = pictureData.count
//        return pictureData.count
//    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = (Int(scrollView.contentOffset.x) / Int(UIScreen.main.bounds.width-12)) % pictureData.count
        pageControl.currentPage = page
    }
}
