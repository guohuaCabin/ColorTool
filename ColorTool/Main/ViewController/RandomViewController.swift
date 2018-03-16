//
//  RandomViewController.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/16.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var collectionView :UICollectionView!
    var colorsArray :NSMutableArray!
    var dataArray :NSMutableArray!
    var isPullRefresh :Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.isPullRefresh = true
        self.dataArray   = NSMutableArray.init()
        self.colorsArray = NSMutableArray.init()
        self.initDatas()
        self.initCollectionView()
    }
    
    func initDatas() {
        
        if self.isPullRefresh {
            self.colorsArray.removeAllObjects()
            self.dataArray.removeAllObjects()
        }
        
        //创建一个全局队列。
        //get a global queue
        let globalQueue = DispatchQueue.global()
        //使用全局队列，开启异步任务。
        globalQueue.async {
            for _ in 0...9 {
                let red = CGFloat(arc4random()%256)/255.0
                let green = CGFloat(arc4random()%256)/255.0
                let blue = CGFloat(arc4random()%256)/255.0
                
                let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
                let hexStr = String(format: self.hexFromUIColor(color))
                let rgbStr = String(format:"%d、%d、%d",NSInteger(red*255),NSInteger(green*255),NSInteger(blue*255))
                
                let isDark :Bool = isDarkColor(red, green: green, blue: blue)
                let colorStr = hexStr + "/" + rgbStr
                
                let colorDic = ["content":colorStr , "isDark":isDark] as [String : Any]
                
                self.colorsArray.add(color)
                self.dataArray?.add(colorDic)
            }
        }
        
    }
    
    func initCollectionView() {
        
        let space :CGFloat = 10.0
        let cellW = (SCREEN_W - space*2.0)/2.0
        let cellH = cellW/3*4
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellW, height: cellH)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsetsMake(space/2, space/2, space/2, space/2)
        // 设置UICollectionView 的页头尺寸
        flowLayout.headerReferenceSize = CGSize(width: 100.0, height: 20.0)
        //设置 UICollectionView 的页尾尺寸
        flowLayout.footerReferenceSize = CGSize(width: 100.0, height: 20.0)
        
        self.collectionView = UICollectionView.init(frame: CGRect(x: 0, y: NavBarTop, width: SCREEN_W, height: SCREEN_H-NavBarTop-TabBarH), collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.white
        // 设置 UICollectionView 垂直滚动是否滚到 Item 的最底部内容
        self.collectionView.alwaysBounceVertical = true
        
        // 设置 UICollectionView 垂直滚动是否滚到 Item 的最右边内容
        self.collectionView.alwaysBounceHorizontal = false
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        //设置 UICollectionView 的单元格多选(默认是 false)
        self.collectionView.allowsMultipleSelection = false
        //设置 UICollectionView 的单元格点击(默认是 true)
        self.collectionView.allowsSelection = true
        
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator  = false
        //分页
        //        self.collectionView.isPagingEnabled = true
        let nib = UINib.init(nibName: "RandomCell", bundle: nil)
        
        self.collectionView.register(nib, forCellWithReuseIdentifier: "RandomCell")
        self.view.addSubview(self.collectionView)
        
        self.collectionView.es.addPullToRefresh {
            self.isPullRefresh = true
            self.initDatas()
            //延时2秒执行
            self.delay(1, task: {
                self.collectionView.es.stopPullToRefresh()
                self.collectionView.reloadData()
            })
            
        }
        
        self.collectionView.es.addInfiniteScrolling {
            self.isPullRefresh = false
            self.initDatas()
//            self.delay(2, task: {
//                self.collectionView.es.stopLoadingMore()
//                self.collectionView.reloadData()
//            })
            //延时1秒执行
            let time: TimeInterval = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                self.collectionView.es.stopLoadingMore()
                self.collectionView.reloadData()
            }
            
        }
        
    }
    
    //根据颜色得到16进制数
    func hexFromUIColor(_ color:UIColor) -> String {
        var r:CGFloat = 0.0, g:CGFloat = 0.0, b:CGFloat = 0.0, a:CGFloat = 0.0;
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb :Int = (Int) (r * 255.0)<<16 | (Int) (g * 255.0)<<8 | (Int) (b * 255.0)<<0;
        
        return String(format: "#%06X", rgb);
    }
    
    //MARK: collectionDegelate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colorsArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomCell", for: indexPath) as! RandomCell
        
        collectionCell.backgroundColor = UIColor.white
        
        let color = self.colorsArray?[indexPath.row] as? UIColor
        
        let colorDict = self.dataArray?[indexPath.row] as? NSDictionary
        
        collectionCell.configCell(colorDict as! Dictionary<String, Any>, color: color!)
        return collectionCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: false)
        
    }
    
    //MARK : 延迟执行
    typealias Task = (_ cancel : Bool) -> Void
    
    func delay(_ time: TimeInterval, task: @escaping ()->()) ->  Task? {
        
        func dispatch_later(block: @escaping ()->()) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        var closure: (()->Void)? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        return result
    }
    
    func cancel(_ task: Task?) {
        task?(true)
    }


}
