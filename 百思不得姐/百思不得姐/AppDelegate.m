//
//  AppDelegate.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/9.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "AppDelegate.h"
#import "MRTabBarController.h"
#import "MRPushGuideView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    self.window.rootViewController = [[MRTabBarController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    [MRPushGuideView show];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
   
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
