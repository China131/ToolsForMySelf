//
//  CJDisplaylinkShowLabel.h
//  CRMCJ
//
//  Created by 简豪 on 2016/11/2.
//  Copyright © 2016年 JZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJDisplaylinkShowLabel : UILabel
@property (nonatomic,strong)CADisplayLink * displayLink;
@property (nonatomic,assign) double lastTime;
@property (nonatomic,assign) long long count;
@end
