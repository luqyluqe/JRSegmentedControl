//
//  JRViewController.m
//  JRSegmentedControl
//
//  Created by luqyluqe on 04/14/2016.
//  Copyright (c) 2016 luqyluqe. All rights reserved.
//

#import "JRViewController.h"
#import "JRSegmentedControl.h"

@interface JRViewController ()

@end

@implementation JRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect bounds=self.view.bounds;
    NSMutableArray<JRSegment*>* segments=[NSMutableArray new];
    for (int i=0; i<4; i++) {
        JRSegment* segment=[JRSegment segmentWithTitle:@"JR" action:nil];
        [segments addObject:segment];
    }
    JRSegmentedControlConfiguration* config=[JRSegmentedControlConfiguration defaultConfiguration];
    JRSegmentedControl* segmentedControl=[[JRSegmentedControl alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 40) segments:segments configuration:config];
    [self.view addSubview:segmentedControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
