//
//  ResultAbstractNote.m
//  Instanote
//
//  Created by CMD on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultAbstractNote.h"
#import "NSDictionaryAdditions.h"
//#import "SBJson.h"

@implementation ResultAbstractNote

@synthesize localNoteId, serverNoteId, localFlag, opFlag, noteType, lastUpdateTime, strLastUpdateTime;


- (ResultAbstractNote *)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        localNoteId = [NSNumber numberWithInt:[dic getIntValueForKey:@"localnoteid" defaultValue:-1]];
        serverNoteId = [NSNumber numberWithInt:[dic getIntValueForKey:@"servernoteid" defaultValue:-1]];
        localFlag = [NSNumber numberWithInt:[dic getIntValueForKey:@"localflag" defaultValue:-1]];
        opFlag = [NSNumber numberWithInt:[dic getIntValueForKey:@"opflag" defaultValue:-1]];
        noteType = [NSNumber numberWithInt:[dic getIntValueForKey:@"notetype" defaultValue:-1]];
        lastUpdateTime = [NSDate dateWithTimeIntervalSince1970:[dic getIntValueForKey:@"lastupdatetime" defaultValue:0]];
        strLastUpdateTime = [dic getStringValueForKey:@"strlastupdatetime" defaultValue:@""];
    }
    return self;
}

+ (ResultAbstractNote *)ResultsWithJsonDictionary:(NSDictionary*)dic
{
    return [[[ResultAbstractNote alloc] initWithJsonDictionary:dic] autorelease];
}

- (ResultAbstractNote *)initWithJsonValue:(NSString *)value
{
    return nil;
}

+ (ResultAbstractNote *)ResultsWithJsonValue:(NSString *)value
{
    return [[[ResultAbstractNote alloc] initWithJsonValue:value] autorelease];
}

@end
