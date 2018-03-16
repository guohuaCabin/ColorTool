//
//  ShowCell.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/15.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

class ShowCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    
    
    func configCell(_ dict:Dictionary<String, Any> ,color:UIColor)  {
        self.titleLab.adjustsFontSizeToFitWidth = true
        self.contentLab.adjustsFontSizeToFitWidth = true
        self.bgView.backgroundColor = color
        
        //   content:     LightPink/浅粉红/#FFB6C1/255,182,193
        let infoStr     = dict["content"] as! NSString
        let strArray    = infoStr.components(separatedBy: "/")
        
        let titleStr    = strArray.first! + " / " + strArray[1]
        let contentStr  = strArray[2] + " / " + strArray.last!

        self.titleLab.text      = titleStr
        self.contentLab.text    = contentStr

        let isDark = dict["isDark"] as! Bool
        if (isDark ) {
            self.titleLab.textColor     = UIColor.white
            self.contentLab.textColor   = UIColor.white
        } else {
            self.titleLab.textColor     = UIColor.black
            self.contentLab.textColor   = UIColor.black
        }
       
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        
        self.bgView.layer.masksToBounds = true
        self.bgView.layer.borderWidth = 2
        self.bgView.layer.borderColor = UIColor.white.cgColor
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
