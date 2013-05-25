//
//  ReturnSyncResults.h
//  Instanote
//
//  Created by Man Tung on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnSyncResults : NSObject
{
    int resultabstractnum;
    NSString * resulttip;
    NSString * resultabstractvalue;
    long long lastsynctime;
    NSString * clientsucessflag;
    NSString * serversucessflag;
    int resultinstanotenum;
    NSString * resultinstanotevalue;
    int resultflag;
}

@property(nonatomic, assign) int resultabstractnum;
@property(nonatomic, retain) NSString * resulttip;
@property(nonatomic, retain) NSString * resultabstractvalue;
@property(nonatomic, assign) long long lastsynctime;
@property(nonatomic, retain) NSString * clientsucessflag;
@property(nonatomic, retain) NSString * serversucessflag;
@property(nonatomic, assign) int resultinstanotenum;
@property(nonatomic, retain)  NSString * resultinstanotevalue;
@property(nonatomic, assign) int resultflag;


- (ReturnSyncResults *)initWithJsonDictionary:(NSDictionary*)dic;

+ (ReturnSyncResults *)ResultsWithJsonDictionary:(NSDictionary*)dic;

- (NSString *)initWithAbstractNum:(int)abstractnum 
                    AbstractValue:(NSString *)abstractvalue 
                    InstanoteNum:(int)instanotenum 
                    InstanoteValue:(NSString *)instanotevalue 
                    ResultTip:(NSString *)tip
                    LastSyncTime:(long long)ltime
                    ClientSucessFlag:(NSString *)clientsucess
                    ServerSucessFlag:(NSString *)serversucess
                    Flag:(int)flag;

- (NSString *)initJsonString;

@end
