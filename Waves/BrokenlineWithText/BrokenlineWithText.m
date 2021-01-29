//
//  BrokenlineWithText.m
//  Waves
//
//  Created by my on 2021/1/29.
//

#import "BrokenlineWithText.h"
#import <CoreText/CTFont.h>
#import <QuartzCore/QuartzCore.h>

@implementation BrokenlineWithText {
    CAShapeLayer * _brokenLineLayer;
    CAGradientLayer * _maskLayer;
    UIView * _contentView;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.blackColor;
        
        self.brokenlineColor = UIColor.redColor;
        self.brokenlineWidth = 1;
        
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
        
        _brokenLineLayer = [CAShapeLayer layer];
        [_contentView.layer addSublayer:_brokenLineLayer];
        
        [self _addMaskLayer];
    }
    return self;
}

- (void)layoutSubviews {
    [self _reload];
}

- (void)_reload {
    _contentView.frame = self.bounds;
    _maskLayer.frame = self.bounds;
    self.label.frame = self.bounds;
    [self _drawBrokenline];
    [self _startAnimation];
}

- (void)_drawBrokenline {
    CGFloat midY = CGRectGetMidY(self.bounds);
    CGFloat midX = CGRectGetMidX(self.bounds);
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:(CGPoint){0, midY}];
    [path addLineToPoint:(CGPoint){midX * 0.25, midY}];
    [path addLineToPoint:(CGPoint){midX * 0.5, 0}];
    [path addLineToPoint:(CGPoint){midX * 1.5, midY * 2}];
    [path addLineToPoint:(CGPoint){midX * 1.75, midY}];
    [path addLineToPoint:(CGPoint){midX * 2, midY}];
//    [path closePath];
    
    _brokenLineLayer.path = path.CGPath;
    _brokenLineLayer.strokeColor = _brokenlineColor.CGColor;
    _brokenLineLayer.lineWidth = _brokenlineWidth;
    _brokenLineLayer.lineCap = kCALineCapSquare;
    _brokenLineLayer.lineJoin = kCALineJoinMiter;
}

- (void)_addMaskLayer {
    _maskLayer = [CAGradientLayer layer];
    _maskLayer.colors = @[(__bridge id)UIColor.clearColor.CGColor, (__bridge id)UIColor.blackColor.CGColor, (__bridge id)UIColor.clearColor.CGColor];
    _maskLayer.locations = @[@(0.0), @(0.125), @(0.25)];
    _maskLayer.startPoint = (CGPoint){0, 0};
    _maskLayer.endPoint = (CGPoint){1, 0};
    _contentView.layer.mask = _maskLayer;
}

- (void)_startAnimation {
    [_maskLayer removeAllAnimations];
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"locations"];
    animation.values = @[
    @[@(-0.25), @(-0.125), @(0)],
    @[@(-0.125), @(0.0), @(0.125)],
    @[@(0.0), @(0.125), @(0.25)],
    @[@(0.125), @(0.25), @(0.375)],
    @[@(0.25), @(0.375), @(0.5)],
    @[@(0.375), @(0.5), @(0.625)],
    @[@(0.5), @(0.625), @(0.75)],
    @[@(0.625), @(0.75), @(0.875)],
    @[@(0.75), @(0.875), @(1)],
    @[@(0.875), @(1), @(1.125)],
    @[@(1), @(1.125), @(1.25)],
    ];
    animation.keyTimes = @[@(0.0), @(0.1), @(0.2), @(0.3), @(0.4), @(0.5), @(0.6), @(0.7), @(0.8), @(0.9), @(1)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 3;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [_maskLayer addAnimation:animation forKey:nil];
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = UIColor.whiteColor;
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_label];
    }
    return _label;
}

@end
