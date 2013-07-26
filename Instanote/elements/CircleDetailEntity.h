//
//  CircleDetailEntity.h
//  Instanote
//
//  Created by CMD on 7/25/13.
//
//

#import "BaseEnity.h"
#import "CircleDetailImgsEntity.h"
#import "UsersEntity.h"

@interface CircleDetailEntity : BaseEnity
{
    NSMutableArray *circleDetailImg;
    NSString *circlecontent;
    NSString *circledetailid;
    NSString *circleid;
    int comcount;
    time_t createdatetime;
    NSString *ctag;
    NSString *def1;
    NSString *def2;
    NSString *def3;
    NSString *def4;
    int display;
    NSString *title;
    time_t updatedatetime;
    int userid;
    UsersEntity *userinfo;
}

@property(nonatomic, retain)NSMutableArray *circleDetailImg;
@property(nonatomic, retain)NSString *circlecontent;
@property(nonatomic, retain)NSString *circledetailid;
@property(nonatomic, retain)NSString *circleid;
@property(nonatomic, assign)int comcount;
@property(nonatomic, assign)time_t createdatetime;
@property(nonatomic, retain)NSString *ctag;
@property(nonatomic, retain)NSString *def1;
@property(nonatomic, retain)NSString *def2;
@property(nonatomic, retain)NSString *def3;
@property(nonatomic, retain)NSString *def4;
@property(nonatomic, assign)int display;
@property(nonatomic, retain)NSString *title;
@property(nonatomic, assign)time_t updatedatetime;
@property(nonatomic, assign)int userid;
@property(nonatomic, retain)UsersEntity *userinfo;


- (CircleDetailEntity *)initWithJsonDictionary:(NSDictionary *)dic;

+ (CircleDetailEntity *)entityWithJsonDictionary:(NSDictionary *)dic;
@end
