//
//  JRViewController.m
//  JRSegmentedControl
//
//  Created by luqyluqe on 04/14/2016.
//  Copyright (c) 2016 luqyluqe. All rights reserved.
//

#import "JRViewController.h"
#import "JRSegmentedControl.h"

@interface JRViewController ()<JRSegmentedControlDelegate>

@end

@implementation JRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect bounds=self.view.bounds;
    NSMutableArray<JRSegment*>* segments=[NSMutableArray new];
    for (int i=0; i<4; i++) {
        JRSegment* segment=[JRSegment segmentWithTitle:@"JR" action:^(JRSegmentedControl *segmentedControl, JRSegment *segment) {
            
        }];
        [segments addObject:segment];
    }
    JRSegmentedControlConfiguration* config=[JRSegmentedControlConfiguration defaultConfiguration];
    config.separatorWidth=1;
    config.separatorHeight=20;
    JRSegmentedControl* segmentedControl=[[JRSegmentedControl alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y+20, bounds.size.width, 30) segments:segments configuration:config];
    segmentedControl.delegate=self;
    [self.view addSubview:segmentedControl];
}

-(void)segmentedControl:(JRSegmentedControl *)segmentedControl didSelectSegment:(JRSegment *)segment button:(UIButton *)button lastSelectedSegment:(JRSegment *)lastSegment lastSelectedButton:(UIButton *)lastButton
{
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [lastButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
