//
//  XBSetAddGoodsShopCartView.swift
//  LiuXinLife
//
//  Created by 信宝网络科技 on 2018/11/29.
//  Copyright © 2018年 信宝网络科技. All rights reserved.
//

import UIKit

class XBSetAddGoodsShopCartView: UIView {
    
    var flowlayout: CollectionViewAlignFlowLayout!
    var logoImg : UIImageView!
    var moneyLabel : XUILabel!
    var infoLabel : XUILabel!
    var selectLabel : XUILabel!
    var selectCell : XBSetAddGoodsCollectionViewCell!
    var bgView : UIView!
    
    var dataArr = ["单个装 5-40型号","单个装 5-40型号单个装 5-40型号","单个装 5-40型号231231","单个装","单个装 2222","单个装 5-40型号","单个装 5-40型号单个装 5-40型号","单个装 5-40型号231231","单个装","单个装 2222","单个装 5-40型号","单个装 5-40型号单个装 5-40型号","单个装 5-40型号231231","单个装","单个装 2222","单个装 5-40型号","单个装 5-40型号单个装 5-40型号","单个装 5-40型号231231","单个装","单个装 2222","单个装 5-40型号","单个装 5-40型号单个装 5-40型号","单个装 5-40型号231231","单个装","单个装 2222"]
    
    lazy var collectionView: UICollectionView = {
        flowlayout = CollectionViewAlignFlowLayout(AlignType.left, 10*W)
        flowlayout.minimumLineSpacing = 10*W
        flowlayout.minimumInteritemSpacing = 15*W
        flowlayout.sectionInset = UIEdgeInsets.init(top: 10*W, left: 10*W, bottom: 10*W, right: 10*W)
        
        let collectionView = UICollectionView(frame: CGRect(x:0, y: 0, width:0, height:0), collectionViewLayout: flowlayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //纯代码注册cell
        collectionView.register(XBSetAddGoodsCollectionViewCell.self, forCellWithReuseIdentifier:"XBSetAddGoodsCollectionViewCell")
        collectionView.register(XBSetAddGoodsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "XBSetAddGoodsCollectionReusableView")
        

        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        
        collectionView.scrollIndicatorInsets = collectionView.contentInset
        return collectionView
    }()
    
    lazy var footerView : UIView = {
        let footerView = UIView.init(frame: CGRect(x: 0, y: collectionView.frame.maxY, width: screenSize.width, height: height49))
        footerView.backgroundColor = UIColor.white
        footerView.layer.shadowColor = UIColor.gray.cgColor
        footerView.layer.shadowOffset = CGSize.init(width: -1, height: -1)
        footerView.layer.shadowOpacity = 0.3
        
        let nameArr = ["加入购物车","去支付"]
        let colorArr = ["#2ca4bf","#df3447"]
        for (i,name) in nameArr.enumerated() {
            let btn = UIButton.init(frame: CGRect(x: screenSize.width/2*CGFloat(i), y: 0, width: screenSize.width/2, height: 49))
            btn.backgroundColor = UIColor.init(hexString: colorArr[i])
            btn.setTitle(name, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14*W)
            footerView.addSubview(btn)
            btn.tag = i + 100
            btn.addTarget(self, action: #selector(self.btnAction(btn:)), for: .touchUpInside)
        }
        
        return footerView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        let bgBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: screenSize.width, height:  screenSize.height - 525*H))
        bgBtn.backgroundColor = UIColor.clear
        bgBtn.addTarget(self, action: #selector(self.backBtnAction), for: .touchUpInside)
        addSubview(bgBtn)
        
        bgView = UIView.init(frame: CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 535*H))
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 6
        addSubview(bgView)
        
        let backBtn = UIButton.init(frame: CGRect(x: screenSize.width-35, y: 10, width: 25, height: 25))
        backBtn.setImage(#imageLiteral(resourceName: "图层5"), for: .normal)
        bgView.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(self.backBtnAction), for: .touchUpInside)
        
        //头部
        logoImg = UIImageView.init(frame: CGRect(x: 10*W, y: 10*W, width: 75*W, height: 90*W))
        logoImg.backgroundColor = UIColor.yellow
        bgView.addSubview(logoImg)
        
        moneyLabel = XUILabel.init(frame: CGRect(x: logoImg.frame.maxX+10*W, y: 25*W, width: screenSize.width-(logoImg.frame.maxX+20*W), height: 20*W))
        moneyLabel.text = "￥3588元"
        moneyLabel.textColor = UIColor.init(hexString: "#f66200")
        moneyLabel.font = UIFont.systemFont(ofSize: 12*W)
        moneyLabel.verticalAlignment = VerticalAlignmentMiddle
        bgView.addSubview(moneyLabel)
        
        infoLabel = XUILabel.init(frame: CGRect(x: moneyLabel.frame.minX, y: moneyLabel.frame.maxY, width: moneyLabel.frame.size.width, height: 20*W))
        infoLabel.text = "雪铁龙原厂机油5W-40"
        infoLabel.textColor = LabelColor_153
        infoLabel.font = UIFont.systemFont(ofSize: 13*W)
        infoLabel.verticalAlignment = VerticalAlignmentMiddle
        bgView.addSubview(infoLabel)
        
        selectLabel = XUILabel.init(frame: CGRect(x: moneyLabel.frame.minX, y: infoLabel.frame.maxY, width: moneyLabel.frame.size.width, height: 20*W))
        selectLabel.text = "已选：单个装 5-40型号"
        selectLabel.textColor = LabelColor_51
        selectLabel.font = UIFont.systemFont(ofSize: 13*W)
        selectLabel.verticalAlignment = VerticalAlignmentMiddle
        bgView.addSubview(selectLabel)
        
        let guigeLabel = XUILabel.init(frame: CGRect(x: logoImg.frame.minX, y: logoImg.frame.maxY+5*W, width: 100, height: 20*W))
        guigeLabel.text = "规格"
        guigeLabel.textColor = LabelColor_51
        guigeLabel.font = UIFont.systemFont(ofSize: 13*W)
        guigeLabel.verticalAlignment = VerticalAlignmentMiddle
        bgView.addSubview(guigeLabel)
        
        collectionView.frame = CGRect(x: 0, y: guigeLabel.frame.maxY+5*W, width: screenSize.width, height: bgView.frame.size.height-guigeLabel.frame.maxY-10-height49)
        bgView.addSubview(collectionView)
        bgView.addSubview(footerView)
    }
    
    //获取长度
    func getWidthWithText(text:NSString,height:CGFloat,font:CGFloat) -> CGFloat{
        let size = text.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: font) ], context: nil)
        return size.width
    }
    
    @objc func backBtnAction() {
//        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: { [weak self] () -> Void in
            self?.backgroundColor = UIColor.clear
            self?.bgView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 535*H)
        }) { [weak self] (bool:Bool) in
            self?.removeFromSuperview()
        }
    }
    
    @objc func btnAction(btn:UIButton){
        if btn.tag == 100 {
            
        }
    }
}

extension XBSetAddGoodsShopCartView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //collectionSectionNumber
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //collectionHeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        weak var weakself = self
        if kind == UICollectionElementKindSectionHeader{//header
            
        }else if kind == UICollectionElementKindSectionFooter{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "XBSetAddGoodsCollectionReusableView", for: indexPath) as!XBSetAddGoodsCollectionReusableView
            return footer
        }
        return UICollectionReusableView()
    }
    
    //collectionHeaderSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: 0, height: 0)
    }
    
    //collectionFooterSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: screenSize.width, height: 50)
    }
    
    //collectionItemSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.getWidthWithText(text: self.dataArr[indexPath.row] as NSString, height: 30*W, font: 12*W)+20*W, height: 30*W)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XBSetAddGoodsCollectionViewCell", for: indexPath)as! XBSetAddGoodsCollectionViewCell
        cell.titleLable.frame.size.width = self.getWidthWithText(text: self.dataArr[indexPath.row] as NSString, height: 30*W, font: 12*W)+20*W
        cell.text = self.dataArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as!XBSetAddGoodsCollectionViewCell
        if (self.selectCell != cell) {
            cell.titleLable.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.5921568627, blue: 0.3254901961, alpha: 1)
            cell.titleLable.textColor = UIColor.white
            if self.selectCell != nil {
                selectCell.titleLable.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
                selectCell.titleLable.textColor = LabelColor_51
            }
            selectCell = cell
        }else{
            cell.titleLable.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.5921568627, blue: 0.3254901961, alpha: 1)
            cell.titleLable.textColor = UIColor.white
            selectCell = cell
        }
    }
}
