//
//  WBProgressView.m
//  WBProgress
//
//  Created by Zwb on 16/4/5.
//  Copyright © 2016年 zwb. All rights reserved.
//

#import "WBProgressView.h"

static NSTimeInterval duration = 2.f; // 动画时长
#define SCREEN_W self.bounds.size.width
#define SCREEN_H self.bounds.size.height

@interface WBProgressView ()
{
    CGFloat prog;
    CGFloat lwidth;
    UILabel *label;
    UIColor *topcolor;
    UIColor *bottomcolor;
    CALayer *viewLayer;
    CAShapeLayer *maskLayer;
}
@property (nonatomic, assign) CGFloat prog;
@property (nonatomic, assign) CGFloat lwidth;
@property (nonatomic, strong) UIColor *topcolor;
@property (nonatomic, strong) UIColor *bottomcolor;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CALayer *viewLayer;
@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation WBProgressView
@synthesize prog = _prog;
@synthesize label  = _label;
@synthesize lwidth = _lwidth;
@synthesize topcolor = _topcolor;
@synthesize viewLayer = _viewLayer;
@synthesize maskLayer = _maskLayer;
@synthesize bottomcolor = _bottomcolor;

- (instancetype)initWithFrame:(CGRect)frame progress:(CGFloat)progress lineWidth:(CGFloat)linewidth topColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor{
    self = [super initWithFrame:frame];
    if (self) {
        prog = progress;
        lwidth = linewidth;
        topcolor = topColor;
        bottomcolor = bottomColor;
        self.backgroundColor = [UIColor clearColor];
        [self initWithUserInterface];
    }
    return self;
}

-(void)showProgressViewInView:(UIView *)view{
    self.center = view.center;
    [view addSubview:self];
}

- (void) initWithUserInterface{
    [self setlayer];
    [self.layer addSublayer:viewLayer];
    
    // 两个view显示不同的渐变色
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.bounds = CGRectMake(0, 0, SCREEN_W/2, SCREEN_H);
    gradient.position = CGPointMake(SCREEN_W/4, SCREEN_H/2);
    gradient.colors = @[(__bridge id)topcolor.CGColor, (__bridge id)bottomcolor.CGColor];
    gradient.startPoint = CGPointMake(0, 1);
    gradient.endPoint = CGPointMake(0, 0);
    [viewLayer addSublayer:gradient];
    
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.bounds = CGRectMake(0, 0, SCREEN_W/2, SCREEN_H);
    gradient1.position = CGPointMake(SCREEN_W/4*3, SCREEN_H/2);
    if (prog > 0.5) {
        gradient1.colors = @[(__bridge id)topcolor.CGColor, (__bridge id)bottomcolor.CGColor];
    }else
        gradient1.colors = @[(__bridge id)bottomcolor.CGColor, (__bridge id)topcolor.CGColor];
    gradient1.startPoint = CGPointMake(0, 1);
    gradient1.endPoint = CGPointMake(0, 0);
    [viewLayer addSublayer:gradient1];
    
    // 设置圆环
    viewLayer.mask = maskLayer;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:SCREEN_W/2-lwidth/2 startAngle:-M_PI_2 endAngle:M_PI * 2-M_PI_2 clockwise:YES];
    maskLayer.path = path.CGPath;
    
    // 圆环动画
    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    base.duration = duration;
    base.fromValue = @0.0;
    base.toValue = [NSNumber numberWithFloat:prog];
    base.fillMode = kCAFillModeForwards;
    base.removedOnCompletion = NO;
    [maskLayer addAnimation:base forKey:nil];
    
    static float count = 0.0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    NSString *string = [NSString stringWithFormat:@"%0f",(prog * 100)];
    NSInteger time = [string integerValue];
    if (time <= 30) {
        prog += 0.01;
    }
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), duration/time * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(count >= prog){
            dispatch_source_cancel(_timer);
        }else{
            NSString *strTime = [NSString stringWithFormat:@"%0.0f", count * 100];
            dispatch_async(dispatch_get_main_queue(), ^{
                label.text = [strTime stringByAppendingString:@"%"];
            });
            count += 0.01;
            
        }
    });
    dispatch_resume(_timer);
    
}

#pragma mark -- 初始化两个layer
- (void) setlayer{
    viewLayer = [CALayer layer];
    viewLayer.bounds = self.bounds;
    viewLayer.position = self.center;
    
    maskLayer = [CAShapeLayer layer];
    maskLayer.lineWidth = lwidth;
    maskLayer.strokeColor = topcolor.CGColor;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.bounds = self.bounds;
    maskLayer.position = self.center;
    
    // 添加一个提示
    [self setWarnLabel];
}

- (void) setWarnLabel{
    label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, SCREEN_W - lwidth * 2 - 10, 20);
    label.center =self.center;
    label.textColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
    label.text = @"0%";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20.f * SCREEN_W / 100];
    [self addSubview:label];
}


@end
