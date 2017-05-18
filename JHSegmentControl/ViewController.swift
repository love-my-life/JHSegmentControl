//
//  ViewController.swift
//  JHSegmentControl
//
//  Created by 李见辉 on 2017/5/17.
//  Copyright © 2017年 李见辉. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,JHSegmentControlDelegaate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let aview = JHSegmentControl.init(frame: CGRect.init(x: 0, y: 64, width: self.view.bounds.size.width, height: 45))
        
        aview.titleNormalColor = UIColor.blue
        aview.titleSelectedColor = UIColor.brown
//        aview.normalBackgroundColor = UIColor.red
//        aview.selectedBackgroundColor = UIColor.black
//        aview.normalBcakgroundImage = UIImage.init(named: "list_tota")
//        aview.selectedBcakgroundImage = UIImage.init(named: "list_hbj")
        aview.indicatorViewHeight = 3
        aview.titleFont = UIFont.systemFont(ofSize: 15)
        
        aview.titleArray = ["新闻","娱乐","体育","综合","少儿","电视剧","电影","音乐","主题推荐"]
        aview.selectDelegate = self
        
        self.view.addSubview(aview)
        
    }
    
    func selectSegmentAction(index: Int) {
        print(index)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

