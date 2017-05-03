//
//  ChannelTitleView.swift
//  Imitate_DY
//
//  Created by 夏琪 on 2017/5/3.
//  Copyright © 2017年 yunfeng. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class ChannelTitleView: UIView {
    
    //定义属性
    fileprivate var isScrollEnable:Bool
    fileprivate var titles:[String]
    
    fileprivate var currentIndex : Int = 0
    
    //懒加载控件
    fileprivate lazy var titleLabels:[UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView:UIScrollView = {
        
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    fileprivate lazy var scrollLine:UIView = {
       
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    init(frame:CGRect,isScrollEnable:Bool,titles:[String]) {
        
        self.isScrollEnable = isScrollEnable
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

//MARK: - 界面搭建
extension ChannelTitleView {
    
    fileprivate func setupUI(){
        
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLabels()
        
        setupBottomLine()
        
    }
    
    //MARK: - 1.添加标签
    fileprivate func setupTitleLabels() {
        
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.lightGray
            label.textAlignment = .center
            
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelChick(_:)))
            label.addGestureRecognizer(tapGes)
            
        }
    
    }
    
    fileprivate func setupBottomLine() {
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
        
    }
  
}

//MARK: - 点击事件
extension ChannelTitleView {
    
    @objc fileprivate func titleLabelChick(_ tapGes:UITapGestureRecognizer) {
        
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        if currentLabel.tag == currentIndex {
            return
        }
        
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.lightGray
        
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.1, animations: {
            
            self.scrollLine.frame.origin.x = scrollLineX
        })
        
        
    }
    
    
    
    
    
}












