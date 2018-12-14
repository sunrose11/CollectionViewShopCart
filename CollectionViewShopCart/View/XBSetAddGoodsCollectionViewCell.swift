//
//  XBSetAddGoodsCollectionViewCell.swift
//  LiuXinLife
//
//  Created by 信宝网络科技 on 2018/11/29.
//  Copyright © 2018年 信宝网络科技. All rights reserved.
//

import UIKit

class XBSetAddGoodsCollectionViewCell: UICollectionViewCell {
    
    var titleLable : XUILabel!
    //set方法
    var text:String?{
        didSet{
            titleLable.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.contentView.backgroundColor = UIColor.white
        self.setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Cell 初始化失败");
    }
    
    func setView() {
        titleLable = XUILabel.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        titleLable.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        titleLable.font = UIFont.systemFont(ofSize: 12*W)
        titleLable.textAlignment = .center
        titleLable.verticalAlignment = VerticalAlignmentMiddle
        titleLable.textColor = LabelColor_51
        titleLable.layer.cornerRadius = 4
        titleLable.clipsToBounds = true
        addSubview(titleLable)
    }
}
