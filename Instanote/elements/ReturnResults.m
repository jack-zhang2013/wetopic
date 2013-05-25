//
//  ReturnResults.m
//  Instanote
//
//  Created by Man Tung on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReturnResults.h"
#import "NSDictionaryAdditions.h"
#import "SBJson.h"
#import "ResultUser.h"
#import "ResultNote.h"

@implementation ReturnResults
@synthesize num;
@synthesize flag;
@synthesize tip;
@synthesize data;
@synthesize instanotedata;
@synthesize abstractdata;
@synthesize clientsucessflag;
@synthesize serversucessflag;
//@synthesize userkey,userid,userpass,userflag,useremail,usersource,userregisterdate;


#define RESULTFLAG @"resultflag"
#define RESULTNUM @"resultnum"
#define RESULTTIP @"resulttip"
#define RESULTVALUE @"resultvalue"
#define RESULTABSTRACTVALUE @"resultabstractvalue"
#define CLIENTSUCESSFLAG @"clientsucessflag"
#define SERVERSUCESSFLAG @"serversucessflag"
#define RESULTINSTANOTEVALUE @"resultinstanotevalue"

- (ReturnResults *)initWithJsonDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        //default status is?
        flag = [dictionary getIntValueForKey:RESULTFLAG defaultValue:0];
        num = [dictionary getIntValueForKey:RESULTNUM defaultValue:0];
        tip = [dictionary getStringValueForKey:RESULTTIP defaultValue:@"no message"];
        data = [dictionary getStringValueForKey:RESULTVALUE defaultValue:@"errorNULL"];
        instanotedata = [dictionary getStringValueForKey:RESULTINSTANOTEVALUE defaultValue:@"errorNULL"];
        abstractdata = [dictionary getStringValueForKey:RESULTABSTRACTVALUE defaultValue:@"errorNULL"];
        clientsucessflag = [dictionary getStringValueForKey:CLIENTSUCESSFLAG defaultValue:@"F"];//F false T true
        serversucessflag = [dictionary getStringValueForKey:SERVERSUCESSFLAG defaultValue:@"F"];//F false T true
    }
    return self;
}

+ (ReturnResults *)ResultsWithJsonDictionary:(NSDictionary *)dic
{
    return [[[ReturnResults alloc] initWithJsonDictionary:dic] autorelease];
}


- (ReturnResults *)initWithJsonValue:(NSString *)value
{
    self = [super init];
    if (self) {
        
        NSRange range = [value rangeOfString:@"["];//匹配得到的下标
        NSString * beginrang = [value substringWithRange:range];//截取范围类的字符串
        
        NSLog(@"%@", beginrang);
        
        NSError *error = nil; 
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dictionary = [parser objectWithString:value error:&error]; 
        [parser release];
        NSLog(@"%@", value);
        flag = [dictionary getIntValueForKey:RESULTFLAG defaultValue:0];
        num = [dictionary getIntValueForKey:RESULTNUM defaultValue:0];
        tip = [[dictionary getStringValueForKey:RESULTTIP defaultValue:@"Nothing happend!"] retain];
        //data = [dictionary getStringValueForKey:RESULTVALUE defaultValue:@""];
//        NSDictionary * d = (NSDictionary *)[dictionary objectForKey:RESULTVALUE];
//        NSLog(@"--------------------------------%@", d);
//        NSLog(@"%@", [d objectForKey:@"userEmail"]);
        
    }
    return self;
}

+ (ReturnResults *)ResultsWithJsonValue:(NSString *)value
{
    return [[[ReturnResults alloc] initWithJsonValue:value] autorelease];
}

- (void)dealloc
{
    [tip release];
    [data release];
//    [useremail release];
//    [userflag release];
//    [userkey release];
//    [userpass release];
//    [userregisterdate release];
//    [usersource release];
    [super dealloc];
}

@end
