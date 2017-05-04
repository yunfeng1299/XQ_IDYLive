
//
//  ChannelContentView.swift
//  Imitate_DY
//
//  Created by 夏琪 on 2017/5/4.
//  Copyright © 2017年 yunfeng. All rights reserved.
//

import UIKit

//自定义代理（联动）
protocol ChanelContentViewDelegate : class {
    func channelContentView(_ contentView : ChannelContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}


private let ContentCellID = "channelContentCell"

class ChannelContentView: UIView {
    
    //定义属性：
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : ChanelContentViewDelegate?

    
    //懒加载控件：
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    init(frame:CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}

//搭建界面：
extension ChannelContentView {
    
    fileprivate func setupUI() {
        
        for childVc in childVcs {
            
            parentViewController?.addChildViewController(childVc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    
    }
 
}



//MARK: - colectionView代理方法：
extension ChannelContentView:UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate {
            return
        }
        
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX {
            
            
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            sourceIndex = Int(currentOffsetX / scrollViewW)
        
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }

            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
            
            
        } else {

            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }

        }
        //将数值传给代理属性
        delegate?.channelContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
    
    
}

//MARK: - collectionView数据源方法
extension ChannelContentView:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //给每一个cell设置内容：
        for view in cell.contentView.subviews {
            
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = bounds
        cell.contentView.addSubview(childVc.view)
        
        
        return cell
    }
    
}

//MARK: - 外界获取到的方法：
extension ChannelContentView {
    
    func setCurrentIndex(_ currentIndex:Int) {
        
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
  
}





