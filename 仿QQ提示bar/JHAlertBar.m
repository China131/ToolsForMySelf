//
//  JHAlertBar.m
//  imKShow
//
//  Created by 简豪 on 2017/1/12.
//  Copyright © 2017年 C.J. All rights reserved.
//

#import "JHAlertBar.h"

@implementation JHAlertBar


-(instancetype)initWithIconName:(NSString *)iconName noticeWord:(NSString *)noticeWord{
    if (self = [super initWithFrame:CGRectMake(0, -74, IOS_Width, 74)]) {
        self.backgroundColor = [UIColor redColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 32, 20, 20)];
        if (iconName.length == 0) {
            iconName = @"jingao";
        }
        imageView.center = CGPointMake(25, 52);
        imageView.image = [UIImage imageNamed:iconName];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, 27, IOS_Width - CGRectGetMaxX(imageView.frame) - 5, 50)];
        label.text = noticeWord;
        label.font = [UIFont systemFontOfSize:16 weight:4];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        
    }
    [self show];
    return self;
}

+(instancetype)barWithIconName:(NSString *)iconName noticeWord:(NSString *)noticeWord{
    return [[[self class] alloc] initWithIconName:iconName noticeWord:noticeWord];
}

-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    weakSelf(weakSelf)
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionTransitionNone animations:^{
        weakSelf.frame = CGRectMake(0, -10, IOS_Width, 74);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [strongSelf removeFromSuperview];
            });
        }
    }];
    
}


+ (instancetype)barWithIconName:(NSString *)iconName noticeWord:(NSString *)noticeWord backgroundColor:(UIColor *)color{
    JHAlertBar *bar = [[[self class] alloc] initWithIconName:iconName noticeWord:noticeWord];
    bar.backgroundColor = color;
    return bar;
}
@end
