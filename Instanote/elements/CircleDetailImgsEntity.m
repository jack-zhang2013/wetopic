//
//  CircleDetailImgsEntity.m
//  Instanote
//
//  Created by Man Tung on 12/27/12.
//
//

#import "CircleDetailImgsEntity.h"
#import "NSDictionaryAdditions.h"

@implementation CircleDetailImgsEntity

@synthesize bigimg,cdid,def1,def2,circledetailid,smalling,middleimg,uploadtime;

- (CircleDetailImgsEntity *)initWithJsonDictionary:(NSDictionary *)dic
{
    self = [super self];
    if (self) {
        bigimg = [[dic getStringValueForKey:@"bigimg" defaultValue:@""] retain];
        cdid = [[dic getStringValueForKey:@"cdid" defaultValue:@""] retain];
        def1 = [[dic getStringValueForKey:@"def1" defaultValue:@""] retain];
        def2 = [[dic getStringValueForKey:@"def2" defaultValue:@""] retain];
        circledetailid = [[dic getStringValueForKey:@"circledetailid" defaultValue:@""] retain];
        smalling = [[dic getStringValueForKey:@"smalling" defaultValue:@""] retain];
        middleimg = [[dic getStringValueForKey:@"middleimg" defaultValue:@""] retain];
//        uploadtime = [dic getLongLongValueValueForKey:@"uploadtimeLong" defaultValue:0];
    }
    return self;
}

+ (CircleDetailImgsEntity *)entityWithJsonDictionary:(NSDictionary *)dic
{
    return [[[CircleDetailImgsEntity alloc] initWithJsonDictionary:dic] autorelease];
}


@end
