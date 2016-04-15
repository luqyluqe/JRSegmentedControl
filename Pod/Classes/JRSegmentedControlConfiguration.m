//
//  JRSegmentedControlConfiguration.m
//  Pods
//
//  Created by JIRENTIANXIANG on 4/14/16.
//
//

#import "JRSegmentedControlConfiguration.h"

@implementation JRSegmentedControlConfiguration

+(JRSegmentedControlConfiguration*)defaultConfiguration
{
    JRSegmentedControlConfiguration* config=[JRSegmentedControlConfiguration new];
    config.backgroundColor=[UIColor whiteColor];
    config.tintColor=[UIColor blueColor];
    config.indicatorPosition=JRSegmentedControlIndicatorPositionBottom;
    config.font=[UIFont systemFontOfSize:14];
    config.indicatorWidth=2;
    config.separatorWidth=0;
    config.separatorHeight=0;
    return config;
}

@end
