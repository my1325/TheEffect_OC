//
//  ViewController.m
//  RDWave
//
//  Created by m y on 2019/7/26.
//  Copyright © 2019 m y. All rights reserved.
//

#import "WaveEffect.h"
#import <QuartzCore/QuartzCore.h>

@interface DisplayeLinkProxy: NSProxy
@property (nonatomic, weak) id target;
- (instancetype)initWithTarget:(id)target;
@end

@implementation DisplayeLinkProxy
- (instancetype)initWithTarget:(id)target {
    self.target = target;
    return self ;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
//    [invocation invokeWithTarget:self.target];
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end

@interface WaveEffect ()
@end

@implementation WaveEffect {
    UIView * _contentView;
    UILabel * _copyLabel;
    CAShapeLayer * _waveLayer;
    CAShapeLayer * _circleLayer;
    CAShapeLayer * _contentMask;
    CADisplayLink * _displayLink;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        _lineColor = UIColor.blueColor;
        _waveColor = UIColor.blueColor;
        _overlapColor = UIColor.whiteColor;
        
        _lineWidth = 1;
        
        _amplitude = 20;
        _coefficient = 0.6;
                
        _waveLayer = [CAShapeLayer layer];
        _circleLayer = [CAShapeLayer layer];
        _contentMask = [CAShapeLayer layer];

        _contentView.layer.mask = _contentMask;
        [_contentView.layer addSublayer: _circleLayer];

    }
    return self;
}

- (void)layoutSubviews {
    [self _reload];
}

- (void)_reload {
    self.label.frame = self.bounds;
    _copyLabel.frame = self.bounds;
    _copyLabel.backgroundColor = _waveColor;
    _copyLabel.textColor = _overlapColor;
    _copyLabel.text = _label.text;
    _copyLabel.font = _label.font;
    
    _contentView.frame = self.bounds;
    _contentView.backgroundColor = _overlapColor;
    
    [self _drawCircleLayer];
    [self _startAnimation];
}

- (void)_drawCircleLayer {
    CGFloat midX = CGRectGetMidX(self.bounds);
    CGFloat midY = CGRectGetMidY(self.bounds);
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:(CGPoint){midX, midY}
                                                         radius:MIN(midX, midY) - _lineWidth
                                                     startAngle:0
                                                       endAngle:M_PI * 2
                                                      clockwise:YES];
    _circleLayer.path = path.CGPath;
    _circleLayer.lineWidth = _lineWidth;
    _circleLayer.strokeColor = _lineColor.CGColor;
    _circleLayer.fillColor = UIColor.clearColor.CGColor;
    
    _contentMask.path = path.CGPath;
}

- (UIBezierPath *)_wavePathForOffset: (CGFloat)offset {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    for (CGFloat x = 0; x < width; x ++) {
        CGFloat y = -self.amplitude * sin(M_PI * 2 / width * (x + offset)) + height * self.coefficient;
        if (x == 0) {
            [path moveToPoint:(CGPoint){x, height * self.coefficient}];
        } else {
            [path addLineToPoint:(CGPoint){x, y}];
        }
    }
    [path addLineToPoint:(CGPoint){width, height}];
    [path addLineToPoint:(CGPoint){0, height}];
    [path closePath];
    return path;
}

- (void)_startAnimation {
    _displayLink = [CADisplayLink displayLinkWithTarget:[[DisplayeLinkProxy alloc] initWithTarget:self]
                                               selector:@selector(_drawWaveLayer)];
    _displayLink.preferredFramesPerSecond = 60;
    
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)_drawWaveLayer {
    static CGFloat offset = 0;
    offset += 1;
    if (offset > self.bounds.size.width) {
        offset = 0;
    }
    UIBezierPath * path = [self _wavePathForOffset: offset];
    _waveLayer.path = path.CGPath;
    _waveLayer.fillColor = UIColor.whiteColor.CGColor;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = UIColor.blackColor;
        _label.textAlignment = NSTextAlignmentCenter;
        
        _copyLabel = [[UILabel alloc] init];
        _copyLabel.font = [UIFont systemFontOfSize:14];
        _copyLabel.textColor = UIColor.blackColor;
        _copyLabel.textAlignment = NSTextAlignmentCenter;
        _copyLabel.layer.mask = _waveLayer;

        [_contentView addSubview:_label];
        [_contentView addSubview:_copyLabel];
    }
    return _label;
}

@end
