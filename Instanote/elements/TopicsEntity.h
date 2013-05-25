//
//  TopicsEntity.h
//  Instanote
//
//  Created by Man Tung on 12/27/12.
//
//

#import <Foundation/Foundation.h>
#import "UsersEntity.h"
#import "CircleDetailImgsEntity.h"
#import "BaseEnity.h"

@interface TopicsEntity : BaseEnity
{
    NSMutableArray *circleCommentInfo;
    NSMutableArray *circleDetailImg;
    NSString *circlecontent;
    NSString *circledetailid;
    NSString *circleid;
    int comcount;
    time_t createdatetime;
//    NSString *createdatetime_String;
    NSString *ctag;
    NSString *def1;
    NSString *def2;
    NSString *def3;
    NSString *def4;
    int display;//0 equal delete
    NSString *gztopics;
    NSString *isgz;
    NSString *ispk;
    NSString *title;
    NSString *topicPks;
    time_t updatedatetime;
//    NSString *updatedatetime_String;
    NSString *userid;
    UsersEntity *userinfo;
    int visitcount;
}

@property (nonatomic, retain)NSMutableArray *circleCommentInfo;
@property (nonatomic, retain)NSMutableArray *circleDetailImg;
@property (nonatomic, retain)NSString *circlecontent;
@property (nonatomic, retain)NSString *circledetailid;
@property (nonatomic, retain)NSString *circleid;
@property (nonatomic, assign)int comcount;
@property (nonatomic, assign)time_t createdatetime;
//@property (nonatomic, retain)NSString *createdatetime_String;
@property (nonatomic, retain)NSString *ctag;
@property (nonatomic, retain)NSString *def1;
@property (nonatomic, retain)NSString *def2;
@property (nonatomic, retain)NSString *def3;
@property (nonatomic, retain)NSString *def4;
@property (nonatomic, assign)int display;//0 equal delete
@property (nonatomic, retain)NSString *gztopics;
@property (nonatomic, retain)NSString *isgz;
@property (nonatomic, retain)NSString *ispk;
@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *topicPks;
@property (nonatomic, assign)time_t updatedatetime;
//@property (nonatomic, assign)NSString *updatedatetimeString;
@property (nonatomic, retain)NSString *userid;
@property (nonatomic, retain)UsersEntity *userinfo;
@property (nonatomic, assign)int visitcount;

- (TopicsEntity *)initWithJsonDictionary:(NSDictionary *)dic;

+ (TopicsEntity *)entityWithJsonDictionary:(NSDictionary *)dic;

//- (NSString *)timestamp:(time_t )create_at;

@end
