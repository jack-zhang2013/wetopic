//
//  ResultUser.h
//  Instanote
//
//  Created by Man Tung on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultUser : NSObject{
    NSString * userkey;
    NSString * userpass;
    NSString * userregisterdate;
    NSString * usersource;
    NSString * userflag;
    int userid;
    NSString * useremail;
    NSString * strregisterdate;
}

@property (nonatomic, assign)int userid;
@property (nonatomic, retain)NSString * userkey;
@property (nonatomic, retain)NSString * userpass;
@property (nonatomic, retain)NSString * userregisterdate;
@property (nonatomic, retain)NSString * usersource;
@property (nonatomic, retain)NSString * userflag;
@property (nonatomic, retain)NSString * useremail;
@property (nonatomic, retain)NSString * strregisterdate;

- (ResultUser *)initWithJsonDictionary:(NSDictionary *)dic;

+ (ResultUser *)resultUserWithJsonDictionary:(NSDictionary *)dic;

- (ResultUser *)initWithJsonValue:(NSString *)value;

+ (ResultUser *)resultUserWithJsonValue:(NSString *)value;

@end
