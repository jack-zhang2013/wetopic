//
//  ReturnSyncResults.m
//  Instanote
//
//  Created by Man Tung on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReturnSyncResults.h"
#import "NSDictionaryAdditions.h"

@implementation ReturnSyncResults

@synthesize resultabstractnum;
@synthesize resulttip;
@synthesize resultabstractvalue;
@synthesize lastsynctime;
@synthesize clientsucessflag;
@synthesize serversucessflag;
@synthesize resultinstanotenum;
@synthesize resultinstanotevalue;
@synthesize resultflag;


- (ReturnSyncResults *)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        clientsucessflag = [dic getStringValueForKey:@"clientsucessflag" defaultValue:@"F"];//F false T true
        serversucessflag = [dic getStringValueForKey:@"serversucessflag" defaultValue:@"F"];//F false T true
        
        resultabstractnum = [dic getIntValueForKey:@"resultabstractnum" defaultValue:0];
        if (resultabstractnum == 0) {
            resultabstractvalue = @"[]";
        } else {
            resultabstractvalue = [dic getStringValueForKey:@"resultabstractvalue" defaultValue:@"errorNULL"];
        }
        resulttip = [dic getStringValueForKey:@"resulttip" defaultValue:@"no message"];
        lastsynctime = [dic getLongLongValueValueForKey:@"lastsynctime" defaultValue:0];
        
        resultinstanotenum = [dic getIntValueForKey:@"resultinstanotenum" defaultValue:0];
        if (resultinstanotenum == 0) {
            resultinstanotevalue = @"[]";
        } else {
            resultinstanotevalue = [dic getStringValueForKey:@"resultinstanotevalue" defaultValue:@"errorNULL"];
        }
        
        resultflag = [dic getIntValueForKey:@"resultflag" defaultValue:0];
        
    }
    return self;
}

+ (ReturnSyncResults *)ResultsWithJsonDictionary:(NSDictionary*)dic
{
    return [[[ReturnSyncResults alloc] initWithJsonDictionary:dic] autorelease];
}

- (NSString *)initWithAbstractNum:(int)abstractnum 
                    AbstractValue:(NSString *)abstractvalue 
                     InstanoteNum:(int)instanotenum 
                   InstanoteValue:(NSString *)instanotevalue 
                        ResultTip:(NSString *)tip
                     LastSyncTime:(long long)ltime
                 ClientSucessFlag:(NSString *)clientsucess
                 ServerSucessFlag:(NSString *)serversucess
                             Flag:(int)flag
{
    NSMutableString * jsondata = [[NSMutableString alloc] init];
    
    [jsondata appendString:@"{"];
        [jsondata appendFormat:@"\"resultflag\": \"%d\",", flag];
        [jsondata appendFormat:@"\"resultinstanotenum\": \"%d\",", instanotenum];
        [jsondata appendFormat:@"\"resultabstractvalue\": [%@],", abstractvalue];
        [jsondata appendFormat:@"\"resulttip\": \"%@\",", tip];
        [jsondata appendFormat:@"\"clientsucessflag\": \"%@\",", clientsucess];
        [jsondata appendFormat:@"\"serversucessflag\": \"%@\",", serversucess];
        [jsondata appendFormat:@"\"resultabstractnum\": \"%d\",", abstractnum];
        [jsondata appendFormat:@"\"resultinstanotevalue\": [%@],", instanotevalue];
        [jsondata appendFormat:@"\"lastsynctime\": \"%lld\"", ltime];
    [jsondata appendString:@"}"];
    return jsondata;
}

- (NSString *)initJsonString
{
    NSMutableString * jsondata = [[NSMutableString alloc] init];
    [jsondata appendString:@"{"];
        [jsondata appendFormat:@"\"resultflag\": \"%d\",", resultflag];
        [jsondata appendFormat:@"\"resultinstanotenum\": \"%d\",", resultinstanotenum];
        [jsondata appendFormat:@"\"resultabstractvalue\": [%@],", resultabstractvalue];
        [jsondata appendFormat:@"\"resulttip\": \"%@\",", resulttip];
        [jsondata appendFormat:@"\"clientsucessflag\": \"%@\",", clientsucessflag];
        [jsondata appendFormat:@"\"serversucessflag\": \"%@\",", serversucessflag];
        [jsondata appendFormat:@"\"resultabstractnum\": \"%d\",", resultabstractnum];
        [jsondata appendFormat:@"\"resultinstanotevalue\": [%@],", resultinstanotevalue];
        [jsondata appendFormat:@"\"lastsynctime\": \"%lld\"", self.lastsynctime];
    [jsondata appendString:@"}"];
    return jsondata;
}



@end
