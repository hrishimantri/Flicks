//
//  AppDelegate.m
//  Flicks
//
//  Created by Hrishi Mantri on 1/23/17.
//  Copyright © 2017 Yahoo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // Set up the first View Controller
    self.vc1 = [storyBoard instantiateViewControllerWithIdentifier:@"viewController"];
    //vc1.title = @"Top Movies";
    self.vc1.restorationIdentifier = @"topMovies";
    self.vc1.view.backgroundColor = [UIColor orangeColor];
    self.vc1.tabBarItem.title = @"Top Movies";
    self.vc1.tabBarItem.image = [UIImage imageNamed:@"top_rated.png"];
    
    //  Set background color for Navbar
    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:self.vc1];
    nc1.navigationBar.tintColor=[UIColor orangeColor];
    nc1.navigationBar.alpha = 0.7f;
    nc1.navigationBar.backgroundColor=[UIColor orangeColor];
    
    // Set up the second View Controller
    ViewController *vc2 = [storyBoard instantiateViewControllerWithIdentifier:@"viewController"];
    //vc2.title = @"Now Playing";
    vc2.restorationIdentifier = @"nowPlaying";
    vc2.view.backgroundColor = [UIColor orangeColor];
    vc2.tabBarItem.title = @"Now Playing";
    vc2.tabBarItem.image = [UIImage imageNamed:@"now_playing.png"];
    
    UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nc2.navigationBar.tintColor=[UIColor orangeColor];
    nc2.navigationBar.alpha = 0.7f;
    nc2.navigationBar.backgroundColor=[UIColor orangeColor];

    
    // Set up the Tab Bar Controller to have two tabs
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:@[nc2, nc1]];
    
    // Make the Tab Bar Controller the root view controller
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    
    
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

@end
