//
//  MainSectionHeaderView.m
//  WekerLockSDK
//
//  Created by 黄珂耀 on 2017/9/4.
//  Copyright © 2017年 hduhky. All rights reserved.
//

#import "MainSectionHeaderView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MainSectionHeaderView ()

@property (nonatomic, assign) SectionHeaderType type;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end

@implementation MainSectionHeaderView

- (instancetype)initWithType:(SectionHeaderType)type {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        _type = type;
        [self config];
    }
    return self;
}

- (void)startAnimate {
    [self.activityView startAnimating];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.activityView.hidden = NO;
    });
}

- (void)stopAnimate {
    [self.activityView stopAnimating];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.activityView.hidden = YES;
    });
}

- (void)config {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.activityView.hidden = YES;
    });
    switch (self.type) {
        case SectionHeaderTypeMineDevice:
            self.titleLabel.text = @"我的设备";
            break;
        case SectionHeaderTypeFindDevice:
            self.titleLabel.text = @"其他设备";
            break;
    }
}

@end
