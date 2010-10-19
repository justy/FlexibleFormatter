//
//  FlexiFormatAppDelegate.h
//  FlexiFormat
//
//  Created by Justin Clayden on 20/10/10.
//  Copyright 2010 Cool Fusion Multimedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlexiFormatViewController;

@interface FlexiFormatAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FlexiFormatViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FlexiFormatViewController *viewController;

@end

