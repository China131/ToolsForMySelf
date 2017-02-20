//
//  ResultView.m
//  CJPubllicLessons
//
//  Created by cjatech-简豪 on 15/12/17.
//  Copyright © 2015年 cjatech-简豪. All rights reserved.
//

#import "ResultView.h"
#define IOS_Width [UIScreen mainScreen].bounds.size.width
@implementation ResultView


/**
 *  自定义初始化类方法
 *
 *  @param title     显示的信息字符串
 *  @param superView 添加到的视图
 */
+(void)viewWithTitle:(NSString *)title andSuperView:(UIView *)superView{
    
    ResultView *view = [[ResultView alloc] initWithTitle:title andSuperView:superView];
}


/**
 *  自定义初始化对象方法
 *
 *  @param title     显示的信息字符串
 *  @param superView 添加到的视图
 */
-(instancetype)initWithTitle:(NSString *)title andSuperView:(UIView *)superView{
    
    CGSize size = [title boundingRectWithSize:CGSizeMake(IOS_Width, 20) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesDeviceMetrics|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    if (self =[super initWithFrame:CGRectMake(100, 100, size.width+23, 30)]) {
        _inforTitle = title;
        self.center = CGPointMake(superView.frame.size.width/2, superView.frame.size.height-90);
        [self configTitle];
        [superView addSubview:self];
        [self show];
        [self hide];
    }
    return self;
}


/**
 *  基本视图构建
 */
- (void)configTitle{
    self.layer.cornerRadius = 5;
    UILabel *label          = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20)];
    label.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    label.text              = _inforTitle;
    label.textColor         = [UIColor whiteColor];
    label.textAlignment     = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];

    [self addSubview:label];
    self.backgroundColor    = CJBaseColor;
    self.hidden             = YES;
}


/**
 *  提示框显示
 */
-(void)show{
    self.hidden = NO;
}


/**
 *  提示框隐藏
 */
-(void)hide{
    [UIView animateWithDuration:4 animations:^{
        /* 隐藏动画 动画结束后从父视图上移除 */
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
