//
//  DiscoverViewController.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/16.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController ,UIWebViewDelegate{

    var webView :UIWebView!
    var webViewProgress = WebViewProgress()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现"
        self.view.backgroundColor = UIColor.white
        
        self.setupView()
    
    }
    
    func setupView()  {
        
        self.webViewProgress = WebViewProgress.init(frame: CGRect(x: 0.0, y: NavBarTop, width: SCREEN_W, height: 2))
        self.webViewProgress.setprogressLineColor(UIColor.red)
        
        self.view.addSubview(self.webViewProgress)
        
        
        self.webView = UIWebView.init(frame: CGRect(x: 0.0, y: self.webViewProgress.frame.maxY, width: SCREEN_W, height: SCREEN_H-self.webViewProgress.frame.maxY))
        self.webView.delegate = self
        self.view.addSubview(self.webView)
        
        let url = NSURL.init(string: "http://www.guohuaden.com")! as URL
        
        
        let request = NSURLRequest.init(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        
        self.webView.loadRequest(request as URLRequest)
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.webViewProgress.startLoadingAnimation()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.webViewProgress.endLoadingAnimation()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
