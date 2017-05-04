//
//  HomeViewController.swift
//  Imitate_DY
//
//  Created by 夏琪 on 2017/5/3.
//  Copyright © 2017年 yunfeng. All rights reserved.
//

import UIKit





private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    //懒加载控件
    fileprivate lazy var channelTitleView:ChannelTitleView = {
        
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        
        let titleView = ChannelTitleView(frame:titleFrame,isScrollEnable:false,titles:titles)
        
        titleView.delegate = self
        
        return titleView
        
    }()
    
    fileprivate lazy var channelContentView:ChannelContentView = {
        
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(RecreationViewController())
        childVcs.append(FunnyViewController())
        
        let contentView = ChannelContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        
        contentView.delegate = self
        
        return contentView
        
    }()
    
    
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        setupUI()
        
    }
    
    
    
}


extension HomeViewController {
    
    fileprivate func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(channelTitleView)
        view.addSubview(channelContentView)
        
    }
    
    fileprivate func setupNavigationBar() {
        
        //1.左侧barItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(imgName:"logo")
        
        //2.右侧barItem
        let size = CGSize(width:40,height:40)
        let historyItem = UIBarButtonItem(imgName: "image_my_history", highImgName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imgName: "btn_search", highImgName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imgName: "Image_scan", highImgName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
    
    
    
}

//MARK: - 遵守ChanelContentViewDelegate协议：
extension HomeViewController:ChanelContentViewDelegate {
    
    func channelContentView(_ contentView: ChannelContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        
        channelTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
  
}

//MARK: - 遵守ChannelTitleViewDelegate协议：
extension HomeViewController:ChannelTitleViewDelegate {
    
    func channelTitleView(_ titleView: ChannelTitleView, selectedIndex index: Int) {
        
        channelContentView.setCurrentIndex(index)
        
        
    }
    
    
    
    
    
}



