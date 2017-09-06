//
//  MainTableViewCell.h
//  WekerLockSDK
//
//  Created by 黄珂耀 on 2017/9/4.
//  Copyright © 2017年 hduhky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDCommonLock;
@class MainTableViewCell;

@protocol MainTableViewCellDelegate <NSObject>

- (void)mainTableViewCellShouldBindLock;

- (void)mainTableViewCellShouldOpenLockWithCell:(MainTableViewCell *)cell;

- (void)mainTableViewCellShouldActivePasswordWithCell:(MainTableViewCell *)cell;

- (void)mainTableViewCellShouldChangePasswordWithCell:(MainTableViewCell *)cell;

@end

typedef enum : NSUInteger {
    LockTypeUnBind,
    LockTypeBind,
} LockType;

extern NSString *const MainTableViewCellIdentifier;

@interface MainTableViewCell : UITableViewCell

@property (nonatomic, assign) LockType type;

@property (nonatomic, strong) ZDCommonLock *commonLock;

@property (nonatomic, copy) NSString *lockName;

@property (nonatomic, weak) id <MainTableViewCellDelegate> delegate;

@end
