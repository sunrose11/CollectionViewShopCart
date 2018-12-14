//
//  ViewController.swift
//  CollectionViewShopCart
//
//  Created by 信宝网络科技 on 2018/12/14.
//  Copyright © 2018 叶熙文. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.setTitle("添加", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    @objc func buttonAction(){
        let cartView = XBSetAddGoodsShopCartView.init(frame:self.view.frame)
        view.addSubview(cartView)
        UIView.animate(withDuration: 0.3) {[weak view] () -> Void in
            cartView.bgView.frame = CGRect(x: 0, y: screenSize.height - 525*H, width: screenSize.width, height: 535*H)
        }
    }
}

