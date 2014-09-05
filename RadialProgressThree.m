//
//  RadialProgressThree.m
//  RadialProgress
//
//  Created by yuan.yinchun on 5/9/14.
//  Copyright (c) 2014 yyc. All rights reserved.
//

#import "RadialProgressThree.h"
static const int RPInnerPadding=5;

@implementation RadialProgressThree

-(void)initSetup
{
    _backView=[[RadialProgressBackView alloc]init];
    [self addSubview:_backView];
    
    _percentageLabel=[[UILabel alloc]init];
    [self addSubview:_percentageLabel];
    
    _titleLabel=[[UILabel alloc]init];
    [self addSubview:_titleLabel];
    
    _percentageLabel.layer.opacity=0.5;
    _titleLabel.layer.opacity=0.5;
    
}

-(id)init
{
    self=[super init];
    if(self){
        [self initSetup];
    }
    return self;
}


-(void)setPercentage:(NSString *)percentage
{
    _percentage=percentage;
    _percentageLabel.text=percentage;
    NSString *floatStr=[_percentage substringToIndex:[_percentage length]];
    dispatch_async(dispatch_get_main_queue(), ^{
        _backView.circleLayer.strokeEnd=floatStr.floatValue/100;
    });
}

-(void)setTitle:(NSString *)title
{
    _title=title;
    _titleLabel.text=title;
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    _backView.translatesAutoresizingMaskIntoConstraints=NO;
    _percentageLabel.translatesAutoresizingMaskIntoConstraints=NO;
    _titleLabel.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSDictionary *dict=NSDictionaryOfVariableBindings(_backView,_percentageLabel,_titleLabel);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_backView]|" options:0 metrics:0 views:dict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backView]|" options:0 metrics:0 views:dict]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_percentageLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_percentageLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_percentageLabel]-5-[_titleLabel]" options:0 metrics:0 views:dict]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
}


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



-(void)layoutSubviews
{
    [super layoutSubviews];
    static bool flag=YES;
    if(flag){
        [self setBestFontSize];
        flag=NO;
    }
}

+(BOOL)requiresConstraintBasedLayout
{
    return  YES;
}
@end
