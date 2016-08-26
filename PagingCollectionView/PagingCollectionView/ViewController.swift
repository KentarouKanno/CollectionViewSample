//
//  ViewController.swift
//  PagingCollectionView
//
//  Created by Kentarou on 2016/08/26.
//  Copyright © 2016年 Kentarou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        cell.label.text = "\(indexPath.section) - \(indexPath.row)";
        
        return cell
    }
}

// ---------  Custom Cell ----------

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
}


// ---------  Custom UICollectionViewFlowLayout ----------


class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    let itemLength: CGFloat = 130
    let itemWidth : CGFloat = 280
    let minInteritemSpacing: CGFloat = 20
    let velocityThreshold   = 0.2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepare()
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let currentPage = self.collectionView!.contentOffset.x / pageWidth()
        
        if fabs(Double(velocity.x)) > velocityThreshold {
            let nextPage = (velocity.x > 0.0) ? ceil(currentPage) : floor(currentPage)
            return CGPointMake((nextPage * pageWidth()), proposedContentOffset.y)
        } else {
            return CGPointMake((round(currentPage) * pageWidth()), proposedContentOffset.y)
        }
    }
    
    func pageWidth() -> CGFloat {
        return itemSize.width + minimumLineSpacing
    }
    
    func prepare() {
        self.itemSize = CGSizeMake(itemWidth, itemLength);
        self.minimumLineSpacing = minInteritemSpacing;
        self.scrollDirection = .Horizontal
        
        let horizontalInset = (UIScreen.mainScreen().bounds.size.width - itemWidth) / 2
        let verticalInset: CGFloat = 20
        
        self.sectionInset = UIEdgeInsetsMake(verticalInset, horizontalInset, verticalInset, horizontalInset);
    }
}

