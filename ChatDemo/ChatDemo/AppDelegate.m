//
//  AppDelegate.m
//  ChatDemo
//
//  Created by lj on 16/7/14.
//  Copyright © 2016年 liujia. All rights reserved.
//

#import "AppDelegate.h"
#import "EMOptions.h"
#import "EMClient.h"
#define EaseMobAppKey @"jialiu#jiachatdemo"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    注册环信SDK
    [self registerChat];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
    return YES;
}

-(void)registerChat
{
    EMOptions *options = [EMOptions optionsWithAppkey:EaseMobAppKey];
    EMError *error = [[EMClient sharedClient] initializeSDKWithOptions:options];
    NSLog(@"");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
