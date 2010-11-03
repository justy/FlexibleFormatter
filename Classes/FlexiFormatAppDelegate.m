//
//  FlexiFormatAppDelegate.m
//  FlexiFormat
//
//  Created by Justin Clayden on 20/10/10.
//  Copyright 2010 Cool Fusion Multimedia. All rights reserved.
//

#import "FlexiFormatAppDelegate.h"
#import "FlexiFormatViewController.h"

#import "FlexibleFormatter.h"

@implementation FlexiFormatAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    // Add the view controller's view to the window and display.
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
    
    FlexibleFormatter *street_formatter = [[FlexibleFormatter alloc] initWithFile:@"Street_Formatter"];
    FlexibleFormatter *suburb_formatter = [[FlexibleFormatter alloc] initWithFile:@"Suburb_Formatter"];
    FlexibleFormatter *address_formatter = [[FlexibleFormatter alloc] initWithFile:@"Address_Formatter"];
    
    
    // Test it out
    for (NSInteger i=0; i<100; i++) {
        
        NSMutableArray *street_params = [[NSMutableArray alloc] initWithObjects:@"2",@"42",@"Restful St",nil];
        NSMutableArray *suburb_params = [[NSMutableArray alloc] initWithObjects:@"Restburg",@"TAS",@"7332",nil];
        
        // Knock out a random # of params from random locations
        NSInteger num_to_remove = arc4random()%[street_params count];
        for (NSInteger r=0; r<num_to_remove; r++) {
            NSInteger index_to_remove = arc4random()%[street_params count];
            [street_params replaceObjectAtIndex:index_to_remove withObject:[NSNull null]];
        }
        
        num_to_remove = arc4random()%[suburb_params count];
        for (NSInteger r=0; r<num_to_remove; r++) {
            NSInteger index_to_remove = arc4random()%[suburb_params count];
            [suburb_params replaceObjectAtIndex:index_to_remove withObject:[NSNull null]];
        }
        
        NSString *formatted_street = [street_formatter flexiblyFormattedString:street_params];
        NSString *formatted_suburb = [suburb_formatter flexiblyFormattedString:suburb_params];
        
        NSMutableArray *address_params = [[NSMutableArray alloc] init];
        if ([formatted_street length] > 0) {
            [address_params addObject:formatted_street];
        } else {
            [address_params addObject:[NSNull null]];
        }
        
        if ([formatted_suburb length] > 0) {
            [address_params addObject:formatted_suburb];
        } else {
            [address_params addObject:[NSNull null]];
        }
        
        
        NSLog(@"Flexibly formatted: %@", [address_formatter flexiblyFormattedString:address_params]);
        [street_params release];
        [suburb_params release];
        [address_params release];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
