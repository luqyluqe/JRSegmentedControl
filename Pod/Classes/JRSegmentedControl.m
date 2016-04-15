//
//  JRSegmentedControl.m
//  Pods
//
//  Created by JIRENTIANXIANG on 4/14/16.
//
//

#import "JRSegmentedControl.h"

@implementation JRSegment

+(JRSegment*)segmentWithTitle:(NSString *)title action:(JRSegmentedControlAction)action
{
    JRSegment* segment=[[JRSegment alloc] initWithTitle:title action:action];
    return segment;
}

-(instancetype)initWithTitle:(NSString*)title action:(JRSegmentedControlAction)action
{
    if (self=[super init]) {
        self.title=title;
        self.action=action;
    }
    return self;
}

@end

@interface JRSegmentedControl ()

@property (strong,nonatomic) NSArray<JRSegment*>* segments;
@property (strong,nonatomic) UIView* indicator;

@end

@implementation JRSegmentedControl
{
    NSInteger _count;
    NSInteger _currentsegment;
    CGFloat _width;
    CGFloat _height;
}

-(instancetype)initWithFrame:(CGRect)frame segments:(NSArray<JRSegment *> *)segments configuration:(JRSegmentedControlConfiguration *)configuration
{
    if (self=[super initWithFrame:frame]) {
        self.configuration=configuration;
        self.segments=segments;
        self.backgroundColor=self.configuration.tintColor?:self.configuration.separatorColor;
        _currentsegment=0;
        _count=self.segments.count;
        _width=(self.bounds.size.width-(_count-1)*self.configuration.separatorWidth)/_count;
        _height=self.bounds.size.height;
        NSInteger i=0;
        for (JRSegment* segment in self.segments) {
            UIButton* button=[self buttonWithTitle:segment.title atIndex:i];
            [self addSubview:button];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            i++;
        }
        [self initIndicator];
    }
    return self;
}

-(void)initIndicator
{
    CGFloat originY=0;
    if (self.configuration.indicatorPosition==JRSegmentedControlIndicatorPositionTop) {
        originY=0;
    }else if (self.configuration.indicatorPosition==JRSegmentedControlIndicatorPositionBottom){
        originY=_height-self.configuration.indicatorWidth;
    }
    self.indicator=[[UIView alloc] initWithFrame:CGRectMake(_currentsegment*_width, originY, _width, self.configuration.indicatorWidth)];
    if (self.configuration.indicatorColor) {
        self.indicator.backgroundColor=self.configuration.indicatorColor;
    }else{
        self.indicator.backgroundColor=self.configuration.tintColor;
    }
    [self addSubview:self.indicator];

}

-(UIButton*)buttonWithTitle:(NSString*)title atIndex:(NSInteger)index
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor=self.configuration.backgroundColor;
    [button setTitle:title forState:UIControlStateNormal];
    UIColor* textColor=self.configuration.textColor?:self.configuration.tintColor;
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font=self.configuration.font;
    button.frame=CGRectMake(index*(_width+self.configuration.separatorWidth), 0, _width, _height);
    button.tag=index;
    return button;
}

-(void)buttonPressed:(UIButton*)sender
{
    if (sender.tag!=_currentsegment) {
        _currentsegment=sender.tag;
        CGFloat centerX=(_width+self.configuration.separatorWidth)*_currentsegment+_width*0.5;
        CGFloat centerY=self.configuration.indicatorWidth*0.5;
        if (self.configuration.indicatorPosition==JRSegmentedControlIndicatorPositionTop) {
            centerY=self.configuration.indicatorWidth*0.5;
        }else if (self.configuration.indicatorPosition==JRSegmentedControlIndicatorPositionBottom){
            centerY=_height-self.configuration.indicatorWidth*0.5;
        }
        [UIView animateWithDuration:0.4 animations:^{
            self.indicator.center=CGPointMake(centerX,centerY);
        }];
    }
    JRSegment* segment=self.segments[sender.tag];
    if (segment.action) {
        segment.action(self);
    }
}

@end