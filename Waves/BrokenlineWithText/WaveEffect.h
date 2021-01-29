//
//  ViewController.h
//  RDWave
//
//  Created by m y on 2019/7/26.
//  Copyright © 2019 m y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveEffect : UIView

@property (nonatomic, strong) UILabel * label;

@property (nonatomic, strong) UIColor * lineColor;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong) UIColor * overlapColor;

// 波浪的fillColor
@property (nonatomic, strong) UIColor * waveColor;

// X轴上的偏移量
@property(nonatomic, assign) CGFloat offsetX;

// 振幅, 默认 20
@property(nonatomic, assign) CGFloat amplitude;

// 系数，控制水波在垂直方向上的偏移（0-1）之间, 默认0.6
@property(nonatomic, assign) CGFloat coefficient;

// 是否将波颠倒（控制闭合方向）
//@property(nonatomic, assign) BOOL reversed;
@end

