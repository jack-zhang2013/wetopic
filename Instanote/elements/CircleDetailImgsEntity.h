//
//  CircleDetailImgsEntity.h
//  Instanote
//
//  Created by Man Tung on 12/27/12.
//
//

#import <Foundation/Foundation.h>
#import "BaseEnity.h"

@interface CircleDetailImgsEntity : BaseEnity
{
    NSString *bigimg;
    NSString *cdid;
    NSString *circledetailid;
    NSString *def1;
    NSString *def2;
    NSString *middleimg;
    NSString *smalling;
    time_t uploadtime;
}

@property (nonatomic, retain)NSString *bigimg;
@property (nonatomic, retain)NSString *cdid;
@property (nonatomic, retain)NSString *circledetailid;
@property (nonatomic, retain)NSString *def1;
@property (nonatomic, retain)NSString *def2;
@property (nonatomic, retain)NSString *middleimg;
@property (nonatomic, retain)NSString *smalling;
@property (nonatomic, assign)time_t uploadtime;

- (CircleDetailImgsEntity *)initWithJsonDictionary:(NSDictionary *)dic;

+ (CircleDetailImgsEntity *)entityWithJsonDictionary:(NSDictionary *)dic;

@end
