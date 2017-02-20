//
//  JHCustomAlertView.h
//  CJPublicLesson
//
//  Created by cjatech-简豪 on 15/12/1.
//  Copyright © 2015年 cjatech-简豪. All rights reserved.
//
/*******************************************
 *
 *
 *
 *自定义alertView
 *
 *
 *
 ********************************************/

#import <UIKit/UIKit.h>

//alert按钮点击回调block index是点击的按钮索引
typedef void (^indexBlock)(NSInteger index);


@interface JHCustomAlertView : UIView
@property (assign , nonatomic) BOOL  neverAutoHidden ;


/**
 *  初始化alertView
 *
 *  @param frame      废弃参数
 *  @param title      提示框头
 *  @param msg        提示信息
 *  @param arr        按钮的数据数组
 *  @param clickBlock 按钮点击回调block
 *
 *  @return 自定义alert对象
 */
- (instancetype)initWithTitle:(NSString *)title
                   andMessage:(NSString *)msg
                  andItemsArr:(NSArray *)arr
           andClickIndexBlock:(indexBlock)clickBlock;
/**
 *  展示自定义alert
 */
- (void)show;
@end
