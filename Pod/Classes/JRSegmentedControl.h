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
@class JRSegment;

typedef void(^JRSegmentedControlDidSelectSegmentAction)(JRSegmentedControl* segmentedControl,JRSegment* segment);

@interface JRSegment : NSObject

@property (readonly,nonatomic) NSInteger index;
@property (assign,nonatomic) NSInteger tag;
@property (strong,nonatomic) id data;
@property (copy,nonatomic) NSString* title;
@property (copy,nonatomic) JRSegmentedControlDidSelectSegmentAction didSelectSegmentAction;

+(JRSegment*)segmentWithTitle:(NSString*)title;
+(JRSegment*)segmentWithTitle:(NSString*)title action:(JRSegmentedControlDidSelectSegmentAction)action;

@end

@protocol JRSegmentedControlDelegate <NSObject>

-(void)segmentedControl:(JRSegmentedControl*)segmentedControl didSelectSegment:(JRSegment*)segment;

@end

@interface JRSegmentedControl : UIView

@property (nonatomic,strong) JRSegmentedControlConfiguration* configuration;
@property (nonatomic,strong) id<JRSegmentedControlDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame segments:(NSArray<JRSegment*>*)segments configuration:(JRSegmentedControlConfiguration*)configuration;

@end
