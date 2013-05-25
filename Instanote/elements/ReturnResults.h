//
//  ReturnResults.h
//  Instanote
//
//  Created by Man Tung on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnResults : NSObject {
    int flag;
    int num;
    NSString * tip;
    NSString * data;
    NSString * instanotedata;
    NSString * abstractdata;
    
    //flags
    NSString * clientsucessflag;
    NSString * serversucessflag;
}

@property (nonatomic, assign)int flag;
@property (nonatomic, assign)int num;
@property (nonatomic, retain)NSString * tip;
@property (nonatomic, retain)NSString * data;
@property (nonatomic, retain)NSString * instanotedata;
@property (nonatomic, retain)NSString * abstractdata;
@property (nonatomic, retain)NSString * clientsucessflag;
@property (nonatomic, retain)NSString * serversucessflag;

- (ReturnResults *)initWithJsonDictionary:(NSDictionary*)dic;

+ (ReturnResults*)ResultsWithJsonDictionary:(NSDictionary*)dic;

- (ReturnResults *)initWithJsonValue:(NSString *)value;

+ (ReturnResults *)ResultsWithJsonValue:(NSString *)value;

@end
