//
//  BaseViewController.swift
//  Imitate_DY
//
//  Created by 夏琪 on 2017/5/4.
//  Copyright © 2017年 yunfeng. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var contentView : UIView?
    
    fileprivate lazy var animatedImgView:UIImageView = {
        
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named : "img_loading_1")!, UIImage(named : "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
    }
    
    
}

//MARK: - 搭建界面
extension BaseViewController {
    
     func setupUI(){
        
        contentView?.isHidden = true
        
        view.addSubview(animatedImgView)
        animatedImgView.startAnimating()
        view.backgroundColor = UIColor.groupTableViewBackground
   
    }
    
    func loadDataFinished() {
        
        animatedImgView.stopAnimating()
        
        animatedImgView.isHidden = true
        
        contentView?.isHidden = false
   
    }
 
    
}

