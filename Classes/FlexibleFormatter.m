//
//  FlexibleFormatter.m
//  FlexiFormat
//
//  Created by Justin Clayden on 20/10/10.
//  Copyright 2010 Cool Fusion Multimedia. All rights reserved.
//

#import "FlexibleFormatter.h"


@implementation FlexibleFormatter

#pragma mark -
#pragma mark Setup

- (void) addRule:(NSInteger)rule_no withFormatter:(NSString *)formatter {
     
    if (!formats) formats = [[NSMutableDictionary alloc] init];
    
    // Construct the key
    NSString *rule_key = [NSString stringWithFormat:@"%d", rule_no];
    if (formatter) {
        [self.formats setObject:formatter forKey:rule_key];
    } else {
        // FAIL
    }
}


- (void) addRulesAndFormatters:(NSDictionary *)rules_and_formatters {
    
    if (!formats) formats = [[NSMutableDictionary alloc] init];
   
    [formats addEntriesFromDictionary:rules_and_formatters];
}


#pragma mark -
#pragma mark Formatting
- (NSString *) flexiblyFormattedString:(NSDictionary *)params {
 
    // Work out which params are missing
    
}

@synthesize formats;


@end
