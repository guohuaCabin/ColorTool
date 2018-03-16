
//
//  SizeAndColor.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/14.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_W :CGFloat = UIScreen.main.bounds.size.width
let SCREEN_H :CGFloat = UIScreen.main.bounds.size.height

let TabBarH :CGFloat = 49.0

let NavBarH :CGFloat = 44.0

let StateH :CGFloat = UIApplication.shared.statusBarFrame.size.height

let NavBarTop :CGFloat = NavBarH + StateH

//([UIApplication sharedApplication].statusBarFrame.size.height)

func kRGBColorFromHex(rgbValue: Int) -> (UIColor) {
    
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                   alpha: 1.0)
}


/**
 *  16进制 转 RGBA
 */
func rgbaColorFromHex(rgb:Int, alpha:CGFloat) ->UIColor {
    
    return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                   alpha: alpha)
}

/**
 *  16进制 转 RGB
 */
func rgbColorFromHex(rgb:Int) ->UIColor {
    
    return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                   alpha: 1.0)
}

//判断颜色是否是暗色
func isDarkColor(_ red:CGFloat, green:CGFloat, blue:CGFloat) -> Bool {
    if(red*0.299 + red*0.578 + red*0.114 >= 192){ //浅色
        return false
    } else {  //深色
        return true
    }
}

//16进制颜色转rgb
func HexToRGBColor(_ hexStr:String) -> UIColor {
    
    var colorStr = hexStr
    
    if colorStr.isEmpty {
        colorStr = "#000000"
    }
    
    var hexSubStr = ""
    
    if colorStr.contains("#") {
        hexSubStr = (colorStr as NSString).substring(from: 1)
    } else if colorStr.contains("0x") || colorStr.contains("0X") {
        hexSubStr = (colorStr as NSString).substring(from: 2)
    }
    // 存储转换后的数值
    var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0;
    
    // 分别转换进行转换
    let redStr = (hexSubStr as NSString).substring(with: NSRange.init(location: 0, length: 2))
    let greenStr = (hexSubStr as NSString).substring(with: NSRange.init(location: 2, length: 2))
    let blueStr = (hexSubStr as NSString).substring(with: NSRange.init(location: 4, length: 2))
    
    Scanner(string: redStr).scanHexInt32(&red)
    
    Scanner(string: greenStr).scanHexInt32(&green)
    
    Scanner(string: blueStr).scanHexInt32(&blue)
    
    let color = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    
    return color
}

//16进制颜色转rgb
func HexToRGBValue(_ hexStr:String) -> (r:CGFloat, g:CGFloat, b:CGFloat) {
    
    var colorStr = hexStr
    
    if colorStr.isEmpty {
        colorStr = "#000000"
    }
    
    var hexSubStr = ""
    
    if colorStr.contains("#") {
        hexSubStr = (colorStr as NSString).substring(from: 1)
    } else if colorStr.contains("0x") || colorStr.contains("0X") {
        hexSubStr = (colorStr as NSString).substring(from: 2)
    }
    // 存储转换后的数值
    var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0;
    
    // 分别转换进行转换
    let redStr = (hexSubStr as NSString).substring(with: NSRange.init(location: 0, length: 2))
    let greenStr = (hexSubStr as NSString).substring(with: NSRange.init(location: 2, length: 2))
    let blueStr = (hexSubStr as NSString).substring(with: NSRange.init(location: 4, length: 2))
    
    Scanner(string: redStr).scanHexInt32(&red)
    
    Scanner(string: greenStr).scanHexInt32(&green)
    
    Scanner(string: blueStr).scanHexInt32(&blue)
    
    return (CGFloat(red),CGFloat(green),CGFloat(blue))
}







