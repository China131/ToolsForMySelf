//
//  CJDisplaylinkShowLabel.m
//  CRMCJ
//
//  Created by 简豪 on 2016/11/2.
//  Copyright © 2016年 JZZ. All rights reserved.
//

#import "CJDisplaylinkShowLabel.h"

@implementation CJDisplaylinkShowLabel



-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, 100, 30);
//        self.backgroundColor = [UIColor whiteColor];
        self.textColor = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:15];
        self.textAlignment = NSTextAlignmentCenter;
        _lastTime = 0;
        _count = 0;
        self.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 70, 25);
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayRefresh)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        
    }
    
    return self;
}


- (void)displayRefresh{
    if (_lastTime == 0) {
        _lastTime = _displayLink.timestamp;
        
        return;
    }
    
//    NSLog(@"%f",_displayLink.duration);
    _count += 1;
    CFTimeInterval delta = _displayLink.timestamp - _lastTime;
    
    if (delta<1) {
        return;
    }
    
    _lastTime = _displayLink.timestamp;
    
    NSInteger fps = (double)_count / delta;
    _count = 0;
    self.text = [NSString stringWithFormat:@"%ld fps",fps];

}

@end
