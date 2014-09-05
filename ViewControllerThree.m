//
//  ViewControllerThree.m
//  RadialProgress
//
//  Created by yuan.yinchun on 5/9/14.
//  Copyright (c) 2014 yyc. All rights reserved.
//

#import "ViewControllerThree.h"

@interface ViewControllerThree ()

@end

@implementation ViewControllerThree

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init
{
    self=[super init];
    if(self){
        self.title=@"动画效果2";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _radialProgress=[[RadialProgressThree alloc]init];
    _radialProgress.percentage=@"90.5%";
    _radialProgress.title=@"CPU";
    _radialProgress.frame=CGRectMake(0,50,100, 100);
    [self.view addSubview:_radialProgress];
    
    
    _btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn.frame=CGRectMake(0, 180, 100, 30);
    [_btn setTitle:@"变更百分比" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_btn];
}

-(void)change
{
   int rand= arc4random()%10000;
    NSString *newPercentage=[NSString stringWithFormat:@"%.2f%%",rand/100.0];
    _radialProgress.percentage=newPercentage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
