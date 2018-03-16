//
//  ExchangeViewController.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/16.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "交流"
        self.view.backgroundColor = UIColor.white
        
        self.setupView()
       
    }
    
    func setupView()  {
        
        let contentStr = "如果你也在学习Swift，正好也有疑惑，欢迎联系我，我坚信沟通是解决问题的好办法！\n 我的博客：www.guohuaden.com \n 邮箱：wheatden@guohuaden.com。\n欢迎来访！"
        
        let count = contentStr.count
        
        
        //富文本设置
        let attributeString = NSMutableAttributedString(string: contentStr)
        //行间距
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12
        
        attributeString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, count))
        //文字的颜色
        attributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.brown, range: NSMakeRange(0, count))
        
        //文字的背景颜色
        //        attributeString.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.white, range: NSMakeRange(0, count))
        
        //文字的字体和大小
        attributeString.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "HelveticaNeue-Bold", size: 18) as Any, range: NSMakeRange(0, count))
        
        self.textView.attributedText = attributeString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
