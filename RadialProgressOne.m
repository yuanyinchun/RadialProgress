//
//  RadialProgressOne.m
//  RadialProgress
//
//  Created by yuan.yinchun on 5/9/14.
//  Copyright (c) 2014 yyc. All rights reserved.
//

#import "RadialProgressOne.h"

static const int RPInnerPadding=5;
@interface RadialProgressOne()

@property(nonatomic,strong) UILabel *percentageLabel;
@property(nonatomic,strong) UILabel *titleLabel;

@end


@implementation RadialProgressOne

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init
{
    return [self initWithTitle:@"内存" percentage:@"0%"];
}


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

-(void)setPercentage:(NSString *)percentage
{
    _percentageLabel.text=percentage;
    _percentage=percentage;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

-(void)setTitle:(NSString *)title
{
    _titleLabel.text=title;
    _title=title;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

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
    
}

+(BOOL)requiresConstraintBasedLayout
{
    return YES;
}

@end
