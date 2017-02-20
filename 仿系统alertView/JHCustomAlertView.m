//
//  JHCustomAlertView.m
//  CJPublicLesson
//
//  Created by cjatech-简豪 on 15/12/1.
//  Copyright © 2015年 cjatech-简豪. All rights reserved.
//

#import "JHCustomAlertView.h"
#define SELF_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SELF_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kScale SELF_WIDTH/320.0
@interface JHCustomAlertView ()
{
    UILabel     *_titleLabel;   //提示框头标签
    UILabel     *_bodyLabel;    //展示信息的标签
    NSString    *_titleText;    //提示框头内容
    NSString    *_bodyText;     //提示信息内容
    NSArray     *_itemArr;      //按钮数组
    UIView      *_contentView;  //提示框
    CGFloat     _width;         //提示框宽度
    CGFloat     _height;        //提示框高度
}

@property (copy, nonatomic)     indexBlock  clickBlock;     //按钮点击回调block
@property (nonatomic,strong)NSMutableArray * buttonArray;
@end

@implementation JHCustomAlertView

- (NSMutableArray *)buttonArray{
    
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
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
-(instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)msg andItemsArr:(NSArray *)arr andClickIndexBlock:(indexBlock)clickBlock{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _clickBlock          = clickBlock;
        _titleText           = title;
        _bodyText            = msg;
        _itemArr             = arr;
        _width               = SELF_WIDTH-30*kScale;
        _width               = SELF_WIDTH / 3.0 *2+10;
        _height              = _width/4.0*2;
        _height              = 120 * kScale;
        _neverAutoHidden = NO;
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
       [self configBaseView];
    }
    return self;
}


/**
 *  搭建基本界面
 */
- (void)configBaseView{
    
    
    /* 创建提示框 */
    _contentView                     = [[UIView alloc] initWithFrame:CGRectMake((SELF_WIDTH-_width)/2, (SELF_HEIGHT - _height)/2, 0, 0)];
    _contentView.backgroundColor     = [UIColor whiteColor];
    _contentView.layer.cornerRadius  = 10;
    _contentView.layer.masksToBounds = YES;
    _contentView.center              = CGPointMake(SELF_WIDTH/2, SELF_HEIGHT/2);
    
    
    /* 创建titleLabel */
    _titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,0, 0)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font          = [UIFont systemFontOfSize:16];
    _titleLabel.text          = _titleText;
    _titleLabel.center        = CGPointMake(_width/2, 15);
    [_contentView addSubview:_titleLabel];
    
    
    /* 创建BodyLabel */
    _bodyLabel                           = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 0, 0)];
    _bodyLabel.text                      = _bodyText;
    _bodyLabel.textAlignment             = NSTextAlignmentCenter;
    _bodyLabel.numberOfLines             = 0;
    _bodyLabel.font                      = [UIFont systemFontOfSize:14];
    _bodyLabel.minimumScaleFactor        = 0.5;
    _bodyLabel.adjustsFontSizeToFitWidth = YES;
    _bodyLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    _bodyLabel.center                    = CGPointMake(_width/2, (_height - 70*kScale)/2 + 30);
    [_contentView addSubview:_bodyLabel];
    
    
   
    
    /* 创建按钮组 */
    CGFloat width = _width/_itemArr.count;
    for (int i = 0; i < _itemArr.count; i++) {
        UIButton *btn         = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame             = CGRectMake((width+0.5) * i-0.5, _height-35*kScale, width+1, 35*kScale);
        btn.tag               = i;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.4].CGColor;
        btn.titleLabel.font   = [UIFont systemFontOfSize:15];
        [btn setTitle:_itemArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn];
        
        [self.buttonArray addObject:btn];
        
    }
    [self addSubview:_contentView];
    
}


/**
 *  展示自定义alert
 */
-(void)show{
    self.hidden        = NO;
    self.alpha         = 0;
    _contentView.alpha = 0;
    _contentView.frame = CGRectMake((SELF_WIDTH-_width)/2, (SELF_HEIGHT - _height)/2, _width, _height);
    _titleLabel.frame  = CGRectMake(0, 0, _width, 30*kScale);
    _bodyLabel.frame   = CGRectMake(25, CGRectGetMaxY(_titleLabel.frame)+5*kScale, _width-50, _height - 80*kScale);
    if (_titleLabel.text.length == 0) {
       
        _titleLabel.frame = CGRectZero;
        _contentView.frame = CGRectMake((SELF_WIDTH-_width)/2, (SELF_HEIGHT - _height)/2, _width, _height - 30 *kScale);
         CGFloat width = _width/_itemArr.count;
        for (NSInteger i = 0; i<self.buttonArray.count; i++) {
            UIButton *btn = [self.buttonArray objectAtIndex:i];
            
            btn.frame             = CGRectMake((width+0.5) * i-0.5, _height-35*kScale - 30 *kScale, width+1, 35*kScale);
            
        }
         _bodyLabel.frame   = CGRectMake(25, CGRectGetMaxY(_titleLabel.frame)+5*kScale, _width-50, _height - 80*kScale);
         _bodyLabel.frame = CGRectMake(25, 5*kScale, _width - 50, _height - 65*kScale - 10*kScale);
    }
    

    
    _titleLabel.font   = [UIFont systemFontOfSize:14*kScale];
    _bodyLabel.font    = [UIFont systemFontOfSize:13*kScale];
//    if (_titleText==nil) {
//        _bodyLabel.frame = CGRectMake(25, 5, _width-50, _height-42*kScale);
//        _bodyLabel.font    = [UIFont systemFontOfSize:15*kScale];
//    }
    
    _contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    
    /* 展示动画  渐隐效果 */
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha         = 1;
        _contentView.alpha = 1;
        _contentView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

/**
 *  按钮点击事件 通过回调block传递index索引 响应不同事件
 *
 *  @param sender 点击的按钮
 */
- (void)btnClick:(UIButton *)sender{
    
    _clickBlock(sender.tag);
    
    if (_neverAutoHidden) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha         = 0;
        _contentView.alpha = 1;
        _contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }completion:^(BOOL finished) {
        if (finished) {
            
             [self removeFromSuperview];
            
        }
    }];
   
}

@end
