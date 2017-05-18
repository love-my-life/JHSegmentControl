//
//  JHSegmentControl.swift
//  JHSegmentControl
//
//  Created by 李见辉 on 2017/5/17.
//  Copyright © 2017年 李见辉. All rights reserved.
//

import UIKit

protocol JHSegmentControlDelegaate:NSObjectProtocol {
    func selectSegmentAction(index:Int)
}

class JHSegmentControl: UIScrollView {
    
    fileprivate var selectedIndex : Int! = 0
    fileprivate var x : CGFloat = 0
    fileprivate var indicatorView : UIView = UIView()
    
    weak var selectDelegate : JHSegmentControlDelegaate!
    
    
    var titleArray : Array<String>! {
        //监听数组的变化
        willSet(newValue) {
            self.titleArray = newValue
        }
        didSet {
            self.creatBtn()
        }
    }
    //正常状态下字体颜色
    var titleNormalColor : UIColor! {
        didSet {
            
            for view in self.subviews {
                if view.classForCoder == UIButton.classForCoder() {
                    let button = view as! UIButton
                    button.setTitleColor(self.titleNormalColor, for: .normal)
                }
            }
        }
    }
    //选中状态下字体颜色
    var titleSelectedColor : UIColor! {
        didSet {
            for view in self.subviews {
                if view.classForCoder == UIButton.classForCoder() {
                    let button = view as! UIButton
                    button.setTitleColor(self.titleSelectedColor, for: .selected)
                }
            }
            self.indicatorView.backgroundColor = self.titleSelectedColor
        }
    }
    //正常状态下按钮背景颜色
    var normalBackgroundColor : UIColor! {
        didSet {
            for view in self.subviews {
                if view.classForCoder == UIButton.classForCoder() {
                    let button = view as! UIButton
                    if !button.isSelected {
                        button.backgroundColor = self.normalBackgroundColor
                    }
                }
            }
        }
    }
    //选中状态下按钮的背景色
    var selectedBackgroundColor : UIColor! {
        didSet {
            for view in self.subviews {
                if view.classForCoder == UIButton.classForCoder() {
                    let button = view as! UIButton
                    if button.isSelected {
                        button.backgroundColor = self.selectedBackgroundColor
                    }
                }
            }
        }
    }
    //正常状态下按钮的背景图片
    var normalBcakgroundImage : UIImage! {
        didSet {
            for view in self.subviews {
                if view.classForCoder == UIButton.classForCoder() {
                    let button = view as! UIButton
                    button.setBackgroundImage(self.normalBcakgroundImage, for: .normal)
                }
            }
        }
    }
    //选中状态下按钮的背景图片
    var selectedBcakgroundImage : UIImage! {
        didSet {
            for view in self.subviews {
                if view.classForCoder == UIButton.classForCoder() {
                    let button = view as! UIButton
                    button.setBackgroundImage(self.selectedBcakgroundImage, for: .selected)
                }
            }
        }
    }
    //是否显示选中指示条
    var isShowIndicator : Bool! {
        didSet {
            self.indicatorView.isHidden = !self.isShowIndicator
        }
    }
    //选中指示条的宽度
    var indicatorViewHeight : CGFloat! {
        didSet {
            let rect = self.indicatorView.frame
            
            self.indicatorView.frame = CGRect.init(x: rect.origin.x, y: self.bounds.size.height - self.indicatorViewHeight, width: rect.size.width, height: self.indicatorViewHeight)
        }
    }
    //字体大小
    var titleFont : UIFont! {
        didSet {
            if self.titleArray == nil || self.titleArray.count == 0 {
                for view in self.subviews {
                    if view.classForCoder == UIButton.classForCoder() {
                        let button = view as! UIButton
                        button.titleLabel?.font = self.titleFont
                    }
                }
            }else{
                self.creatBtn()
            }
        }
    }
    
    
    
    //创建button
    fileprivate func creatBtn() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        x = 0
        for i in 0..<self.titleArray.count {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            let  attributes = [
                NSFontAttributeName:(self.titleFont == nil ? UIFont.systemFont(ofSize: 14) : self.titleFont)!,
                NSParagraphStyleAttributeName:paragraphStyle.copy()
            ]
            let titleSize = (self.titleArray[i]).boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 16), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
            
            let button = UIButton.init(type: .custom)
            button.setTitle(self.titleArray[i], for: .normal)
            button.setTitle(self.titleArray[i], for: .selected)
            button.titleLabel?.font = self.titleFont == nil ? UIFont.systemFont(ofSize: 14) : self.titleFont
            button.tag = 6000 + i
            
            if self.titleNormalColor == nil {
                button.setTitleColor(UIColor.black, for: .normal)
            }else{
                button.setTitleColor(self.titleNormalColor, for: .normal)
            }
            if self.titleSelectedColor == nil {
                button.setTitleColor(UIColor.red, for: .selected)
            }else{
                button.setTitleColor(self.titleSelectedColor, for: .selected)
            }
            if self.normalBcakgroundImage == nil {
                button.setBackgroundImage(UIImage.init(named: ""), for: .normal)
            }else{
                button.setBackgroundImage(self.normalBcakgroundImage, for: .normal)
            }
            if self.selectedBcakgroundImage == nil {
                button.setBackgroundImage(UIImage.init(named: ""), for: .selected)
            }else{
                button.setBackgroundImage(self.selectedBcakgroundImage, for: .selected)
            }
            
            if self.normalBackgroundColor == nil {
                button.backgroundColor = UIColor.clear
            }else{
                button.backgroundColor = self.normalBackgroundColor
            }
            
            button.clipsToBounds = true
            
            var width : CGFloat = 0
            width = titleSize.width + 20
            button.frame = CGRect.init(x: x, y: 0, width: width, height: self.bounds.size.height)
            self.addSubview(button)
            button.addTarget(self, action: #selector(self.selectedBtnAction(sender:)), for: .touchUpInside)
            
            if i == (self.selectedIndex == nil ? 0 : self.selectedIndex) {
                button.isSelected = true
                let height = self.indicatorViewHeight == nil ? 2 : self.indicatorViewHeight
                
                self.indicatorView.frame = CGRect.init(x: 0, y: self.bounds.size.height - height!, width: width - 10, height: height!)
                self.indicatorView.center.x = button.center.x
                self.indicatorView.backgroundColor = button.titleLabel?.textColor
                self.addSubview(self.indicatorView)
                if self.selectedBackgroundColor == nil {
                    button.backgroundColor = UIColor.clear
                }else{
                    button.backgroundColor = self.selectedBackgroundColor
                }
            }
            
            x = x + width
        }
        self.contentSize = CGSize.init(width: x, height: self.bounds.size.height)
        self.bringSubview(toFront: self.indicatorView)
        self.indicatorView.isHidden = self.isShowIndicator == nil ? false : !self.isShowIndicator
    }
    
    
    @objc fileprivate func selectedBtnAction(sender:UIButton) {
        self.selectedIndex = sender.tag - 6000
        for view in self.subviews {
            if view.classForCoder == UIButton.classForCoder() {
                let button = view as! UIButton
                button.isSelected = false
                button.backgroundColor = normalBackgroundColor
            }
        }
        sender.isSelected = true
        let bound = self.indicatorView.bounds
        
        UIView.animate(withDuration: 0.2) { 
            self.indicatorView.center.x = sender.center.x
            self.indicatorView.bounds = CGRect.init(x: bound.origin.x, y: bound.origin.y, width: sender.bounds.size.width - 10, height: bound.size.height)
        }
        let rect = self.convert(CGRect.init(x: sender.frame.origin.x - self.frame.size.width/2, y: sender.frame.origin.y, width:  self.frame.size.width+10, height: sender.frame.size.height), to: self)
        self.scrollRectToVisible(rect, animated: true)
        sender.backgroundColor = selectedBackgroundColor
        if self.selectDelegate != nil {
            self.selectDelegate.selectSegmentAction(index: self.selectedIndex)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
