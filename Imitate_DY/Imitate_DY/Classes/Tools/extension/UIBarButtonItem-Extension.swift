//
//  UIBarButtonItem-Extension.swift
//  Imitate_DY
//
//  Created by 夏琪 on 2017/5/3.
//  Copyright © 2017年 yunfeng. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imgName:String,highImgName:String = "",size:CGSize = CGSize.zero){
        
        let btn = UIButton()
        btn.setImage(UIImage(named:imgName), for: UIControlState())
        if highImgName != "" {
            
            btn.setImage(UIImage(named:highImgName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView:btn)
    }
    
    
}
