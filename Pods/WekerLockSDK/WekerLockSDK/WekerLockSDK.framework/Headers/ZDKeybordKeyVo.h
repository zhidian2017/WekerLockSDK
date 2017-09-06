//
//  ZDKeybordKeyVo.h
//  zhidianLock
//
//  Created by 江欣华 on 16/6/12.
//  Copyright © 2016年 zhidiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDKeybordKeyVo : NSObject


@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger keyStatus;

@property (nonatomic, copy) NSString *clientId;

@property (nonatomic, assign) NSInteger lockId;

@property (nonatomic, assign) NSInteger sendStatus;

@property (nonatomic, copy) NSString *keyPassword;

@property (nonatomic, copy) NSString *lockNumber;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, assign) NSInteger keyType;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *lockPassword;

@property (nonatomic, assign) NSInteger userLockId;

@property (nonatomic, assign) NSInteger adminUserId;

@property (nonatomic, copy) NSString *startTime;

-(NSString *)showKeyType;

-(NSString *)showKeyStatus;

@end
