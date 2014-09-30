//
//  JYAppDelegate.m
//  IEJB
//
//  Created by Jonathan Jordan Carrillo Salcedo on 25/06/14.
//  Copyright (c) 2014 JY DESENV. All rights reserved.
//

#import "JYAppDelegate.h"
#import "SCSQLite.h"

@implementation JYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [SCSQLite initWithDatabase:@"iejb.db"];
    //[self copyDatabaseFile];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void) copyDatabaseFile {
    BOOL success;
    NSFileManager *fileMAnager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSLog(@"document Directory:%@", documentDirectory);
    NSString *writableDBPath = [documentDirectory stringByAppendingPathComponent:@"iejb.db"];
    NSLog(@"Writable path:%@", writableDBPath);
    success = [fileMAnager fileExistsAtPath:writableDBPath];
    if (success) return;
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"iejb.db"];
    NSLog(@"default database path:%@", defaultDBPath);
    success = [fileMAnager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) NSAssert1(0,@"\failed to create writable database file with message'%@'.\"", [error localizedDescription]); }


@end
