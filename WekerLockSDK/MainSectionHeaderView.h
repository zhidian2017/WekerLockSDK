//
//  MainSectionHeaderView.h
//  WekerLockSDK
//
//  Created by 黄珂耀 on 2017/9/4.
//  Copyright © 2017年 hduhky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SectionHeaderTypeMineDevice = 0,
    SectionHeaderTypeFindDevice,
} SectionHeaderType;

@interface MainSectionHeaderView : UIView

- (instancetype)initWithType:(SectionHeaderType)type;

- (void)startAnimate;

- (void)stopAnimate;

@end
