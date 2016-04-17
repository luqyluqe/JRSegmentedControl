//
//  JRSegmentedControl.m
//  Pods
//
//  Created by JIRENTIANXIANG on 4/14/16.
//
//

#import "JRSegmentedControl.h"

@interface JRSegment ()

@property (nonatomic,assign) NSInteger index;

@end

@implementation JRSegment

+(JRSegment*)segmentWithTitle:(NSString *)title
{
    return [self segmentWithTitle:title action:nil];
}

+(JRSegment*)segmentWithTitle:(NSString *)title action:(JRSegmentedControlDidSelectSegmentAction)action
{
    JRSegment* segment=[[JRSegment alloc] initWithTitle:title action:action];
    return segment;
}

+(JRSegment*)segmentWithAttributedTitle:(NSString *)attributedTitle
{
    JRSegment* segment=[JRSegment segmentWithAttributedTitle:attributedTitle action:nil];
    return segment;
}

+(JRSegment*)segmentWithAttributedTitle:(NSAttributedString *)attributedTitle action:(JRSegmentedControlDidSelectSegmentAction)action
{
    JRSegment* segment=[[JRSegment alloc] initWithAttributedTitle:attributedTitle action:action];
    return segment;
}

-(instancetype)initWithTitle:(NSString*)title action:(JRSegmentedControlDidSelectSegmentAction)action
{
    if (self=[super init]) {
        self.title=title;
        self.didSelectSegmentAction=action;
    }
    return self;
}

-(instancetype)initWithAttributedTitle:(NSAttributedString*)attributedTitle action:(JRSegmentedControlDidSelectSegmentAction)action
{
    if (self=[super init]) {
        self.attributedTitle=attributedTitle;
        self.didSelectSegmentAction=action;
    }
    return self;
}

@end

@interface JRSegmentedControl ()

@property (strong,nonatomic) NSArray<JRSegment*>* segments;
@property (strong,nonatomic) NSMutableArray<UIButton*>* buttons;
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
        self.buttons=[NSMutableArray new];
        self.backgroundColor=self.configuration.tintColor?:self.configuration.separatorColor;
        _currentsegment=0;
        _count=self.segments.count;
        _width=(self.bounds.size.width)/_count;
        _height=self.bounds.size.height;
        NSInteger i=0;
        for (JRSegment* segment in self.segments) {
            UIButton* button;
            if (segment.attributedTitle) {
                button=[self buttonWithAttributedTitle:segment.attributedTitle atIndex:i];
            }else{
                button=[self buttonWithTitle:segment.title atIndex:i];
            }
            [self.buttons addObject:button];
            [self addSubview:button];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            i++;
        }
        [self initSeparators];
        [self initIndicator];
    }
    return self;
}

-(void)initSeparators
{
    for (int i=1; i<_count; i++) {
        UIView* separator=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.configuration.separatorWidth, self.configuration.separatorHeight)];
        separator.backgroundColor=self.configuration.separatorColor?:self.configuration.tintColor;
        separator.center=CGPointMake(i*_width, _height*0.5);
        [self addSubview:separator];
    }
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
    UIButton* button=[self buttonAtIndex:index];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

-(UIButton*)buttonWithAttributedTitle:(NSAttributedString*)attributedTitle atIndex:(NSInteger)index
{
    UIButton* button=[self buttonAtIndex:index];
    [button setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    return button;
}

-(void)setTitle:(NSString *)title forSegmentAtIndex:(NSInteger)index
{
    self.segments[index].title=title;
    [self.buttons[index] setTitle:title forState:UIControlStateNormal];
}

-(void)setAttributedTitle:(NSAttributedString *)attributedTitle forSegmentAtIndex:(NSInteger)index
{
    self.segments[index].attributedTitle=attributedTitle;
    [self.buttons[index] setAttributedTitle:attributedTitle forState:UIControlStateNormal];
}

-(UIButton*)buttonAtIndex:(NSInteger)index
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor=self.configuration.backgroundColor;
    UIColor* textColor=self.configuration.textColor?:self.configuration.tintColor;
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font=self.configuration.font;
    button.frame=CGRectMake(index*_width, 0, _width, _height);
    button.tag=index;
    return button;
}

-(void)buttonPressed:(UIButton*)sender
{
    if (sender.tag!=_currentsegment) {
        _currentsegment=sender.tag;
        CGFloat centerX=_width*_currentsegment+_width*0.5;
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
    segment.index=sender.tag;
    if (segment.didSelectSegmentAction) {
        segment.didSelectSegmentAction(self,segment);
    }
    if (self.delegate) {
        [self.delegate segmentedControl:self didSelectSegment:segment];
    }
}

@end
