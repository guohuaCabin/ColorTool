//
//  AboutViewController.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/16.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController,UIScrollViewDelegate {

    var scrollView :UIScrollView!
    
    var contentTextView :UITextView!
    
    var contentStr :String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "简介"
        self.view.backgroundColor = UIColor.white
        self.initData()
        self.setupViews()

    }
    func initData() {
        
        self.contentStr = "简介：\n  一个简单的颜色转换工具，接触Swift时间也有一年多了，断断续续的去了解，但还没有具体的去实践到项目中，这个小应用算是第一个小实践！Swift还是和Objective-C有很大的区别的，也确实应该这样，不过还是说简洁方便了很多，但使用Swift完成这个小项目也出现了很多不解的地方，后续会慢慢加深理解。这只是一个雏形，以后会慢慢添加一些东西去完善。"
        
    }
    
    func setupViews() {
        
        self.scrollView = UIScrollView.init(frame: CGRect(x: 0, y: NavBarTop, width: SCREEN_W, height: SCREEN_H-NavBarTop))
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)
        
        self.contentTextView = UITextView.init(frame:CGRect(x: 20.0, y: 0.0, width: SCREEN_W-40.0, height: SCREEN_H-NavBarTop))
        self.contentTextView.textColor = UIColor.black
        self.scrollView.addSubview(self.contentTextView)
        
        self.scrollView.contentSize = CGSize(width: SCREEN_W, height: SCREEN_H-NavBarTop+20.0)
        
        let count = self.contentStr.count
        
        //富文本设置
        let attributeString = NSMutableAttributedString(string: self.contentStr!)
        //行间距
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12

        attributeString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, count))
        //文字的颜色
        attributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.brown, range: NSMakeRange(0, count))
        
        //文字的背景颜色
//        attributeString.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.white, range: NSMakeRange(0, count))
        
        //文字的字体和大小
        attributeString.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "HelveticaNeue-Bold", size: 16) as Any, range: NSMakeRange(0, count))
        
        self.contentTextView.attributedText = attributeString
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}














