//
//  WebViewProgress.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/16.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

class WebViewProgress: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isHidden = true
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setprogressLineColor(_ progressLineColor :UIColor) {
        self.backgroundColor = progressLineColor
    }
    
    //开始加载
    func startLoadingAnimation() {
        self.isHidden = false
        
        self.setSW(SCREEN_W*0.2)
        
        UIView.animate(withDuration: 0.4, animations: {
            self.setSW(SCREEN_W*0.6)
        }) { _ in
            self.setSW(SCREEN_W*0.8)
        }
        
        
    }
    
    //结束加载
    func endLoadingAnimation()  {
        UIView.animate(withDuration: 0.2, animations: {
            self.setSW(SCREEN_W)
        }) { _ in
            self.isHidden = true;
        }
    }


}
