
//
//  UIView.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/16.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    //设置指定角的圆角
    func setSpecificCorner(roundingCorners: UIRectCorner, cornerSize: CGSize) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerSize)
        
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = self.bounds
        cornerLayer.path = path.cgPath
        
        layer.mask = cornerLayer
    }
    
    //设置圆角
    func setCorner(_ corner: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: corner)
        
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = self.bounds
        cornerLayer.path = path.cgPath
        
        layer.mask = cornerLayer
    }
    
    func setCornerView(_ corner: CGFloat)  {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = corner
    }
    
}
