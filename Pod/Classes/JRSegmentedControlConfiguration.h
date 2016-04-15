//
//  JRSegmentedControlConfiguration.h
//  Pods
//
//  Created by JIRENTIANXIANG on 4/14/16.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,JRSegmentedControlIndicatorPosition){
    JRSegmentedControlIndicatorPositionTop,
    JRSegmentedControlIndicatorPositionBottom
};

@interface JRSegmentedControlConfiguration : NSObject

@property (nonatomic,copy) UIColor* tintColor;
@property (nonatomic,assign) JRSegmentedControlIndicatorPosition indicatorPosition;
@property (nonatomic,assign) CGFloat indicatorWidth;
@property (nonatomic,copy) UIColor* indicatorColor;
@property (nonatomic,assign) UIFont* font;
@property (nonatomic,copy) UIColor* textColor;

+(JRSegmentedControlConfiguration*)defaultConfiguration;

@end
