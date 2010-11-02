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

- (void) addRuleForArray:(NSArray *)params withFormatter:(NSString *)formatter {
    [self addRule:[self keyForParameters:params] withFormatter:formatter];
}


- (void) addRule:(NSString *)rule_key withFormatter:(NSString *)formatter {
    
    if (!formats) formats = [[NSMutableDictionary alloc] init];
    if (rule_key && formatter) {
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
- (NSString *) flexiblyFormattedString:(NSArray *)params {
 
    // Work out which params are missing
    // By convention, it's an array of NSStrings; anything else is considered missing.
    
    // Convert this binary rep to an integer
    NSString *rule_key = [self keyForParameters:params];
    //NSInteger number_of_present_parameters = [self numberOfPresentParameters:params];
   
    // Lookup the formatter
    NSString *formatter = [formats objectForKey:rule_key];
    
    // Collapse the parameters
    NSArray *collapsed_params = [self collapseParameters:params];
    
    char *argList = (char *)malloc(sizeof(NSString *) * [collapsed_params count]);
    [collapsed_params getObjects:(id *)argList];
    
    NSString *result = [[NSString alloc] initWithFormat:formatter arguments: argList];
    
    free(argList);
    
    return result;

  //  NSAttributedString *s = [[NSAttributedString alloc] initWithString:@"Justy Rocks"];
    
    

}

#pragma mark -
#pragma mark Util
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

- (NSInteger) numberOfPresentParameters:(NSArray *)params {
    
    NSInteger num_params = 0;
    for (NSInteger i=0; i<[params count]; i++) {
        
        if ([[params objectAtIndex:i] isKindOfClass:[NSString class]]) {
            num_params++;
        } 
        
    }
    
    return num_params;
}

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
