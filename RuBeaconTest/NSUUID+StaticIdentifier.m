//
//  NSUUID+StaticIdentifier.m
//  Gandapas
//
//  Created by Maxim Gubin on 22.05.14.
//  Copyright (c) 2014 Andrey Vasilev. All rights reserved.
//

#import "NSUUID+StaticIdentifier.h"


@implementation NSUUID (StaticIdentifier)

+ (NSString*)staticUUID{
    
    
    
    NSString* serviceName = [[[NSBundle mainBundle] infoDictionary]  objectForKey:@"CFBundleExecutable"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    NSString *retrieveuuid = [defaults objectForKey:serviceName];
    
    if (retrieveuuid == nil) { // if this is the first time app lunching , create key for device
        retrieveuuid  = [[self UUID] UUIDString];
        
        retrieveuuid = [retrieveuuid stringByReplacingOccurrencesOfString:@"0" withString:@"O"];
        
        retrieveuuid = [retrieveuuid stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        [defaults setObject:retrieveuuid forKey:serviceName];
        
        [defaults synchronize];
        // save newly created key to Keychain
        
        // this is the one time process
    }
    
    return retrieveuuid;
}

@end
