//
//  CollectionLayout.swift
//  Mixture
//
//  Created by 石博 on 2020/9/18.
//

import Foundation
import UIKit

protocol CollectionLayoutProtocol: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
    func Column(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath) -> Int
}

class CollectionLayout: UICollectionViewFlowLayout {
    weak var delegate: CollectionLayoutProtocol?
    private let cellPadding: CGFloat = 6

    private var cache: [UICollectionViewLayoutAttributes] = []

    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
      guard let collectionView = collectionView else {
        return 0
      }
      let insets = collectionView.contentInset
      return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: contentHeight)
    }
    override func prepare() {
      guard
        cache.isEmpty,
        let collectionView = collectionView
        else {
          return
      }
        var maxheight:CGFloat = 0
        for i in 0..<collectionView.numberOfSections{
            let numberOfColumns = delegate?.Column(collectionView, heightForPhotoAtIndexPath: IndexPath(item: 0 , section: i)) ?? 1
            var xOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
            var yOffset: [CGFloat] = .init(repeating: maxheight, count: numberOfColumns)
            var col = 0
            for j in 0..<collectionView.numberOfItems(inSection: i){
                let indexpath = IndexPath(item: j, section: i)
                let photoHeight = delegate?.collectionView(
                  collectionView,
                  heightForPhotoAtIndexPath: indexpath) ?? 180
                let columnWidth = contentWidth / CGFloat(numberOfColumns)
                xOffset[col] = CGFloat(col)*columnWidth
                let height = cellPadding + photoHeight
                let frame = CGRect(x: xOffset[col],
                                   y: yOffset[col],
                                   width: columnWidth,
                                   height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexpath)
                attributes.frame = insetFrame
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[col] = yOffset[col] + height
                col = (col + 1) % numberOfColumns
            }
            maxheight = yOffset[col] + 20
        }
    }
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
      return cache
    }
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
