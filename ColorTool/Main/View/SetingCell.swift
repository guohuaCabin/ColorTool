//
//  SetingCell.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/14.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

class SetingCell: UITableViewCell {

    var titleLab :UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        self.titleLab = UILabel.init(frame: CGRect(x: 20.0, y: 0.0, width: SCREEN_W - 100.0, height:self.frame.size.height))
        self.titleLab.textColor = UIColor.black
        self.titleLab.textAlignment = .left
        self.contentView.addSubview(self.titleLab)
    }
    
    func configCellData(_ content:String) {
        self.titleLab.text = content
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
