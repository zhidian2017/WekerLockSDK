//
//  ViewController.m
//  WekerLockSDK
//
//  Created by hduhky on 09/04/2017.
//  Copyright (c) 2017 hduhky. All rights reserved.
//

#import "ViewController.h"
#import "MainSectionHeaderView.h"
#import "MainTableViewCell.h"
#import <WekerLockSDK/ZDCommonLock.h>

#import <CoreBluetooth/CoreBluetooth.h>
#import <WekerLockSDK/WLSdk.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, WLSdkDelegate, MainTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *myDevices;

@property (nonatomic, strong) NSMutableArray *otherDevices;

@end

@implementation ViewController {
    MainSectionHeaderView *_indicatorHeaderView;
    
    UITextField *_passwordTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Weker智能锁";
    
    self.myDevices = [NSMutableArray new];
    self.otherDevices = [NSMutableArray new];
    
    [WLSdk sharedInstance].delegate = self;

    [self createUI];
    
    [self loadData];
}

- (void)loadData {
    NSArray *lockArray = [WLSdk getLockInfo];
    if (lockArray) {
        self.myDevices = [lockArray mutableCopy];
    } else {
        [self.myDevices removeAllObjects];
    }
    [self.tableView reloadData];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    self.navigationItem.rightBarButtonItem = refresh;
    
    UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(clear)];
    self.navigationItem.leftBarButtonItem = clear;
}

- (void)clear {
    [WLSdk clearLockInfo];
    [self loadData];
}

- (void)refresh {
    [[WLSdk sharedInstance] startBluetoothService];
    [_indicatorHeaderView startAnimate];
}

#pragma mark - WLSdk delegate
- (void)didFindBluetoothDeviceWithLockInfo:(CBPeripheral *)lockInfo {
    [self.otherDevices removeAllObjects];
    [self.otherDevices addObject:lockInfo];
    [self.tableView reloadData];
    [_indicatorHeaderView stopAnimate];
}

- (void)bindLockSucceed {
    [[WLSdk sharedInstance] stopBluetoothService];
    [self.otherDevices removeAllObjects];
    [self loadData];
}

- (void)bindLockFailedWithError:(NSString *)error {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[WLSdk sharedInstance] stopBluetoothService];
        [self.otherDevices removeAllObjects];
        [self.tableView reloadData];
    });
}

- (void)activePasswordSucceedWithPassword:(NSString *)password {
    NSLog(@"%@",password);
    [self loadData];
}

- (void)changePasswordSucceedWithNewPassword:(NSString *)newPassword {
    NSLog(@"%@",newPassword);
    [self loadData];
}

#pragma mark - mainTableViewCell delegate
- (void)mainTableViewCellShouldBindLock {
    [[WLSdk sharedInstance] bindLock];
}

- (void)mainTableViewCellShouldOpenLockWithCell:(MainTableViewCell *)cell {
    [[WLSdk sharedInstance] openLockWithCommonLock:[self getCommonLockInfoWithCell:cell]];
}

- (void)mainTableViewCellShouldActivePasswordWithCell:(MainTableViewCell *)cell {
    [[WLSdk sharedInstance] activePasswordWithCommonLock:[self getCommonLockInfoWithCell:cell]];
}

- (void)mainTableViewCellShouldChangePasswordWithCell:(MainTableViewCell *)cell {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入6位新密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (_passwordTextField.text.length == 6) {
            [[WLSdk sharedInstance] changePasswordWithNewPassword:_passwordTextField.text commonLock:[self getCommonLockInfoWithCell:cell]];
        }
    }];
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField = textField;
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (ZDCommonLock *)getCommonLockInfoWithCell:(MainTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ZDCommonLock *commonLock = [ZDCommonLock lockInfoWithDict:self.myDevices[indexPath.row]];
    return commonLock;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MainSectionHeaderView *headerView = [[MainSectionHeaderView alloc] initWithType:section];
    if (section == 1) {
        _indicatorHeaderView = headerView;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.myDevices.count;
    } else {
        return self.otherDevices.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainTableViewCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.section == 0) {
        cell.type = LockTypeBind;
        NSDictionary *lockInfo = self.myDevices[indexPath.row];
        cell.commonLock = [ZDCommonLock lockInfoWithDict:lockInfo];
    } else {
        cell.type = LockTypeUnBind;
        CBPeripheral *lockInfo = self.otherDevices[indexPath.row];
        cell.lockName = lockInfo.name;
    }
    return cell;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        [_tableView registerNib:[UINib nibWithNibName:MainTableViewCellIdentifier bundle:nil] forCellReuseIdentifier:MainTableViewCellIdentifier];
    }
    return _tableView;
}

@end
