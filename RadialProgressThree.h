//
//  RadialProgressThree.h
//  RadialProgress
//
//  Created by yuan.yinchun on 5/9/14.
//  Copyright (c) 2014 yyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadialProgressBackView.h"

@interface RadialProgressThree : UIView

@property (nonatomic) NSString *percentage;
@property (nonatomic) NSString *title;

@property (nonatomic,strong) UILabel *percentageLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) RadialProgressBackView *backView;

@end
