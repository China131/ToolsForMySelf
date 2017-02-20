//
//  JHAlertBar.h
//  imKShow
//
//  Created by 简豪 on 2017/1/12.
//  Copyright © 2017年 C.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHAlertBar : UIView


+ (instancetype)barWithIconName:(NSString *)iconName
           noticeWord:(NSString *)noticeWord;
+ (instancetype)barWithIconName:(NSString *)iconName
                     noticeWord:(NSString *)noticeWord
                backgroundColor:(UIColor *)color;

@end
