//
//  ShowViewController.swift
//  ColorTool
//
//  Created by 秦国华 on 2018/3/14.
//  Copyright © 2018年 秦国华. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    var collectionView :UICollectionView!
    var dataArray :NSMutableArray?
    var colorsArray :NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.initDatas()
        self.initCollectionView()
    }

    func initDatas()  {
        self.dataArray   = NSMutableArray.init()
        self.colorsArray = NSMutableArray.init()
        let filePath:NSString = Bundle.main.path(forResource: "color", ofType: "txt")! as NSString

        let colorValue = try! String(contentsOfFile: filePath as String, encoding: String.Encoding.utf8)

        if !(colorValue.isEmpty){
            let datas = colorValue.components(separatedBy: ";")
            for colorStr in datas {
                if colorStr.isEmpty || !colorStr.contains("/"){
                    return
                }
                let data :Array = colorStr.components(separatedBy: "/")
                let  hexStr :String = data[data.count-2]
                let color = HexToRGBColor(hexStr)
                self.colorsArray?.add(color)
                
                
                let result = HexToRGBValue(hexStr)
                let isDark :Bool = isDarkColor(result.r, green: result.g, blue: result.b)

                let colorDic = ["content":colorStr , "isDark":isDark] as [String : Any]
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
//        flowLayout.minimumLineSpacing = space
//        flowLayout.minimumInteritemSpacing = space
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
        let nib = UINib.init(nibName: "ShowCell", bundle: nil)
        
        self.collectionView.register(nib, forCellWithReuseIdentifier: "ShowCell")
        self.view.addSubview(self.collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray!.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowCell", for: indexPath) as!ShowCell
        
        collectionCell.backgroundColor = UIColor.white
        
        let color = self.colorsArray?[indexPath.row] as? UIColor
        
        let colorDict = self.dataArray?[indexPath.row] as? NSDictionary
        
        collectionCell.configCell(colorDict as! Dictionary<String, Any>, color: color!)
        return collectionCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: false)
        
    }
    
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
