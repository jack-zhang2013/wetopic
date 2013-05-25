//
//  NoteCache.h
//  Instanote
//
//  Created by Man Tung on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Note;

@interface NoteCache : NSObject {
    NSManagedObjectContext *managedObjectContext;
    // Number of objects that can be cached
    NSUInteger cacheSize;
    // A dictionary holds the actual cached items 
    NSMutableDictionary *cache;
    NSEntityDescription *categoryEntityDescription;
    NSPredicate *categoryNamePredicateTemplate;
    // Counter used to determine the least recently touched item.
    NSUInteger accessCounter;
    // Some basic metrics are tracked to help determine the optimal cache size for the problem.
    CGFloat totalCacheHitCost;
    CGFloat totalCacheMissCost;
    NSUInteger cacheHitCount;
    NSUInteger cacheMissCount;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property NSUInteger cacheSize;
@property (nonatomic, retain) NSMutableDictionary *cache;
@property (nonatomic, retain, readonly) NSEntityDescription *categoryEntityDescription;
@property (nonatomic, retain, readonly) NSPredicate *categoryNamePredicateTemplate;

- (Note *)noteWithName:(NSString *)name;

@end
