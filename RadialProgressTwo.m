//
//  RadialProgressTwo.m
//  RadialProgress
//
//  Created by yuan.yinchun on 5/9/14.
//  Copyright (c) 2014 yyc. All rights reserved.
//

#import "RadialProgressTwo.h"

static const int RPInnerPadding=5;

@implementation RadialProgressTwo

-(void)setup
{
    CGFloat min=MIN(self.bounds.size.width, self.bounds.size.height);
    CGFloat radius=min/2;
    CGPoint center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat scale=[[UIScreen mainScreen]scale];
    
    //_backCircleLayer
    _backCircleLayer=[CAShapeLayer layer];
    _backCircleLayer.frame=CGRectMake(center.x-radius, center.y-radius, min, min);
    _backCircleLayer.path=[UIBezierPath bezierPathWithOvalInRect:_backCircleLayer.frame].CGPath;
    _backCircleLayer.fillColor=[UIColor grayColor].CGColor;
    [self.layer addSublayer:_backCircleLayer];
    
    //_progressLayer
    _progressLayer=[[RadialProgressLayer alloc]init];
    _progressLayer.frame=_backCircleLayer.frame;
    _progressLayer.contentsScale=scale;
    [self.layer addSublayer:_progressLayer];
    
    
    
    //_frontCircleLayer
    _frontCircleLayer=[CAShapeLayer layer];
    _frontCircleLayer.position=center;
    _frontCircleLayer.bounds=CGRectMake(0, 0, radius*3/2, radius*3/2);
    _frontCircleLayer.path=[UIBezierPath bezierPathWithOvalInRect:_frontCircleLayer.bounds].CGPath;
    _frontCircleLayer.fillColor=[UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:_frontCircleLayer];
    
    //_percentageLayer
    _percentageLayer=[CATextLayer layer];
    _percentageLayer.position=center;
    _percentageLayer.fontSize=8;
    _percentageLayer.bounds=CGRectMake(0, 0, _frontCircleLayer.bounds.size.width/2, _percentageLayer.fontSize);
    _percentageLayer.contentsScale=scale;
    [self.layer addSublayer:_percentageLayer];
    
    
    
    //_titleLayer
    _titleLayer=[CATextLayer layer];
    _titleLayer.position=CGPointMake(center.x, center.y+_percentageLayer.fontSize);
    _titleLayer.fontSize=6;
    _titleLayer.bounds=CGRectMake(0, 0, _frontCircleLayer.bounds.size.width/2, _titleLayer.fontSize+2);
    _titleLayer.contentsScale=scale;
    [self.layer addSublayer:_titleLayer];
    
    _percentageLayer.alignmentMode=kCAAlignmentCenter;
    _titleLayer.alignmentMode=kCAAlignmentCenter;
    
    
    
}

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}

/*
 -(id)initWithTitle:(NSString *)title
 percentage:(NSString *)percentage
 {
 self=[super init];
 if(self){
 _percentage=percentage;
 _title=title;
 self.backgroundColor=[UIColor whiteColor];
 
 _percentageLabel=[[UILabel alloc]init];
 _percentageLabel.text=_percentage;
 [self addSubview:_percentageLabel];
 
 _titleLabel=[[UILabel alloc]init];
 _titleLabel.text=_title;
 [self addSubview:_titleLabel];
 
 self.clipsToBounds=YES;
 }
 return self;
 }
 */

-(void)setPercentage:(NSString *)percentage
{
    _percentage=percentage;
    NSString *floatStr=[_percentage substringToIndex:[_percentage length]];
    _progressLayer.endAngle=2*M_PI*floatStr.floatValue/100.0;
    if (_progressLayer.endAngle > M_PI) {
        _progressLayer.fillColor=[UIColor redColor];
    }else{
        _progressLayer.fillColor=[UIColor greenColor];
    }
    _percentageLayer.string=percentage;
    /*
     dispatch_async(dispatch_get_main_queue(), ^{
     [self setNeedsDisplay];
     });
     */
}

-(void)setTitle:(NSString *)title
{
    _title=title;
    _titleLayer.string=title;
}
/*
 -(void)updateConstraints
 {
 [super updateConstraints];
 
 _percentageLabel.translatesAutoresizingMaskIntoConstraints=NO;
 _titleLabel.translatesAutoresizingMaskIntoConstraints=NO;
 
 NSDictionary *dict=NSDictionaryOfVariableBindings(_percentageLabel,_titleLabel);
 
 [self addConstraint:[NSLayoutConstraint constraintWithItem:_percentageLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
 [self addConstraint:[NSLayoutConstraint constraintWithItem:_percentageLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
 
 
 [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_percentageLabel]-5-[_titleLabel]" options:0 metrics:0 views:dict]];
 [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
 }
 */
/*
 -(void)setBestFontSize
 {
 CGSize size=self.bounds.size;
 double radius=MIN(size.width, size.height)/2-RPInnerPadding;
 
 int minFontSize=5;
 int fontSize=minFontSize;
 CGRect percentageLabelRect;
 do{
 _percentageLabel.font=[UIFont systemFontOfSize:fontSize];
 fontSize=fontSize+5;
 percentageLabelRect=[_percentageLabel.text boundingRectWithSize:self.bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_percentageLabel.font} context:nil];
 }while (percentageLabelRect.size.width<radius);
 
 _titleLabel.font=[UIFont systemFontOfSize:fontSize/3];
 }
 
 */

/*
 -(void)layoutSubviews
 {
 [super layoutSubviews];
 static bool flag=YES;
 if(flag){
 [self setBestFontSize];
 flag=NO;
 }
 }
 */

/*
 - (void)drawRect:(CGRect)rect
 {
 CGSize size=self.bounds.size;
 CGPoint center=CGPointMake(size.width/2.0, size.height/2.0);
 double radius=MIN(size.width, size.height)/2-RPInnerPadding;
 
 CGContextRef context=UIGraphicsGetCurrentContext();
 
 //draw complete circle
 CGContextSaveGState(context);
 CGContextAddArc(context, center.x, center.y, radius, 0, 2*M_PI, 0);
 [[UIColor grayColor] setStroke];
 CGContextStrokePath(context);
 CGContextRestoreGState(context);
 
 //draw arc to repensent percentage
 CGContextSaveGState(context);
 NSString *subStr=[_percentage substringToIndex:[_percentage length]-1];
 float tmp=[subStr floatValue];
 CGContextAddArc(context, center.x, center.y, radius, 0, 2*M_PI*tmp/100, 0);
 if (tmp>50.0) {
 [[UIColor redColor] setStroke];
 }else
 [[UIColor greenColor] setStroke];
 CGContextSetLineWidth(context, 5);
 CGContextStrokePath(context);
 CGContextRestoreGState(context);
 
 //draw percentage text and title text
 UIFont *font=[UIFont systemFontOfSize:1.0];
 while (font.pointSize*6<size.width/2) {
 font=[UIFont systemFontOfSize:font.pointSize+1];
 }
 font=[UIFont systemFontOfSize:font.pointSize-1];
 NSLog(@"%f  %f",font.pointSize,size.width);
 
 [_percentage drawAtPoint:CGPointMake(center.x-font.pointSize*[_percentage length]/2, center.y-font.pointSize/2) withFont:font];
 
 //draw title text
 [_title drawAtPoint:CGPointMake(center.x-font.pointSize*[_title length]/2, center.y+font.pointSize/2) withFont:font];
 
 }*/

@end
