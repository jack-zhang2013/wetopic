//
//  UsersEntity.m
//  Instanote
//
//  Created by Man Tung on 12/25/12.
//
//

#import "UsersEntity.h"
#import "NSDictionaryAdditions.h"

@implementation UsersEntity
@synthesize declaration,email,nick,otheraccount,otheraccountflag,otheraccountuserimage;
@synthesize otheraccountypeid,password,registertime,sex,what,userid,userlevel;
@synthesize image;

- (UsersEntity *)initWithJsonDictionary:(NSDictionary *)dic
{
    self = [super self];
    if (self) {
        declaration = [[dic getStringValueForKey:@"declaration" defaultValue:@""] retain];
        email = [[dic getStringValueForKey:@"email" defaultValue:@""] retain];
        image = [[dic getStringValueForKey:@"image" defaultValue:@""] retain];
        nick = [[dic getStringValueForKey:@"nick" defaultValue:@""] retain];
        otheraccount = [dic getIntValueForKey:@"otheraccount" defaultValue:-1];
        otheraccountflag = [[dic getStringValueForKey:@"otheraccountflag" defaultValue:@""] retain];
        otheraccountuserimage = [[dic getStringValueForKey:@"otheraccountuserimage" defaultValue:@"anonymous"] retain];
        otheraccountypeid = [dic getIntValueForKey:@"otheraccountypeid" defaultValue:-1];
        password = [[dic getStringValueForKey:@"password" defaultValue:@""] retain];
        registertime = [dic getTimeValueForKey:@"registertimeLong" defaultValue:0];
        userid = [dic getIntValueForKey:@"userid" defaultValue:-1];
        userlevel = [dic getIntValueForKey:@"userlevel" defaultValue:-1];
    }
    return self;
}

+ (UsersEntity *)entityWithJsonDictionary:(NSDictionary *)dic
{
    return [[[UsersEntity alloc] initWithJsonDictionary:dic] autorelease];
}

@end
