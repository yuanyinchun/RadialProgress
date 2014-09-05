//
//  RadialProgressBackView.m
//  RadialProgress
//
//  Created by yuan.yinchun on 5/9/14.
//  Copyright (c) 2014 yyc. All rights reserved.
//

#import "RadialProgressBackView.h"

@implementation RadialProgressBackView

-(id)init
{
    self=[super init];
    if(self){
        [self initSetup];
    }
    return self;
}

-(void)initSetup
{
    _gradientLayer=[CALayer layer];
    [self.layer addSublayer:_gradientLayer];
    
    _bottomGradientLayer=[CAGradientLayer layer];
    [_gradientLayer addSublayer:_bottomGradientLayer];
    
    _topGradientLayer=[CAGradientLayer layer];
    [_gradientLayer addSublayer:_topGradientLayer];
    
    _circleLayer=[CAShapeLayer layer];
    //_gradientLayer.mask=_circleLayer;
    self.layer.mask=_circleLayer;
}

-(void)configLayers
{
    CGFloat min=MIN(self.bounds.size.width, self.bounds.size.height);
    CGFloat radius=min/2;
    CGPoint center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat scale=[[UIScreen mainScreen]scale];
    
    
    //_gradientLayer
    
    _gradientLayer.position=center;
    _gradientLayer.bounds=CGRectMake(0, 0, min, min);
    
    
    //_bottomGradientLayer
    
    _bottomGradientLayer.frame=CGRectMake(0, min/2, min, min/2);
    _bottomGradientLayer.startPoint=CGPointMake(1.0, 0.5);
    _bottomGradientLayer.endPoint=CGPointMake(0.0, 0.5);
    _bottomGradientLayer.colors=@[
                                  (id)[UIColor greenColor].CGColor,
                                  (id)[UIColor orangeColor].CGColor
                                  ];
    _bottomGradientLayer.locations=@[
                                     @0.5,@0.9
                                     ];
    
    
    
    //_topGradientLayer
    
    _topGradientLayer.frame=CGRectMake(0, 0, min, min/2);
    _topGradientLayer.startPoint=CGPointMake(0.0, 0.5);
    _topGradientLayer.endPoint=CGPointMake(1.0, 0.5);
    _topGradientLayer.colors=@[
                               (id)[UIColor orangeColor].CGColor,
                               (id)[UIColor redColor].CGColor
                               ];
    _topGradientLayer.locations=@[
                                  @0.1,@0.5
                                  ];
    
    //_circleLayer
    
    _circleLayer.frame=self.bounds;
    _circleLayer.lineWidth=radius/4;
    
    
    _circleLayer.strokeColor=[UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
    _circleLayer.fillColor=[UIColor colorWithWhite:1.0 alpha:0.0].CGColor;
    
    
    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(center.x-radius*7/8,center.y-radius*7/8, radius*7/4, radius*7/4)];
    
    _circleLayer.path=path.CGPath;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    static bool flag=YES;
    if(flag){
        [self configLayers];
    }
}
@end
