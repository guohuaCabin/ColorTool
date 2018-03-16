//
//  HomeViewController.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/14.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

enum ChangeBtnType {
    case ChangeBtnType_RGB
    case ChangeBtnType_HEX
}


class HomeViewController: UIViewController,UIScrollViewDelegate,UITextFieldDelegate {

    var changeBtnType :ChangeBtnType = .ChangeBtnType_RGB
    
    //R、G、B color
    var radTextField :UITextField!
    var greenTextField :UITextField!
    var blueTextField :UITextField!
    var rgbShowView :UIView?
    var rgbShowLab :UILabel?
    var rgbShowHexLab :UILabel?
    
    var rgbChangeBtn :UIButton?
    
    //16 hex
    var hexTextField :UITextField!
    var hexShowView :UIView?
    var hexShowLab :UILabel?
    var hexShowRgbLab :UILabel?
    
    // change btn
    var hexChangeBtn :UIButton?
    
    //scrollView
    var scrollView :UIScrollView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.createView()
    }
    
    
    func createView() {
        
        self.scrollView = UIScrollView.init(frame: self.view.bounds)
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)
        
        let leftSpace :CGFloat = 20.0
        let topSpace :CGFloat = 30.0
        
        let explainLab = UILabel.init(frame: CGRect(x: leftSpace, y: topSpace, width: SCREEN_W-leftSpace*2, height: 120))
        explainLab.numberOfLines = 0
        explainLab.text = "注：\n 【1】R、G、B 输入均为：大于0且小于255的小数，默认为等于0，输入大于 255 时默认为 255 \n 【2】 16进制数输入格式为：#或者 0x 加 6位数字或6个字母"
        explainLab.textColor = UIColor.red
        self.scrollView.addSubview(explainLab)
        
        let  rgbArray = ["R","G","B"]
        
        let count :CGFloat = CGFloat(rgbArray.count)
        
        let textFieldW :CGFloat = (SCREEN_W - (count+1.0)*leftSpace)/count
        
        let commonH :CGFloat = 40.0
        
        var index = 0
        for title in rgbArray {
            let textFieldFrame = CGRect(x:leftSpace+(leftSpace+textFieldW)*CGFloat(index), y: explainLab.frame.maxY+20.0, width: textFieldW, height: commonH)
            
            let textField = UITextField.init(frame: textFieldFrame)
            textField.textColor = UIColor.black
            textField.placeholder = title
            textField.delegate = self
            textField.adjustsFontSizeToFitWidth = true
            textField.layer.masksToBounds = true
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 3
            textField.textAlignment = .left
            textField.tag = 100+index
            textField.keyboardType = .decimalPad
            self.scrollView.addSubview(textField)
            index += 1
        }
        
        //R 、G、 B
        self.radTextField = self.view.viewWithTag(100) as!UITextField
        self.greenTextField = self.view.viewWithTag(101) as!UITextField
        self.blueTextField = self.view.viewWithTag(102) as!UITextField
        
        //rgbBtn
        let rgbChangeBtnW :CGFloat = 180.0
        let rgbChangeBtnX :CGFloat = (SCREEN_W - rgbChangeBtnW)*0.5
        
        self.rgbChangeBtn = UIButton.init(frame: CGRect(x: rgbChangeBtnX, y: self.greenTextField.frame.maxY+50.0, width: rgbChangeBtnW, height: commonH))
        
        self.rgbChangeBtn?.setTitle("转换为16进制颜色", for: .normal)
        self.rgbChangeBtn?.backgroundColor = UIColor.darkGray
        self.rgbChangeBtn?.setTitleColor(UIColor.white, for: .normal)
        self.rgbChangeBtn?.addTarget(self, action: #selector(rgbChangeBtnClicked(_:)), for: .touchUpInside)
        self.rgbChangeBtn?.tag = 10
        self.rgbChangeBtn?.layer.masksToBounds = true
        self.rgbChangeBtn?.layer.borderColor = UIColor.white.cgColor
        self.rgbChangeBtn?.layer.borderWidth = 1
        self.rgbChangeBtn?.layer.cornerRadius = 3
        self.scrollView.addSubview(self.rgbChangeBtn!)
        
        //rgbShowView
        self.rgbShowView = UIView.init(frame: CGRect(x: leftSpace, y: (self.rgbChangeBtn?.frame.maxY)!+50.0, width: SCREEN_W - leftSpace*2.0, height: 150.0))
        self.rgbShowView?.layer.borderColor = UIColor.black.cgColor
        self.rgbShowView?.layer.borderWidth = 1
        self.rgbShowView?.layer.cornerRadius = 5
        self.rgbShowView?.layer.masksToBounds = true
        self.hexShowView?.backgroundColor = UIColor.clear
        self.scrollView.addSubview(self.rgbShowView!)
        
        //rgbShowLab
        self.rgbShowLab = UILabel.init(frame: CGRect(x: 0.0, y: (self.rgbShowView?.frame.size.height)!-40.0, width: (self.rgbShowView?.frame.size.width)!, height: 20.0))
        self.rgbShowLab?.text = ""
        self.rgbShowLab?.textColor = UIColor.black
        self.rgbShowView?.addSubview(self.rgbShowLab!)
        
        //rgbShowHexLab
        self.rgbShowHexLab = UILabel.init(frame: CGRect(x: 0.0, y: (self.rgbShowView?.frame.size.height)!-20.0, width: (self.rgbShowView?.frame.size.width)!, height: 20.0))
        self.rgbShowHexLab?.text = ""
        self.rgbShowHexLab?.textColor = UIColor.black
        self.rgbShowView?.addSubview(self.rgbShowHexLab!)
        
        //hextextFiled
        let hexW :CGFloat = (SCREEN_W - leftSpace*3.0)*0.5
        
        self.hexTextField = UITextField.init(frame: CGRect(x: leftSpace, y: (self.rgbShowView?.frame.maxY)!+50.0, width: hexW, height: commonH))
        self.hexTextField.textColor = UIColor.black
        self.hexTextField.placeholder = title
        self.hexTextField.placeholder = "16进制颜色码"
        self.hexTextField.delegate = self
        self.hexTextField.adjustsFontSizeToFitWidth = true
        self.hexTextField.layer.masksToBounds = true
        self.hexTextField.layer.borderColor = UIColor.gray.cgColor
        self.hexTextField.layer.borderWidth = 1
        self.hexTextField.layer.cornerRadius = 3
        self.hexTextField.textAlignment = .left
        self.hexTextField.keyboardType = .default
        self.scrollView.addSubview(self.hexTextField)
        
        //hexChangeBtn
        self.hexChangeBtn = UIButton.init(frame: CGRect(x: self.hexTextField.frame.maxX+leftSpace, y: (self.rgbShowView?.frame.maxY)!+50.0, width: hexW, height: commonH))
        self.hexChangeBtn?.setTitle("转换为RGB颜色", for: .normal)
        self.hexChangeBtn?.backgroundColor = UIColor.darkGray
        self.hexChangeBtn?.setTitleColor(UIColor.white, for: .normal)
        self.hexChangeBtn?.addTarget(self, action: #selector(rgbChangeBtnClicked(_:)), for: .touchUpInside)
        self.hexChangeBtn?.tag = 20
        self.hexChangeBtn?.layer.masksToBounds = true
        self.hexChangeBtn?.layer.borderColor = UIColor.white.cgColor
        self.hexChangeBtn?.layer.borderWidth = 1
        self.hexChangeBtn?.layer.cornerRadius = 3
        self.scrollView.addSubview(self.hexChangeBtn!)
        
        //rgbShowView
        self.hexShowView = UIView.init(frame: CGRect(x: leftSpace, y: (self.hexChangeBtn?.frame.maxY)!+50.0, width: SCREEN_W - leftSpace*2.0, height: 150.0))
        self.hexShowView?.layer.borderColor = UIColor.black.cgColor
        self.hexShowView?.layer.borderWidth = 1
        self.hexShowView?.layer.cornerRadius = 5
        self.hexShowView?.layer.masksToBounds = true
        self.hexShowView?.backgroundColor = UIColor.clear
        self.scrollView.addSubview(self.hexShowView!)
        
        //rgbShowLab
        self.hexShowLab = UILabel.init(frame: CGRect(x: 0.0, y: (self.hexShowView?.frame.size.height)!-50.0, width: (self.hexShowView?.frame.size.width)!, height: 20.0))
        self.hexShowLab?.text = ""
        self.hexShowLab?.textColor = UIColor.black
        self.hexShowView?.addSubview(self.hexShowLab!)
        
        //rgbShowHexLab
        self.hexShowRgbLab = UILabel.init(frame: CGRect(x: 0.0, y: (self.hexShowView?.frame.size.height)!-25.0, width: (self.hexShowView?.frame.size.width)!, height: 20.0))
        self.hexShowRgbLab?.text = ""
        self.hexShowRgbLab?.textColor = UIColor.black
        self.hexShowView?.addSubview(self.hexShowRgbLab!)
        
        
        self.scrollView.contentSize = CGSize(width: SCREEN_W, height: (self.hexShowView?.frame.maxY)!+100.0)
        
        //tap
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClicked(_:)))
        self.scrollView.addGestureRecognizer(tap)
        
    }
    //MARK: clicked
    @objc func rgbChangeBtnClicked(_ sender:UIButton) {
        if sender.tag == 10 {
            self.rgbToHexHandle()
        } else if sender.tag == 20{
            self.hexToRgbHandle()
        }
        self.view.endEditing(true)
    }
    
    @objc func tapClicked(_ sender:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //rgb 转 16进制 处理
    func rgbToHexHandle(){
        
        let redStr = NSString(string: self.radTextField.text!)
        let greenStr = NSString(string: self.greenTextField.text!)
        let blueStr = NSString(string: self.blueTextField.text!)
        var redNumber:CGFloat = CGFloat(redStr.floatValue)
        var greenNumber:CGFloat = CGFloat(greenStr.floatValue)
        var blueNumber:CGFloat = CGFloat(blueStr.floatValue)
        if redNumber == 0 {
            redNumber = 0.0
        }
        if redNumber >= 255.0 {
            redNumber = 255.0
        }
        if greenNumber == 0 {
            greenNumber = 0.0
        }
        if greenNumber >= 255.0 {
            greenNumber = 255.0
        }
        if blueNumber == 0 {
            blueNumber = 0.0
        }
        if blueNumber >= 255.0 {
            blueNumber = 255.0
        }
        
        let rgbColor = UIColor(red: redNumber/255.0, green: greenNumber/255.0, blue: blueNumber/255.0, alpha: 1.0)
        
        self.rgbShowView?.backgroundColor = rgbColor
        
        let isDark = isDarkColor(redNumber, green: greenNumber, blue: blueNumber)
        
        if isDark {
            self.rgbShowLab?.textColor = UIColor.white
            self.rgbShowHexLab?.textColor = UIColor.white
        } else {
            
            self.rgbShowLab?.textColor = UIColor.black
            self.rgbShowHexLab?.textColor = UIColor.black
        }
        
        self.rgbShowLab?.text = " Red: \(NSInteger(redNumber))   Green: \(NSInteger(greenNumber))   Blue: \(NSInteger(blueNumber))"
        
        self.rgbShowHexLab?.text = String(format: " 16进制数值: \(self.hexFromUIColor(rgbColor))")
        

    }
    
    //16进制 转 rgb 处理
    func hexToRgbHandle(){
        let hexColor :UIColor
        var hexStr = self.hexTextField.text!
        if hexStr.isEmpty {
            hexStr = "#000000"
        }
        
        var hexSubStr = ""
        
        if hexStr.contains("#") {
            hexSubStr = (hexStr as NSString).substring(from: 1)
        } else if hexStr.contains("0x") || hexStr.contains("0X") {
            hexSubStr = (hexStr as NSString).substring(from: 2)
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

        let isDark = isDarkColor(CGFloat(red), green: CGFloat(green), blue: CGFloat(blue))
        
        if isDark {
            self.hexShowLab?.textColor = UIColor.white
            self.hexShowRgbLab?.textColor = UIColor.white
        } else {
            
            self.hexShowLab?.textColor = UIColor.black
            self.hexShowRgbLab?.textColor = UIColor.black
        }
        
        self.hexShowLab?.text = " Red: \(red)   Green: \(red)   Blue: \(red)"
        
        self.hexShowRgbLab?.text = String(format: " 16进制数值: \(hexStr)")
        
        hexColor = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
        
        self.hexShowView?.backgroundColor = hexColor
        
    }
    
    //根据颜色得到16进制数
    func hexFromUIColor(_ color:UIColor) -> String {
        var r:CGFloat = 0.0, g:CGFloat = 0.0, b:CGFloat = 0.0, a:CGFloat = 0.0;
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb :Int = (Int) (r * 255.0)<<16 | (Int) (g * 255.0)<<8 | (Int) (b * 255.0)<<0;
        
        return String(format: "#%06X", rgb);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
}
