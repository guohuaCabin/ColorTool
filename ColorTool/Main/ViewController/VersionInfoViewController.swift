//
//  VersionInfoViewController.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/16.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

class VersionInfoViewController: UIViewController {
    @IBOutlet weak var versionImgView: UIImageView!
    
    @IBOutlet weak var versionInfoLab: UILabel!
    
    @IBOutlet weak var systemVersionLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "版本"
        self.view.backgroundColor = UIColor.white
        self.setupViews()
        
    }
    
    func setupViews()  {

        self.versionImgView.setCorner(5.0)
        let systemVersion = UIDevice.current.systemVersion
        let deviceModel = UIDevice.current.model
        
        let infoDic = Bundle.main.infoDictionary
        
        let appVersion = infoDic!["CFBundleShortVersionString"] as! String
        
        
        self.versionInfoLab.text = "Version " + appVersion
        
        self.systemVersionLab.text = "您的手机为：" + deviceModel + "  版本为：iOS" + systemVersion
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
