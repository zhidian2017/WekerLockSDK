//
//  WLSdk.h
//  Pods
//
//  Created by 黄珂耀 on 2017/9/4.
//
//

#import <Foundation/Foundation.h>

@class CBPeripheral;
@class ZDCommonLock;


/**
 SDK回调
 */
@protocol WLSdkDelegate <NSObject>

/**
 手机搜索到了门锁

 @param lockInfo 搜索到的门锁蓝牙信息
 */
- (void)didFindBluetoothDeviceWithLockInfo:(CBPeripheral *)lockInfo;


/**
 绑定门锁成功
 */
- (void)bindLockSucceed;


/**
 绑定门锁失败

 @param error 错误信息
 */
- (void)bindLockFailedWithError:(NSString *)error;

/**
 激活密码成功

 @param password 键盘密码
 */
- (void)activePasswordSucceedWithPassword:(NSString *)password;

/**
 修改密码成功

 @param newPassword 键盘密码
 */
- (void)changePasswordSucceedWithNewPassword:(NSString *)newPassword;

@end

@interface WLSdk : NSObject

@property (nonatomic, weak) id <WLSdkDelegate> delegate;

/**
 获取SDK单例

 @return 单例
 */
+ (instancetype)sharedInstance;

/**
 拿到本地保存的门锁列表信息

 @return 门锁列表
 */
+ (NSArray *)getLockInfo;

/**
 清空本地门锁列表信息
 */
+ (void)clearLockInfo;

/**
 开始蓝牙扫描
 */
- (void)startBluetoothService;

/**
 停止蓝牙扫描
 */
- (void)stopBluetoothService;

/**
 绑定被重置的门锁
 */
- (void)bindLock;

/**
 开门

 @param commonLock 被绑定成功的门锁信息
 */
- (void)openLockWithCommonLock:(ZDCommonLock *)commonLock;

/**
 激活密码

 @param commonLock 被绑定成功的门锁信息
 */
- (void)activePasswordWithCommonLock:(ZDCommonLock *)commonLock;


/**
 修改密码

 @param newPassword 新密码 长度6位（完整密码为8位，前2位由锁自动生成）
 @param commonLock 被绑定成功的门锁信息
 */
- (void)changePasswordWithNewPassword:(NSString *)newPassword commonLock:(ZDCommonLock *)commonLock;

@end
