//
//  XUILabel.h
//  KYDuoBao
//
//  Created by 海鑫 on 16/8/9.
//  Copyright © 2016年 HXKJ-SU. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;
@interface XUILabel : UILabel{
@private
    VerticalAlignment verticalAlignment_;
}
@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end
