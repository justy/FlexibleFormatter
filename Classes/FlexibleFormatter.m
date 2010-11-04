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

/*!
 \brief initWithFile - create an instance of a FlexibleFormatter using a plist!
 \param file_name a string representing the name of the plist (minus '.plist' to be found in the main application bundle) to use to provide the rules/formatters
 
 */
- (id) initWithFile:(NSString *)file_name {
    
    if ((self = [super init])) {
        // Custom initialization
    }
   
 
    NSString *file_path = [[NSBundle mainBundle] pathForResource:file_name ofType:@"plist"];
    NSURL *file_url = [NSURL fileURLWithPath:file_path];
    self.formats = [[NSDictionary alloc] initWithContentsOfURL:file_url];
    if (!self.formats) {
        NSLog(@"Invalid format file");
    }
    
     return self;
    
}

/**
 Add a formatting rule for an array of present/absent parameters
 */
- (void) addRuleForArray:(NSArray *)params withFormatter:(NSString *)formatter {
    [self addRule:[self keyForParameters:params] withFormatter:formatter];
}

/**
 Add a formatting rule for an explicit rule key
 */
- (void) addRule:(NSString *)rule_key withFormatter:(NSString *)formatter {
    
    if (!formats) formats = [[NSMutableDictionary alloc] init];
    if (rule_key && formatter) {
        [self.formats setObject:formatter forKey:rule_key];
    } else {
        // FAIL
    }
}

/**
 Bulk add rules and formatters, sourced from a dictionary
 */
- (void) addRulesAndFormatters:(NSDictionary *)rules_and_formatters {
    
    if (!formats) formats = [[NSMutableDictionary alloc] init];
   
    [formats addEntriesFromDictionary:rules_and_formatters];
}


#pragma mark -
#pragma mark Formatting

/**
 Return a felxibly formatted string, based on an array of string parameters, some of which may be nil.
 
 */
- (NSString *) flexiblyFormattedString:(NSArray *)params {
 
    // Work out which params are missing
    // By convention, it's an array of NSStrings; anything else is considered missing.
    
    // Convert this binary rep to an integer
    NSString *rule_key = [self keyForParameters:params];
   
    // Lookup the formatter
    NSString *formatter = [formats objectForKey:rule_key];
    
    // Collapse the parameters
    NSArray *collapsed_params = [self collapseParameters:params];
    
    char *argList = (char *)malloc(sizeof(NSString *) * [collapsed_params count]);
    [collapsed_params getObjects:(id *)argList];
    
    NSString *result = [[NSString alloc] initWithFormat:formatter arguments: argList];
    
    free(argList);
    
    return result;
}

#pragma mark -
#pragma mark Util
/**
 Return a binary (as string) representation of the present/absent parameters
 */
- (NSString *) keyForParameters:(NSArray *)params {
    
    // Based on the present / missing params, construct a string like so: @"0011010010"
    NSMutableString *rule_key = [[NSMutableString alloc] init];
    for (NSInteger i=0; i<[params count]; i++) {
        
        if ([[params objectAtIndex:i] isKindOfClass:[NSString class]]) {
            [rule_key appendString:@"1"];
        } else {
            [rule_key appendString:@"0"];
        }
        
    }
    
    return rule_key;
}

/**
 Return the number of non-absent parameters
 */
- (NSInteger) numberOfPresentParameters:(NSArray *)params {
    
    NSInteger num_params = 0;
    for (NSInteger i=0; i<[params count]; i++) {
        
        if ([[params objectAtIndex:i] isKindOfClass:[NSString class]]) {
            num_params++;
        } 
        
    }
    
    return num_params;
}

/**
 Return an array constructed from the parameters that are non-absent
 */
- (NSArray*) collapseParameters:(NSArray *)params {
    
    NSMutableArray *t_array = [[NSMutableArray alloc] init];
    for (id obj in params) {
        if ([obj isKindOfClass:[NSString class]]) {
            [t_array addObject:obj];
        }
    }
    NSArray *return_array = [[NSArray alloc] initWithArray:t_array];
    [t_array release];
    return return_array;
    
}

@synthesize formats;


@end
