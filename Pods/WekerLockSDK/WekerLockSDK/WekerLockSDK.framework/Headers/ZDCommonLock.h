//
//  ZDCommonLock.h
//  zhidianLock
//
//  Created by 江欣华 on 16/6/12.
//  Copyright © 2016年 zhidiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZDKeybordKeyVo;
@class ZDFirmWareVo;

@interface ZDCommonLock : NSObject


@property (nonatomic, copy) NSString *lockEnergy;

@property (nonatomic, copy) NSString *lockPassword;

@property (nonatomic, copy) NSString *userLevel;

@property (nonatomic, copy) NSString *lockName;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *userLockId;

@property (nonatomic, copy) NSString *keyStatus;

@property (nonatomic, copy) NSString *finger;

@property (nonatomic, copy) NSString *fingerUserCount;

@property (nonatomic, copy) NSString *keyType;

@property (nonatomic, assign) NSInteger lockId;

@property (nonatomic, copy) NSString *adminPhone;

@property (nonatomic, assign) NSInteger roleType;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *keyId;

@property (nonatomic, copy) NSString *startAllTime;

@property (nonatomic, copy) NSString *userImage;

@property (nonatomic, copy) NSString *isOpened;

@property (nonatomic, copy) NSString *senderId;

@property (nonatomic, copy) NSString *fingerLockIndex;

@property (nonatomic, copy) NSString *userMobile;

@property (nonatomic, assign) NSInteger sendType;

@property (nonatomic, assign) NSInteger sendKeyType;

@property (nonatomic, strong)ZDKeybordKeyVo *keybordKeyVo;

@property (nonatomic, copy) NSString *lockNumber;

@property (nonatomic, copy) NSString *adminId;

@property (nonatomic, copy) NSString *adminName;

@property (nonatomic, strong)ZDFirmWareVo *firmwareVo;

@property (nonatomic, copy) NSString *lockVersion;

@property (nonatomic, assign) NSInteger needUpgrade;

@property (nonatomic, copy) NSString *endAllTime;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) NSInteger lockType;

@property (nonatomic, assign) NSInteger isOpenKeySend;

@property (nonatomic, assign) NSInteger isOpenLockNotify;


+(NSString *)showRoleType:(NSInteger)roleType;
+(NSString *)showKeyType:(NSInteger)keyType;
+(NSString *)showLockType:(NSInteger)lockType;
+(NSString *)showKeyStatus:(NSInteger)keyStatus;

-(NSString *)showRoleType;
-(NSString *)showKeyType;
-(NSString *)showLockType;
-(NSString *)showKeyStatus;


+ (instancetype)lockInfoWithDict:(NSDictionary *)dict;
+ (void)requestCommonLockWithCompleteBlock:(void (^)(NSArray * ,NSInteger))completeBlock;
+ (void)requestOtherLockWithPageIndex:(NSInteger)pageIndex CompleteBlock:(void (^)(NSArray * ,NSInteger))completeBlock;
+ (void)requestMyCollectionWithUrl:(NSString *)url parameters:(id)parameters CompleteBlock:(void (^)(NSArray * ,NSInteger))completeBlock;
@end
