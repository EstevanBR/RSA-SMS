//
//  AppDelegate.m
//  rsasms
//
//  Created by Estevan Hernandez on 2/25/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

static NSString *const kAppHasRunOnce = @"appHasRunOnce";
static NSString *const kUUID = @"uuid";
//NSString* kUUID = @"UUID";
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //http://stackoverflow.com/a/11371362
    //Matt Wildling
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:kAppHasRunOnce] == NO) {
        [defaults setBool:YES forKey:kAppHasRunOnce];
        [defaults setObject:[[NSUUID UUID] UUIDString] forKey:kUUID];
    }
    NSLog(@"app launched");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options {
    NSArray *pathComponents = [url pathComponents];
    NSString *host = [url host];
    NSString* string;
    NSLog(@"%@/", [url host]);
    for (int i = 1; i < [pathComponents count]; i++) {
        NSLog(@"%@%c", pathComponents[i], (i < pathComponents.count) ? '/' : '\0');
        string = [string stringByAppendingString:pathComponents[i]];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"url" object:url];
    return YES;
}

@end
