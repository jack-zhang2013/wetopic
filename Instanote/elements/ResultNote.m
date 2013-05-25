//
//  ResultNote.m
//  Instanote
//
//  Created by CMD on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultNote.h"
#import "NSDictionaryAdditions.h"
#import "SBJson.h"

@implementation ResultNote

@synthesize _noteDate;
@synthesize _noteId;
@synthesize _noteInfo;
@synthesize _noteLastdate;
@synthesize _noteSource;
@synthesize _noteUserid;
@synthesize _strNotedate;
@synthesize _strNoteLastdate;

//local
@synthesize noteType;
@synthesize noteLocalId;
@synthesize local_flag;
@synthesize op_log;

#define NOTEDATE @"noteDate"
#define NOTEID @"noteId"
#define NOTEINFO @"noteInfo"
#define NOTELASTDATE @"noteLastdate"
#define NOTESOURCE @"noteSource"
#define NOTEUSERID @"noteUserid"
#define STRNOTEDATE @"strNoteDate"
#define STRNOTELASTDATE @"strNoteLastdate"
#define OPTFLAG @"optFlag"
#define LOCALFLAG @"localFlag"


- (ResultNote *)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        _noteDate = [[NSDate alloc] initWithTimeIntervalSince1970:([dic getLongLongValueValueForKey:NOTEDATE defaultValue:0.f] / 1000)];
        _noteId = [NSNumber numberWithInt:([dic getIntValueForKey:NOTEID defaultValue:0])];
        _noteInfo = [[dic getStringValueForKey:NOTEINFO defaultValue:@"NULL"] retain];
        _noteLastdate = [[NSDate alloc] initWithTimeIntervalSince1970:([dic getLongLongValueValueForKey:NOTELASTDATE defaultValue:0] / 1000)];
        _noteSource = [NSNumber numberWithInt:([dic getIntValueForKey:NOTESOURCE defaultValue:0])];
        //NSLog(@"source %@ and json source is %d", _noteSource, [dic getIntValueForKey:NOTESOURCE defaultValue:0]);
        _noteUserid = [NSNumber numberWithInt:([dic getIntValueForKey:NOTEUSERID defaultValue:0])];
        _strNotedate = [dic getStringValueForKey:STRNOTEDATE defaultValue:@""];
        _strNoteLastdate = [dic getStringValueForKey:STRNOTELASTDATE defaultValue:@""];
        _noteUserid = [NSNumber numberWithInt:[dic getIntValueForKey:NOTEUSERID defaultValue:0]];
        op_log = [NSNumber numberWithInt:[dic getIntValueForKey:OPTFLAG defaultValue:0]];
        local_flag = [NSNumber numberWithInt:[dic getIntValueForKey:LOCALFLAG defaultValue:0]];
    }
    return self;
}


//- (time_t)convertTimeStamp:(NSString *)stringTime
//{
//    time_t createdAt;
//    struct tm created;
//    time_t now;
//    time(&now);     
//    if (stringTime) {
//        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
//            strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
//        }
//        createdAt = mktime(&created);
//    }
//    return createdAt;
//}


+ (ResultNote *)ResultsWithJsonDictionary:(NSDictionary*)dic
{
    return [[[ResultNote alloc] initWithJsonDictionary:dic] autorelease];
}

- (ResultNote *)initWithJsonValue:(NSString *)value
{
    return nil;
}

+ (ResultNote *)ResultsWithJsonValue:(NSString *)value
{
    return [[[ResultNote alloc] initWithJsonValue:value] autorelease];
}

@end
