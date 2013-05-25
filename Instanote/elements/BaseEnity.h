//
//  BaseEnity.h
//  Instanote
//
//  Created by Man Tung on 3/26/13.
//
//

#import <Foundation/Foundation.h>

@interface BaseEnity : NSObject

//- (id)initWithJsonDictionary:(NSDictionary *)dic;
//
//+ (id)entityWithJsonDictionary:(NSDictionary *)dic;

- (NSString *)timestamp:(time_t )create_at;

@end
