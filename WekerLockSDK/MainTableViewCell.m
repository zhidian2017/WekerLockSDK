//
//  MainTableViewCell.m
//  WekerLockSDK
//
//  Created by 黄珂耀 on 2017/9/4.
//  Copyright © 2017年 hduhky. All rights reserved.
//

#import "MainTableViewCell.h"
#import <WekerLockSDK/ZDCommonLock.h>
#import <WekerLockSDK/ZDKeybordKeyVo.h>

NSString *const MainTableViewCellIdentifier = @"MainTableViewCell";

@interface MainTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *lockNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *funcButton;

@property (weak, nonatomic) IBOutlet UIButton *activeButton;

@end

@implementation MainTableViewCell {
    ZDKeybordKeyVo *_keyboardKeyVo;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setType:(LockType)type {
    _type = type;
    switch (type) {
        case LockTypeUnBind: {
            [self.funcButton setTitle:@"绑定" forState:UIControlStateNormal];
            [self.funcButton addTarget:self action:@selector(bindLock) forControlEvents:UIControlEventTouchUpInside];
            self.activeButton.hidden = YES;
        }
            break;
        case LockTypeBind: {
            [self.funcButton setTitle:@"开锁" forState:UIControlStateNormal];
            [self.funcButton addTarget:self action:@selector(openLock) forControlEvents:UIControlEventTouchUpInside];
            self.activeButton.hidden = NO;
        }
            break;
    }
}

- (void)setCommonLock:(ZDCommonLock *)commonLock {
    _commonLock = commonLock;
    _keyboardKeyVo = commonLock.keybordKeyVo;
    self.lockNameLabel.text = commonLock.lockName;
    if (_keyboardKeyVo.keyStatus == 1) {
        [self.activeButton setTitle:_keyboardKeyVo.keyPassword forState:UIControlStateNormal];
        [self.activeButton addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    } else if (_keyboardKeyVo.keyStatus == 4) {
        [self.activeButton setTitle:@"激活密码" forState:UIControlStateNormal];
        [self.activeButton addTarget:self action:@selector(activePassword) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setLockName:(NSString *)lockName {
    _lockName = lockName;
    self.lockNameLabel.text = lockName;
}

- (void)bindLock {
    if (self.type == LockTypeBind) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(mainTableViewCellShouldBindLock)]) {
        [self.delegate mainTableViewCellShouldBindLock];
    }
}

- (void)openLock {
    if (self.type == LockTypeUnBind) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(mainTableViewCellShouldOpenLockWithCell:)]) {
        [self.delegate mainTableViewCellShouldOpenLockWithCell:self];
    }
}

- (void)activePassword {
    if (_keyboardKeyVo.keyStatus == 1) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(mainTableViewCellShouldActivePasswordWithCell:)]) {
        [self.delegate mainTableViewCellShouldActivePasswordWithCell:self];
    }
}

- (void)changePassword {
    if (_keyboardKeyVo.keyStatus == 4) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(mainTableViewCellShouldChangePasswordWithCell:)]) {
        [self.delegate mainTableViewCellShouldChangePasswordWithCell:self];
    }
}

@end
