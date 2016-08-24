//
//  JRSegmentedControl.h
//  Pods
//
//  Created by ;; on 4/14/16.
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
@property (copy,nonatomic) NSAttributedString* attributedTitle;
@property (copy,nonatomic) JRSegmentedControlDidSelectSegmentAction didSelectSegmentAction;

+(JRSegment*)segmentWithTitle:(NSString*)title;
+(JRSegment*)segmentWithTitle:(NSString*)title action:(JRSegmentedControlDidSelectSegmentAction)action;
+(JRSegment*)segmentWithAttributedTitle:(NSString*)attributedTitle;
+(JRSegment*)segmentWithAttributedTitle:(NSString *)attributedTitle action:(JRSegmentedControlDidSelectSegmentAction)action;

@end

@protocol JRSegmentedControlDelegate <NSObject>

-(void)segmentedControl:(JRSegmentedControl*)segmentedControl didSelectSegment:(JRSegment*)segment button:(UIButton*)button lastSelectedSegment:(JRSegment*)lastSegment lastSelectedButton:(UIButton*)lastButton;

@end

@interface JRSegmentedControl : UIView

@property (nonatomic,readonly) JRSegmentedControlConfiguration* configuration;
@property (nonatomic,weak) id<JRSegmentedControlDelegate> delegate;

@property (nonatomic,readonly) JRSegment* selectedSegemnt;
@property (nonatomic,readonly) UIButton* selectedButton;

@property (strong,readonly) NSArray<UIButton*>* buttons;

-(instancetype)initWithFrame:(CGRect)frame segments:(NSArray<JRSegment*>*)segments configuration:(JRSegmentedControlConfiguration*)configuration;

-(void)setTitle:(NSString*)title forSegmentAtIndex:(NSInteger)index;
-(void)setAttributedTitle:(NSAttributedString*)attributedTitle forSegmentAtIndex:(NSInteger)index;

-(void)selectSegmentAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
