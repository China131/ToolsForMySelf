//
//  JHPageView.h
//  JHPageViewDemo
//
//  Created by 简豪 on 2017/5/22.
//  Copyright © 2017年 Facebank. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHPageView;
/*!
 @protocol JHPageViewDelegate
 @abstract JHPageViewProtocal 方法
 */
@protocol JHPageViewDelegate <NSObject>

@optional
- (void)pageViewDidClickButton:(UIButton *)button;

- (void)pageViewDidChangeSelectedIndex:(JHPageView *)pageView;

@required

- (UIView *)pageViewForScrollViewContentAtSection:(NSInteger)section scrollView:(UIScrollView *)scrollView;

@end

/*!
 @class JHPageView 
 @abstract 用于快速搭建pageView样式的视图
 */
@interface JHPageView : UIView


///是否展示竖线 默认不显示
@property (nonatomic , assign)BOOL showVerticalLinesEnable;

///是否展示底部横线 默认显示
@property (nonatomic , assign)BOOL showHorizonLinesEnable;

///竖线颜色 默认灰色
@property (nonatomic , strong)UIColor * verticalLinesColor;

///竖线尺寸 默认{1，30}
@property (nonatomic , assign)CGSize verticalLinesSize;

///横线高度 默认1
@property (nonatomic , assign)CGFloat horizonLinesHeight;

///横线间距 默认0
@property (nonatomic , assign)CGFloat horizonPadding;

///横线及文字正常时颜色 默认灰色
@property (nonatomic , strong)UIColor * titleAndHorizonLineNormalColor;

///横线及文字选中状态颜色 默认蓝色
@property (nonatomic , strong)UIColor * titleAndHorizonLineSelectedColor;

///bar的高度 默认40
@property (nonatomic , assign)CGFloat barHeight;

///bar的数据源数组
@property (nonatomic , strong)NSArray<NSString *> * titleArray;

///bar的title文本正常状态字体
@property (nonatomic , strong)UIFont * titleNormalFont;

///bar的title文本选中状态字体
@property (nonatomic , strong)UIFont * titleSelectedFont;

///默认选中的索引值
@property (nonatomic , assign)int8_t defaultSelectIndex;

///代理对象
@property (nonatomic , assign)id<JHPageViewDelegate> delegate;

/*!
 @discussion init 方法
 @param frame 控件大小
 @param array bar的内容数组 仅限字符串数组
 @param normalColor bar的内容及底部横线正常状态颜色
 @param selectedColor bar的内容及底部横线选中状态颜色
 @param barHeight bar的高度
 @param index 默认选中按钮的索引值
 @param showVertical 是否显示分割竖线
 @param verticalLinesSize 分割线size
 @param showHorizon 是否显示水平滑块
 @param horizonLineHeight 水平滑块高度
 @param horizonPadding 水平滑块间距 —————— | —————— | ——————— |
 */
-(instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray<NSString *> *)array
       barContentNormalColor:(UIColor *)normalColor
       barContentSelectColor:(UIColor *)selectedColor
             titleNormalFont:(UIFont *)normalFont
           titleSelectedFont:(UIFont *)selectedFont
                   barHeight:(CGFloat)barHeight
        defaultSelectedIndex:(int8_t)index
     showVerticalLinesEnable:(BOOL)showVertical
           verticalLinesSize:(CGSize)verticalLinesSize
          verticalLinesColor:(UIColor *)verticalLinesColor
      showHorizonLinesEnable:(BOOL)showHorizon
           horizonLineHeight:(CGFloat)horizonLineHeight
              horizonPadding:(CGFloat)horizonPadding;




























@end
