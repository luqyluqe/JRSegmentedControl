//
//  JRSegmentedControl.h
//  Pods
//
//  Created by JIRENTIANXIANG on 4/14/16.
//
//

#import <UIKit/UIKit.h>
#import "JRSegmentedControlConfiguration.h"

@class JRSegmentedControl;

typedef void(^JRSegmentedControlAction)(JRSegmentedControl* segmentedControl);

@interface JRSegment : NSObject

@property (copy,nonatomic) NSString* title;
@property (copy,nonatomic) JRSegmentedControlAction action;

+(JRSegment*)segmentWithTitle:(NSString*)title action:(JRSegmentedControlAction)action;

@end

@interface JRSegmentedControl : UIView

@property (nonatomic,strong) JRSegmentedControlConfiguration* configuration;

-(instancetype)initWithFrame:(CGRect)frame segments:(NSArray<JRSegment*>*)segments configuration:(JRSegmentedControlConfiguration*)configuration;

@end
