//
//  ResultAbstractNote.h
//  Instanote
//
//  Created by CMD on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultAbstractNote : NSObject
{
    NSNumber * localNoteId;
    NSNumber * serverNoteId;
    NSNumber * localFlag;
    NSNumber * opFlag;
    NSNumber * noteType;
    NSDate * lastUpdateTime;
    NSString * strLastUpdateTime;
}

@property (nonatomic, retain) NSNumber * localNoteId;
@property (nonatomic, retain) NSNumber * serverNoteId;
@property (nonatomic, retain) NSNumber * localFlag;
@property (nonatomic, retain) NSNumber * opFlag;
@property (nonatomic, retain) NSNumber * noteType;
@property (nonatomic, retain) NSDate * lastUpdateTime;
@property (nonatomic, retain) NSString * strLastUpdateTime;


- (ResultAbstractNote *)initWithJsonDictionary:(NSDictionary*)dic;

+ (ResultAbstractNote *)ResultsWithJsonDictionary:(NSDictionary*)dic;

- (ResultAbstractNote *)initWithJsonValue:(NSString *)value;

+ (ResultAbstractNote *)ResultsWithJsonValue:(NSString *)value;

@end
