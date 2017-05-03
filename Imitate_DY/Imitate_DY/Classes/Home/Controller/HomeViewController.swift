//
//  HomeViewController.swift
//  Imitate_DY
//
//  Created by 夏琪 on 2017/5/3.
//  Copyright © 2017年 yunfeng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        setupUI()
        
    }
    
    
    
}


extension HomeViewController {
    
    fileprivate func setupUI() {
        
        setupNavigationBar()
        
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
