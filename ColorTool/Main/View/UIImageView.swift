//
//  UIImageView.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/16.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView{
    
    func setCornerImage(){
        
        weak var weakSelf = self;

        //异步绘制图像
        DispatchQueue.global().async(execute: {
            //1.建立上下文
            UIGraphicsBeginImageContextWithOptions(weakSelf!.bounds.size, true, 0)
            
            //获取当前上下文
            let ctx = UIGraphicsGetCurrentContext()
            
            //设置填充颜色
            UIColor.white.setFill()
            UIRectFill(weakSelf!.bounds)
            
            //2.添加圆及裁切
            ctx?.addEllipse(in: weakSelf!.bounds)
            //裁切
            ctx?.clip()
            
            //3.绘制图像
            weakSelf!.draw(weakSelf!.bounds)
            
            //4.获取绘制的图像
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            //5关闭上下文
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async(execute: {
                weakSelf!.image = image
            })
        })
    }
    
    
}

