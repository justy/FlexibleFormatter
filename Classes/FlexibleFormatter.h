//
//  FlexibleFormatter.h
//  FlexiFormat
//
//  Created by Justin Clayden on 20/10/10.
//  Copyright 2010 Cool Fusion Multimedia. All rights reserved.
//

// Allows the graceful handling of any of 2^n combinations of present/missing parameters to be formatted.
// Rule -> Format
// Rules may be exhaustively enumerated (i.e. the counting set of possible combinations)
// Rules may also be specified as a tree; partitioning the possible combinations

#import <Foundation/Foundation.h>


@interface FlexibleFormatter : NSObject {
    
    NSMutableDictionary *formats;               // @"enumerated_combo" : @"%@/%@ %@, %@ %@"

}

@property (nonatomic, retain) NSMutableDictionary *formats;


#pragma mark -
#pragma mark Setup
- (void) addRule:(NSInteger)rule_no withFormatter:(NSString *)formatter;
- (void) addRulesAndFormatters:(NSDictionary *)rules_and_formatters;

#pragma mark -
#pragma mark Formatting
- (NSString *) flexiblyFormattedString:(NSDictionary *)params;

@end
