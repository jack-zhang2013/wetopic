//
//  CircleCommentInfosEntity.h
//  Instanote
//
//  Created by Man Tung on 12/27/12.
//
//

#import <Foundation/Foundation.h>
#import "UsersEntity.h"
#import "BaseEnity.h"

@interface CircleCommentInfosEntity : BaseEnity
{
    NSString *ccid;
    NSString *circledetailid;
    NSString *commentinfo;
    time_t createdate;
//    NSString * createdate_String;
    NSString *def1;
    NSString *def2;
    NSString *def3;
    NSString *def4;
    NSString *def5;
    NSString *def6;
    NSString *def7;
    int ispktype;
    NSString *userid;
    UsersEntity *userinfo;
}

@property (nonatomic, retain)NSString *ccid;
@property (nonatomic, retain)NSString *circledetailid;
@property (nonatomic, retain)NSString *commentinfo;
@property (nonatomic, assign)time_t createdate;
//@property (nonatomic, retain)NSString * createdate_String;
@property (nonatomic, retain)NSString *def1;
@property (nonatomic, retain)NSString *def2;
@property (nonatomic, retain)NSString *def3;
@property (nonatomic, retain)NSString *def4;
@property (nonatomic, retain)NSString *def5;
@property (nonatomic, retain)NSString *def6;
@property (nonatomic, retain)NSString *def7;
@property (nonatomic, assign)int ispktype;
@property (nonatomic, retain)NSString *userid;
@property (nonatomic, retain)UsersEntity *userinfo;

- (CircleCommentInfosEntity *)initWithJsonDictionary:(NSDictionary *)dic;

+ (CircleCommentInfosEntity *)entityWithJsonDictionary:(NSDictionary *)dic;

@end
