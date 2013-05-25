//
//  ResultUser.m
//  Instanote
//
//  Created by Man Tung on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultUser.h"
#import "NSDictionaryAdditions.h"
#import "SBJson.h"

@implementation ResultUser
@synthesize userkey,userid,userpass,userflag,useremail,usersource,userregisterdate, strregisterdate;

- (ResultUser *)initWithJsonDictionary:(NSDictionary *)dic
{
    self = [super self];
    if (self) {
        userid = [dic getIntValueForKey:@"userId" defaultValue:0];
        useremail = [dic getStringValueForKey:@"userEmail" defaultValue:@""];
        userflag = [dic getStringValueForKey:@"userFlag" defaultValue:@""];
        userkey = [dic getStringValueForKey:@"userKey" defaultValue:@""];
        userpass = [dic getStringValueForKey:@"userPass" defaultValue:@""];
        userregisterdate = [dic getStringValueForKey:@"userRegisterdate" defaultValue:@""];
        strregisterdate = [dic getStringValueForKey:@"strRegisterdate" defaultValue:@""];
    }
    return self;
}

+ (ResultUser *)resultUserWithJsonDictionary:(NSDictionary *)dic
{
    return [[[ResultUser alloc] initWithJsonDictionary:dic] autorelease];
}

- (ResultUser *)initWithJsonValue:(NSString *)value
{
    self = [super self];
    if (self) {
        //the json data contains illegal characters '()' that will be crash when parse to dictionary. 
        NSString *dtString = [NSString stringWithFormat:@"%@",value];
        
        NSLog(@"origal value %@", value);
        
        NSString *dt = [dtString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"("]];
        NSString *end = [dt stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@")"]];
//        NSString *dn = [dt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        self.deviceId = [dn stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSLog(@"operation %@", end);
        
        NSError *error = nil; 
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dicc = [parser objectWithString:end error:&error];
        [parser release];
        
        NSLog(@"%@", dicc);
        
        userid = [dicc getIntValueForKey:@"userId" defaultValue:0];
        useremail = [dicc getStringValueForKey:@"userEmail" defaultValue:@""];
        userflag = [dicc getStringValueForKey:@"userFlag" defaultValue:@""];
        userkey = [dicc getStringValueForKey:@"userKey" defaultValue:@""];
        userpass = [dicc getStringValueForKey:@"" defaultValue:@""];
        userregisterdate = [dicc getStringValueForKey:@"userRegisterdate" defaultValue:@""];
    }
    return self;
}

+ (ResultUser *)resultUserWithJsonValue:(NSString *)value
{
    return [[[ResultUser alloc] initWithJsonValue:value] autorelease];
}

@end
