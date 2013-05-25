//
//  ResultNote.h
//  Instanote
//
//  Created by CMD on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultNote : NSObject
{
    NSDate * _noteDate;
    NSNumber * _noteId;
    NSString * _noteInfo;
    NSDate * _noteLastdate;
    NSNumber * _noteSource;
    NSNumber * _noteUserid;
    NSString * _strNotedate;
    NSString * _strNoteLastdate;
    
    //local
    NSNumber * noteType;
    NSNumber * noteLocalId;
    NSNumber * local_flag;
    NSNumber * op_log;
}

@property (nonatomic, assign) NSDate * _noteDate;
@property (nonatomic, retain) NSNumber * _noteId;
@property (nonatomic, retain) NSString * _noteInfo;
@property (nonatomic, assign) NSDate * _noteLastdate;
@property (nonatomic, retain) NSNumber * _noteSource;
@property (nonatomic, retain) NSNumber * _noteUserid;
@property (nonatomic, retain) NSString * _strNotedate;
@property (nonatomic, retain) NSString * _strNoteLastdate;

//local
@property (nonatomic, retain) NSNumber * noteType;
@property (nonatomic, retain) NSNumber * noteLocalId;
@property (nonatomic, retain) NSNumber * local_flag;
@property (nonatomic, retain) NSNumber * op_log;

- (ResultNote *)initWithJsonDictionary:(NSDictionary*)dic;

+ (ResultNote *)ResultsWithJsonDictionary:(NSDictionary*)dic;

- (ResultNote *)initWithJsonValue:(NSString *)value;

+ (ResultNote *)ResultsWithJsonValue:(NSString *)value;

@end
