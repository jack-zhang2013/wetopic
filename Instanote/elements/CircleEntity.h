//
//  CircleEntity.h
//  Instanote
//
//  Created by CMD on 7/24/13.
//
//

#import <Foundation/Foundation.h>
#import "UsersEntity.h"

@interface CircleEntity : BaseEnity
{
    NSString *circlebigimg;
    NSString *circleid;
    NSString *circlemiddleimg;
    NSString *circlename;
    NSString *circlesmallimg;
    NSString *circletag;
    int comcount;
    time_t createdatetime;
    int csort;
    NSString *def1;
    NSString *def2;
    NSString *def3;
    NSString *def4;
    int display;//3
    //    int isjoin;
    int istop;
    int joincount;
    NSString *summary;
    time_t updatedatetime;
    int userid;
    UsersEntity *userinfo;
}

@property (nonatomic, retain)NSString *circlebigimg;
@property (nonatomic, retain)NSString *circleid;
@property (nonatomic, retain)NSString *circlemiddleimg;
@property (nonatomic, retain)NSString *circlename;
@property (nonatomic, retain)NSString *circlesmallimg;
@property (nonatomic, retain)NSString *circletag;
@property (nonatomic, assign)int comcount;
@property (nonatomic, assign)time_t createdatetime;
@property (nonatomic, assign)int csort;
@property (nonatomic, retain)NSString *def1;
@property (nonatomic, retain)NSString *def2;
@property (nonatomic, retain)NSString *def3;
@property (nonatomic, retain)NSString *def4;
@property (nonatomic, assign)int display;//3
//@property (nonatomic, retain)int isjoin;
@property (nonatomic, assign)int istop;
@property (nonatomic, assign)int joincount;
@property (nonatomic, retain)NSString *summary;
@property (nonatomic, assign)time_t updatedatetime;
@property (nonatomic, assign)int userid;
@property (nonatomic, retain)UsersEntity *userinfo;

- (CircleEntity *)initWithJsonDictionary:(NSDictionary *)dic;

+ (CircleEntity *)entityWithJsonDictionary:(NSDictionary *)dic;


@end
