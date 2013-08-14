//
//  CircleDetailEntity.m
//  Instanote
//
//  Created by CMD on 7/25/13.
//
//

#import "CircleDetailEntity.h"
#import "NSDictionaryAdditions.h"

@implementation CircleDetailEntity

@synthesize circleDetailImg;
@synthesize circlecontent;
@synthesize circledetailid;
@synthesize circleid;
@synthesize comcount;
@synthesize createdatetime;
@synthesize ctag;
@synthesize def1;
@synthesize def2;
@synthesize def3;
@synthesize def4;
@synthesize display;
@synthesize title;
@synthesize updatedatetime;
@synthesize userid;
@synthesize userinfo;

- (CircleDetailEntity *)initWithJsonDictionary:(NSDictionary *)dic
{
    self = [super self];
    if (self) {
        NSDictionary *imgDic = [[dic objectForKey:@"circleDetailImg"] retain];
        
        circleDetailImg = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary * imgdetial in imgDic) {
            if (![imgdetial isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            CircleDetailImgsEntity * cdi = [CircleDetailImgsEntity entityWithJsonDictionary:imgdetial];
            [circleDetailImg addObject:cdi];
        }
        circlecontent = [[dic getStringValueForKey:@"circlecontent" defaultValue:@""] retain];
        circledetailid = [[dic getStringValueForKey:@"circledetailid" defaultValue:@""] retain];
        circleid = [[dic getStringValueForKey:@"circleid" defaultValue:@""] retain];
        comcount = [dic getIntValueForKey:@"comcount" defaultValue:0];
        createdatetime = [dic getTimeValueForKey:@"createdatetime" defaultValue:0];
        ctag = [[dic getStringValueForKey:@"circletag" defaultValue:@""] retain];
        def1 = [[dic getStringValueForKey:@"def1" defaultValue:@""] retain];
        def2 = [[dic getStringValueForKey:@"def2" defaultValue:@""] retain];
        def3 = [[dic getStringValueForKey:@"def3" defaultValue:@""] retain];
        def4 = [[dic getStringValueForKey:@"def4" defaultValue:@""] retain];
        display = [dic getIntValueForKey:@"display" defaultValue:0];
        title = [[dic getStringValueForKey:@"title" defaultValue:@""] retain];
        updatedatetime = [dic getTimeValueForKey:@"updatedatetime" defaultValue:0];
        userid = [dic getIntValueForKey:@"userid" defaultValue:0];
        NSDictionary *userinfoDic = [dic objectForKey:@"userinfo"];
        if ([userinfoDic isKindOfClass:[NSDictionary class]]) {
            userinfo = [[UsersEntity entityWithJsonDictionary:userinfoDic] retain];
        }
        
    }
    return self;
}

+ (CircleDetailEntity *)entityWithJsonDictionary:(NSDictionary *)dic
{
    return [[[CircleDetailEntity alloc] initWithJsonDictionary:dic] autorelease];
}


@end
