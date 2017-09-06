//
//  AppDelegate.m
//  WekerLockSDK
//
//  Created by hduhky on 09/04/2017.
//  Copyright (c) 2017 hduhky. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *mainVc = [ViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    return YES;
}


@end
