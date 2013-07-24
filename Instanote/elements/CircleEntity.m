//
//  CircleEntity.m
//  Instanote
//
//  Created by CMD on 7/24/13.
//
//

#import "CircleEntity.h"
#import "NSDictionaryAdditions.h"

@implementation CircleEntity

@synthesize circlebigimg;
@synthesize circleid;
@synthesize circlemiddleimg;
@synthesize circlename;
@synthesize circlesmallimg;
@synthesize circletag;
@synthesize comcount;
@synthesize createdatetime;
@synthesize csort;
@synthesize def1;
@synthesize def2;
@synthesize def3;
@synthesize def4;
@synthesize display;//3
//@synthesize int isjoin;
@synthesize istop;
@synthesize joincount;
@synthesize summary;
@synthesize updatedatetime;
@synthesize userid;
@synthesize userinfo;

- (CircleEntity *)initWithJsonDictionary:(NSDictionary *)dic
{
    self = [super self];
    if (self) {
        circlebigimg = [[dic getStringValueForKey:@"circlebigimg" defaultValue:@""] retain];
        circleid = [[dic getStringValueForKey:@"circleid" defaultValue:@""] retain];
        circlemiddleimg = [[dic getStringValueForKey:@"circlemiddleimg" defaultValue:@""] retain];
        circlename = [[dic getStringValueForKey:@"circlename" defaultValue:@""] retain];
        circlesmallimg = [[dic getStringValueForKey:@"circlesmallimg" defaultValue:@""] retain];
        circletag = [[dic getStringValueForKey:@"circletag" defaultValue:@""] retain];
        comcount = [dic getIntValueForKey:@"comcount" defaultValue:0];
        createdatetime = [dic getTimeValueForKey:@"createdatetime" defaultValue:0];
        csort = [dic getIntValueForKey:@"csort" defaultValue:0];
        def1 = [[dic getStringValueForKey:@"def1" defaultValue:@""] retain];
        def2 = [[dic getStringValueForKey:@"def2" defaultValue:@""] retain];
        def3 = [[dic getStringValueForKey:@"def3" defaultValue:@""] retain];
        def4 = [[dic getStringValueForKey:@"def4" defaultValue:@""] retain];
        display = [dic getIntValueForKey:@"display" defaultValue:0];
        istop = [dic getIntValueForKey:@"istop" defaultValue:0];
        joincount = [dic getIntValueForKey:@"joincount" defaultValue:0];
        summary = [[dic getStringValueForKey:@"summary" defaultValue:@""] retain];
        updatedatetime = [dic getTimeValueForKey:@"updatedatetime" defaultValue:0];
        userid = [dic getIntValueForKey:@"userid" defaultValue:0];
        NSDictionary *userinfoDic = [dic objectForKey:@"userinfo"];
        if ([userinfoDic isKindOfClass:[NSDictionary class]]) {
            userinfo = [[UsersEntity entityWithJsonDictionary:userinfoDic] retain];
        }
        
    }
    return self;
}

+ (CircleEntity *)entityWithJsonDictionary:(NSDictionary *)dic
{
    return [[[CircleEntity alloc] initWithJsonDictionary:dic] autorelease];
}


@end
