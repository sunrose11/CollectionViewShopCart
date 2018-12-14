//
//  XBDefaultConfig.swift
//  LiuXinLife
//
//  Created by 信宝网络科技 on 2017/12/5.
//  Copyright © 2017年 信宝网络科技. All rights reserved.
//

import UIKit

let LabelColor_16 = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
let LabelColor_51 = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
let LabelColor_153 = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
let LineColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)

extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }
}
func noNullString(str:String?)->String{
    return str == nil ? "" : str! as String
}

var W : CGFloat {
    
    return  UIScreen.main.bounds.width / 375
}

var H : CGFloat {
    
    return  UIScreen.main.bounds.height / 667
}

var screenSize : CGSize {
    get {
        return UIScreen.main.bounds.size
    }
}

var homeHeaderHeight : CGFloat{
    get{
        return screenSize.width/3 + homeHeaderCollectionBackViewHeight
    }
}
var homeHeaderCollectionBackViewHeight : CGFloat{
    get {
        return screenSize.width/7*3
    }
}

var homeDiscountCollectionCellHeight :CGFloat{
    get {
        return screenSize.width/8*3
    }
}



//MARK: - 判断X系列的安全区 判断是否是X系列
var isIPhoneXSeries:Bool{
    var iPhoneXSeries:Bool = false
    if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone{
        return iPhoneXSeries
    }
    if #available(iOS 11.0, *) {
        if Double((UIApplication.shared.delegate?.window??.safeAreaInsets.bottom)!) > 0.0 {
            iPhoneXSeries = true
        }
    }
    return iPhoneXSeries
}

var height64 : CGFloat {
    if isIPhoneXSeries {
        return CGFloat(88)
    }else{
        return CGFloat(64)
    }
    
}

var height20 : CGFloat {
    if isIPhoneXSeries {
        return CGFloat(44)
    }else{
        return CGFloat(20)
    }
}

var height49 : CGFloat {
    if isIPhoneXSeries {
        return CGFloat(83)
    }else{
        return CGFloat(49)
    }
}
