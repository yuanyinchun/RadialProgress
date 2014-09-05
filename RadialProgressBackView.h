//
//  RadialProgressBackView.h
//  RadialProgress
//
//  Created by yuan.yinchun on 5/9/14.
//  Copyright (c) 2014 yyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadialProgressBackView : UIView

@property(nonatomic)  CAGradientLayer *gradientLayer;
@property(nonatomic)  CAGradientLayer *topGradientLayer;
@property(nonatomic)  CAGradientLayer *bottomGradientLayer;

@property(nonatomic) CAShapeLayer *circleLayer;

@end
