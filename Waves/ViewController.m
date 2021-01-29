//
//  ViewController.m
//  Waves
//
//  Created by my on 2021/1/29.
//

#import "ViewController.h"
#import "BrokenlineWithText.h"
#import "WaveEffect.h"

@interface ViewController ()

@property (nonatomic, strong) BrokenlineWithText * waveView;

@property (nonatomic, strong) WaveEffect * waveEffectView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    self.waveView.frame = CGRectMake(100, 100, 100, 50);
    self.waveEffectView.frame = CGRectMake(100, 200, 100, 100);
}

- (BrokenlineWithText *)waveView {
    if (!_waveView) {
        _waveView = [[BrokenlineWithText alloc] init];
        _waveView.label.text = @"ZZ";
        _waveView.label.font = [UIFont systemFontOfSize:30];
        _waveView.label.textAlignment = NSTextAlignmentCenter;
        _waveView.brokenlineColor = UIColor.redColor;
        _waveView.brokenlineWidth = 2;
        _waveView.backgroundColor = UIColor.blackColor;
        [self.view addSubview:_waveView];
    }
    return _waveView;
}

- (WaveEffect *)waveEffectView {
    if (!_waveEffectView) {
        _waveEffectView = [[WaveEffect alloc] init];
        _waveEffectView.label.text = @"RD";
        _waveEffectView.label.font = [UIFont systemFontOfSize:60 weight:UIFontWeightMedium];
        _waveEffectView.label.textAlignment = NSTextAlignmentCenter;
        _waveEffectView.label.textColor = [UIColor blueColor];
        _waveEffectView.waveColor = UIColor.blueColor;
        _waveEffectView.overlapColor = UIColor.redColor;
        _waveEffectView.amplitude = 10;
        _waveEffectView.coefficient = 0.5;
        [self.view addSubview:_waveEffectView];
    }
    return _waveEffectView;
}

@end
