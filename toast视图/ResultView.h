//
//  ResultView.h
//  CJPubllicLessons
//
//  Created by cjatech-简豪 on 15/12/17.
//  Copyright © 2015年 cjatech-简豪. All rights reserved.
//
/*******************************************
 *
 *
 *
 *自定义提示框  （底部小黑框）
 *
 *
 *
 ********************************************/




#import <UIKit/UIKit.h>

@interface ResultView : UIView

@property (copy, nonatomic) NSString * inforTitle;

//类方法 直接使用即能添加到视图 并且自动隐藏 不需其他步骤
+ (void)viewWithTitle:(NSString *)title andSuperView:(UIView *)superView;

//对象方法 直接使用即能添加到视图 并且自动隐藏 不需其他步骤
-(instancetype)initWithTitle:(NSString *)title andSuperView:(UIView *)superView;


//展示和隐藏接口
-(void)show;
-(void)hide;
@end
