//
//  RadialProgressTwo.h
//  RadialProgress
//
//  Created by yuan.yinchun on 5/9/14.
//  Copyright (c) 2014 yyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadialProgressLayer.h"

@interface RadialProgressTwo : UIView

@property (nonatomic) NSString *percentage;
@property (nonatomic) NSString *title;

@property(nonatomic)    CAShapeLayer *backCircleLayer;
@property(nonatomic)  RadialProgressLayer *progressLayer;
@property(nonatomic) CAShapeLayer *frontCircleLayer;
@property(nonatomic) CATextLayer *percentageLayer;
@property(nonatomic) CATextLayer *titleLayer;

@end
