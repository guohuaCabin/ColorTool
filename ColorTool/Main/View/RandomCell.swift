//
//  RandomCell.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/16.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

class RandomCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var hexLab: UILabel!
    @IBOutlet weak var rgbLab: UILabel!
    
    func configCell( _ colorDic :Dictionary<String , Any> ,color :UIColor )  {
        
        self.bgView.backgroundColor = color
        
        let colorContent :NSString = colorDic["content"] as! NSString
        
        let contents = colorContent.components(separatedBy: "/")
        
        self.hexLab.text  = "16进制值: " + contents.first!
        self.rgbLab.text  = "RGB值: " + contents.last!
        
        let isDark = colorDic["isDark"] as! Bool
        if (isDark ) {
            self.hexLab.textColor     = UIColor.white
            self.rgbLab.textColor   = UIColor.white
        } else {
            self.hexLab.textColor     = UIColor.black
            self.rgbLab.textColor   = UIColor.black
        }
        
        self.setCornerView(8)
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        
        self.bgView.layer.masksToBounds = true
        self.bgView.layer.borderWidth = 2
        self.bgView.layer.borderColor = UIColor.white.cgColor
        self.bgView.setCornerView(8)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
