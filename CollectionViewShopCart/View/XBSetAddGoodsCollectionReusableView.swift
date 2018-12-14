//
//  XBSetAddGoodsCollectionReusableView.swift
//  LiuXinLife
//
//  Created by 信宝网络科技 on 2018/11/29.
//  Copyright © 2018年 信宝网络科技. All rights reserved.
//

import UIKit

class XBSetAddGoodsCollectionReusableView: UICollectionReusableView {
    
    var numberButton : PPNumberButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        
        let line = UIView.init(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 0.5))
        line.backgroundColor = LineColor
        addSubview(line)
        
        let titlelLabel = XUILabel.init(frame: CGRect(x: 10*W, y: 0, width: 80, height: 50))
        titlelLabel.verticalAlignment = VerticalAlignmentMiddle
        titlelLabel.text = "数量"
        titlelLabel.textColor = LabelColor_153
        titlelLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(titlelLabel)
        
        numberButton = PPNumberButton.init(frame: CGRect(x: screenSize.width-120, y: 10*W, width: 110, height: 30))
        //开启抖动动画
        numberButton.shakeAnimation = true
        numberButton.maxValue = 10
        numberButton.minValue = 1
        //设置边框颜色
        numberButton.borderColor(UIColor.gray)
        //加减按钮的闭包回调
        numberButton.numberResult { (number) in
            print(number)
        }
        addSubview(numberButton)
        
    }
    
    
}
