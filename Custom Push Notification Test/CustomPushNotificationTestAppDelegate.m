//
//  CustomPushNotificationTestAppDelegate.m
//  Custom Push Notification Test
//
//  Created by Renaud Tircher on 1/23/13.
//  Copyright (c) 2013 Renaud Tircher. All rights reserved.
//

#import "CustomPushNotificationTestAppDelegate.h"
#import "AFNetworking.h"

@implementation CustomPushNotificationTestAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application registerForRemoteNotificationTypes:
            (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    [self registerDeviceID:deviceToken forUserID: 123];
}

- (void)registerDeviceID:(NSData *)deviceToken forUserID:(NSInteger)userId {
    NSLog(@"Registering Device");
    NSString *stringToken = [self convertDeviceTokenToStringFrom:deviceToken];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: stringToken, @"token", nil];

    NSString *url = @"http://10.0.1.5:4567/";
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:url]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/users/123/registerDevice" parameters:params];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *theOperation, id responseObject) {
        NSLog(@"AFRequest is a success");
    } failure:^(AFHTTPRequestOperation *theOperation, NSError *error) {
        NSLog(@"AFRequest is a failure");
    }];

    [operation start];
}

-(NSString *)convertDeviceTokenToStringFrom:(NSData *)deviceToken {
    const unsigned char *buffer = (const unsigned char *)[deviceToken bytes];
    if (!buffer) {
        return nil;
    }
    NSMutableString *hex = [NSMutableString stringWithCapacity:(deviceToken.length * 2)];
    for (NSUInteger i = 0; i < deviceToken.length; i++) {
        [hex appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)buffer[i]]];
    }
    return [NSString stringWithString:hex];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Show alert for push notifications recevied while the app is running
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
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

@end
