//
//  CircleCommentInfosEntity.m
//  Instanote
//
//  Created by Man Tung on 12/27/12.
//
//

#import "CircleCommentInfosEntity.h"
#import "NSDictionaryAdditions.h"

@implementation CircleCommentInfosEntity
@synthesize ccid,circledetailid,commentinfo,createdate,def1,def2,def3,def4,def5,def6,def7;
@synthesize ispktype,userid,userinfo;//, createdate_String;

- (CircleCommentInfosEntity *)initWithJsonDictionary:(NSDictionary *)dic
{
    self = [super self];
    if (self) {
        ccid = [[dic getStringValueForKey:@"ccid" defaultValue:@""] retain];
        circledetailid = [[dic getStringValueForKey:@"circledetailid" defaultValue:@""] retain];
        commentinfo = [[dic getStringValueForKey:@"commentinfo" defaultValue:@""] retain];
        createdate = [dic getTimeValueForKey:@"createdateLong" defaultValue:0];
//        createdate_String = [dic getStringValueForKey:@"createdate" defaultValue:@""];
        def1 = [[dic getStringValueForKey:@"def1" defaultValue:@""] retain];
        def2 = [[dic getStringValueForKey:@"def2" defaultValue:@""] retain];
        def3 = [[dic getStringValueForKey:@"def3" defaultValue:@""] retain];
        def4 = [[dic getStringValueForKey:@"def4" defaultValue:@""] retain];
        def5 = [[dic getStringValueForKey:@"def5" defaultValue:@""] retain];
        def6 = [[dic getStringValueForKey:@"def6" defaultValue:@""] retain];
        def7 = [[dic getStringValueForKey:@"def7" defaultValue:@""] retain];
        ispktype = [dic getIntValueForKey:@"ispktype" defaultValue:0];
        userid = [[dic getStringValueForKey:@"userid" defaultValue:@""] retain];
        NSDictionary * userinfoDic = [dic objectForKey:@"userinfo"];
        if ([userinfoDic isKindOfClass:[NSDictionary class]]) {
            userinfo = [[UsersEntity entityWithJsonDictionary:userinfoDic] retain];
        }
    }
    return self;
}

+ (CircleCommentInfosEntity *)entityWithJsonDictionary:(NSDictionary *)dic
{
    return [[[CircleCommentInfosEntity alloc] initWithJsonDictionary:dic] autorelease];
}

- (void)withoutHTML:(NSString *)str
{
    //    NSString *regEx = @"<([^>]*)>";
    //    NSString * stringWithoutHTML = [str stringByReplacingOccurrencesOfRegex:regEx withString:@""];
    //    NSLog(@"stringWithoutHTML=%@",stringWithoutHTML);
    //    private final static String regxpForHtml = "<([^>]*)>";
    //    private final static String regxpForImgTag = "<\\s*img\\s+([^>]*)\\s*>";
    //    private final static String regxpForImaTagSrcAttrib = "src=\"([^\"]+)\"";
    
}

- (NSString *) stringByStrippingHTML
{
    NSRange r;
    NSString *s = [[self copy] autorelease];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
