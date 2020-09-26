//
//  FunToPlayVC.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/26.
//

import UIKit

class FunToPlayVC: BaseAnchorViewController {
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}

extension FunToPlayVC {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}
extension FunToPlayVC {
    override func loadData() {
        baseVM = funnyVM
        
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            
            // 隐藏
            self.loadDataFinished()
        }
    }
}
