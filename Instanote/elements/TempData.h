//
//  TempData.h
//  Instanote
//
//  Created by Man Tung on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TempData : NSObject

+ (NSString *)OpMessage;

+ (void) setOpMessage:(NSString *)message;

+ (int)UserId;

+ (void)setUserId:(int)uid;

@end
