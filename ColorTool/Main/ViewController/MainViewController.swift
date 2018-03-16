//
//  MainViewController.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/14.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    var tabBarView :UIView?
    var slider :UIView?
    let tabbarColor :UIColor = UIColor.darkGray
    let sliderColor :UIColor = UIColor.white
    let titleColor :UIColor = UIColor.white
    
    var currentIndex :NSInteger!
    
    
    let titles = ["转换","展示","随机","设置"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = titles.first
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.initViewController()
    }
    
    //MARK : create views
    func setupViews() {
        self.view.backgroundColor = UIColor.white
        self.tabBar.isHidden = true
        
//        let width :CGFloat = self.view.bounds.size.width
//        let height :CGFloat = self.view.bounds.size.height
        
        let tabbarViewY :CGFloat = SCREEN_H-TabBarH
        
        let space:CGFloat = 8
        let count:CGFloat = CGFloat(titles.count)
        
        let tabbarBtnW :CGFloat = (SCREEN_W-(CGFloat)(count-1)*space)/count
    
        self.tabBarView = UIView.init(frame: CGRect(x: 0, y: tabbarViewY, width: SCREEN_W, height: TabBarH))
        self.tabBarView?.backgroundColor = tabbarColor
        self.view.addSubview(self.tabBarView!)
        
        self.slider = UIView.init(frame: CGRect(x: 0, y: 0, width: tabbarBtnW, height: TabBarH))
        self.slider?.backgroundColor = sliderColor
        self.tabBarView?.addSubview(self.slider!)
        
        var index:NSInteger = 0
        for title in titles {
            let button = UIButton.init(frame: CGRect(x: CGFloat(index)*(tabbarBtnW+space), y: 0, width: tabbarBtnW, height: TabBarH))
            button.tag = index+1000
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.backgroundColor = UIColor.clear
            button.addTarget(self, action: #selector(tabbarBtnClicked(_:)), for: .touchUpInside)
            
            self.tabBarView?.addSubview(button)
            if index == 0 {
                button.isSelected = true
                self.currentIndex = button.tag;
                button.setTitleColor(UIColor.black, for: .normal)
            }
            index += 1
            
        }
        
    }
    
    //MARK: init viewController
    func initViewController() {
        let homeVC = HomeViewController()
        let showVC = ShowViewController()
        let randomVC = RandomViewController()
        let setingVC = SetingViewController()
        
        self.viewControllers = [homeVC,showVC,randomVC,setingVC]
        
        //修改“返回按钮”的文字
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    
    //MARK: tabbar click
    @objc func tabbarBtnClicked(_ sender:UIButton) {
        
        let senderTag = sender.tag-1000

        let currentBtn = self.view.viewWithTag(self.currentIndex) as! UIButton
        
        if senderTag == self.currentIndex {
            sender.setTitleColor(UIColor.black, for: .normal)
        } else {
            sender.setTitleColor(UIColor.black, for: .normal)
            currentBtn.setTitleColor(titleColor, for: .normal)
        }
        
        self.currentIndex = sender.tag
        
        UIView.animate(withDuration: 0.3, animations: {
            self.slider!.frame = CGRect(x: sender.frame.origin.x, y: 0, width: self.slider!.frame.size.width, height: self.slider!.frame.size.height)
            
        })
        
        self.title = self.titles[senderTag]
        self.selectedIndex = senderTag
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
