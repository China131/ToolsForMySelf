//
//  JHPageView.m
//  JHPageViewDemo
//
//  Created by 简豪 on 2017/5/22.
//  Copyright © 2017年 Facebank. All rights reserved.
//

#import "JHPageView.h"

@interface JHPageView()<UIScrollViewDelegate>
{
    UIButton * _selectedButton;
    UIView * _lineView;
    CGFloat _buttonWidth;
    UIScrollView *_bgScrollView;
    NSMutableArray *_buttonCacheArray;
}
@end
@implementation JHPageView

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
              horizonPadding:(CGFloat)horizonPadding{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = array;
        self.titleAndHorizonLineNormalColor = normalColor;
        self.titleAndHorizonLineSelectedColor = selectedColor;
        self.titleNormalFont = normalFont;
        self.titleSelectedFont = selectedFont;
        self.barHeight = barHeight;
        self.defaultSelectIndex = index;
        self.showVerticalLinesEnable = showVertical;
        self.verticalLinesSize = verticalLinesSize;
        self.showHorizonLinesEnable = showHorizon;
        self.horizonLinesHeight = showHorizon;
        self.horizonPadding = horizonPadding;
        self.verticalLinesColor = verticalLinesColor;
        [self configBaseView];
    }
    
    return self;
}

#pragma mark 初始化视图
- (void)configBaseView{
    CGFloat buttonWid = 0;
    if (self.titleArray.count > 0) {
        buttonWid = self.frame.size.width / self.titleArray.count;
        _buttonWidth = buttonWid;
    }else{
        return;
    }
    
    _buttonCacheArray = [NSMutableArray array];
    //创建titleButton
    for (int8_t i = 0; i<self.titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:self.titleAndHorizonLineNormalColor forState:UIControlStateNormal];
        button.frame = CGRectMake(i * buttonWid, 0, buttonWid-self.verticalLinesSize.width, self.barHeight - 1);
        [button setTitleColor:self.titleAndHorizonLineSelectedColor forState:UIControlStateSelected];
        [_buttonCacheArray addObject:button];
        if (i == self.defaultSelectIndex) {
            button.titleLabel.font = self.titleSelectedFont;
            _selectedButton = button;
            button.selected = YES;
            if (self.showHorizonLinesEnable) {
                UIView *layer = [UIView new];
                layer.frame = CGRectMake(i * buttonWid + self.horizonPadding / 2.0, CGRectGetMaxY(button.frame), buttonWid - self.horizonPadding, self.horizonLinesHeight);
                layer.backgroundColor = self.titleAndHorizonLineSelectedColor;
                [self addSubview:layer];
                
                _lineView = layer;
            }
        }else{
            button.titleLabel.font = self.titleNormalFont;
        }
        if (self.showVerticalLinesEnable) {
            CALayer *layer = [CALayer layer];
            layer.backgroundColor = self.verticalLinesColor.CGColor;
            layer.frame = CGRectMake(CGRectGetMaxX(button.frame),self.barHeight / 2 - self.verticalLinesSize.height / 2, self.verticalLinesSize.width, self.verticalLinesSize.height);
            [self.layer addSublayer:layer];
        }
        
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    [self configScrollView];
    
}

#pragma mark 构建UISCrollView对象
- (void)configScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_lineView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(_lineView.frame))];
    scrollView.contentSize = CGSizeMake(self.titleArray.count * CGRectGetWidth(self.frame), 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    _bgScrollView = scrollView;
    [self addSubview:_bgScrollView];
    for (int8_t i = 0; i<self.titleArray.count; i++) {
        if (_delegate) {
            UIView *contentView = nil;
            if ([_delegate respondsToSelector:@selector(pageViewForScrollViewContentAtSection:scrollView:)]) {
                contentView = [_delegate pageViewForScrollViewContentAtSection:i scrollView:_bgScrollView];
                if (contentView) {
                    [scrollView addSubview:contentView];
                }else{
                    NSLog(@"Worning:you delegate %@ has return nil for scrollView when call pageViewForScrollViewContentAtSection:scrollView:",_delegate);
                }
            }else{
                NSLog(@"Error:your delegate%@ has not implemete pageViewForScrollViewContentAtSection:scrollView:",_delegate);
            }
            
        }

    }
    
}


#pragma mark button点击事件
- (void)buttonClick:(UIButton *)sender{
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(pageViewDidClickButton:)]) {
            [_delegate pageViewDidClickButton:sender];
        }
    }
    if (sender == _selectedButton) {
        return;
    }
    _selectedButton.selected = NO;
    _selectedButton.titleLabel.font = self.titleNormalFont;
    _selectedButton = sender;
    _selectedButton.selected = YES;
    _selectedButton.titleLabel.font = self.titleSelectedFont;
    
    [_bgScrollView setContentOffset:CGPointMake(sender.tag * CGRectGetWidth(self.frame), 0) animated:YES];
    
}

#pragma mark UIScrollView Delegate Mehtod
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect rect = _lineView.frame;
    rect.origin.x = scrollView.contentOffset.x / scrollView.contentSize.width * CGRectGetWidth(self.frame) + self.horizonPadding / 2;
    _lineView.frame = rect;
}


#pragma mark 结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self adjustSelectedButtonWithScrollView:scrollView];
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(pageViewDidChangeSelectedIndex:)]) {
            [_delegate pageViewDidChangeSelectedIndex:self];
        }
    }
}

#pragma mark 结束拖拽
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

#pragma mark 结束动画
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
  
}

- (void)adjustSelectedButtonWithScrollView:(UIScrollView *)scrollView{
    int8_t index = scrollView.contentOffset.x / CGRectGetWidth(self.frame);
    _selectedButton.selected = NO;
    _selectedButton.titleLabel.font = self.titleNormalFont;
    _selectedButton = _buttonCacheArray[index];
    _selectedButton.selected = YES;
    _selectedButton.titleLabel.font = self.titleSelectedFont;
}






























@end
