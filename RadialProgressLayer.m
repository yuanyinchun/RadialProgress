//
//  RadialProgressLayer.m
//  RadialProgress
//
//  Created by yuan.yinchun on 5/9/14.
//  Copyright (c) 2014 yyc. All rights reserved.
//

#import "RadialProgressLayer.h"

@implementation RadialProgressLayer

@dynamic endAngle;

+(BOOL)needsDisplayForKey:(NSString *)key
{
    if([key isEqualToString:@"endAngle"]){
        return YES;
    }
    return [super needsDisplayForKey:key];
}

-(id<CAAction>)actionForKey:(NSString *)event
{
    if ([event isEqualToString:@"endAngle"]) {
        
        CABasicAnimation *anim=[CABasicAnimation animationWithKeyPath:event];
        anim.fromValue=[[self presentationLayer] valueForKey:@"endAngle"];
        anim.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anim.duration=2;
        
        return anim;
    }
    
    return [super actionForKey:event];
}

-(void)drawInContext:(CGContextRef)ctx
{
    CGPoint center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius=MIN(center.x, center.y);
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, center.x, center.y);
    CGContextAddLineToPoint(ctx, center.x*2, center.y );
    CGContextAddArc(ctx, center.x, center.y, radius, 0, self.endAngle, NO);
    CGContextClosePath(ctx);
    
    CGContextSetFillColorWithColor(ctx, self.fillColor.CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    
}

-(id)init
{
    self=[super init];
    if(self){
        self.fillColor=[UIColor greenColor];
    }
    return self;
}

-(id)initWithLayer:(id)layer
{
    self=[super initWithLayer:layer];
    if(self){
        RadialProgressLayer *other=(RadialProgressLayer *)layer;
        self.fillColor=other.fillColor;
        self.endAngle=other.endAngle;
    }
    
    return self;
}


@end
