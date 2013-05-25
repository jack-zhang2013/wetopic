//
//  TempData.m
//  Instanote
//
//  Created by Man Tung on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TempData.h"

#define aUserId @"userid"

static NSString * opstring = @"";

static int userid;

@implementation TempData

+ (NSString *)OpMessage
{
    return opstring;
}

+ (void) setOpMessage:(NSString *)message
{
    opstring = message;
}

+ (int)UserId
{
    return userid;
}

+ (void)setUserId:(int)uid
{
    userid = uid;
}

@end
