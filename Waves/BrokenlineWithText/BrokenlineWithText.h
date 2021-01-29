//
//  BrokenlineWithText.h
//  Waves
//
//  Created by my on 2021/1/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrokenlineWithText : UIView


@property (nonatomic, strong) UILabel * label;

/// 折线颜色
@property (nonatomic, strong) UIColor *  brokenlineColor;

/// 折线宽度
@property (nonatomic, assign) CGFloat brokenlineWidth;
@end

NS_ASSUME_NONNULL_END
