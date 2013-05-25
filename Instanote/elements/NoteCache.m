//
//  NoteCache.m
//  Instanote
//
//  Created by Man Tung on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NoteCache.h"
#import "Note.h"

/*
 
 CacheNode is a simple object to help with tracking cached items. 
 
 */

@interface CacheNode : NSObject {
    NSManagedObjectID *objectID;
    NSUInteger accessCounter;
}

@property (nonatomic, retain) NSManagedObjectID *objectID;
@property NSUInteger accessCounter;

@end

@implementation CacheNode

@synthesize objectID, accessCounter;

- (void)dealloc {
    [objectID release];
    [super dealloc];
}

@end

@implementation NoteCache

@synthesize managedObjectContext, cacheSize, cache;

- (id)init {
    self = [super init];
    if (self != nil) {
        cacheSize = 15;
        accessCounter = 0;
        cache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (cacheHitCount > 0) NSLog(@"average cache hit cost:  %f", totalCacheHitCost/cacheHitCount);
    if (cacheMissCount > 0) NSLog(@"average cache miss cost: %f", totalCacheMissCost/cacheMissCount);
    [categoryEntityDescription release];
    categoryEntityDescription = nil;
    [categoryNamePredicateTemplate release];
    categoryNamePredicateTemplate = nil;
    [managedObjectContext release];
    [cache release];
    [super dealloc];
}

// Implement the "set" accessor rather than depending on @synthesize so that we can set up registration
// for context save notifications.
- (void)setManagedObjectContext:(NSManagedObjectContext *)aContext {
    if (managedObjectContext) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:managedObjectContext];
        [managedObjectContext release];
    }
    managedObjectContext = [aContext retain];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectContextDidSave:) name:NSManagedObjectContextDidSaveNotification object:managedObjectContext];
}

// When a managed object is first created, it has a temporary managed object ID. When the managed object context in which it was created is saved, the temporary ID is replaced with a permanent ID. The temporary IDs can no longer be used to retrieve valid managed objects. The cache handles the save notification by iterating through its cache nodes and removing any nodes with temporary IDs.
// While it is possible force Core Data to provide a permanent ID before an object is saved, using the method -[ NSManagedObjectContext obtainPermanentIDsForObjects:error:], this method incurrs a trip to the database, resulting in degraded performance - the very thing we are trying to avoid. 
- (void)managedObjectContextDidSave:(NSNotification *)notification {
    CacheNode *cacheNode = nil;
    NSMutableArray *keys = [NSMutableArray array];
    for (NSString *key in cache) {
        cacheNode = [cache objectForKey:key];
        if ([cacheNode.objectID isTemporaryID]) {
            [keys addObject:key];
        }
    }
    [cache removeObjectsForKeys:keys];
}

- (NSEntityDescription *)categoryEntityDescription {
    if (categoryEntityDescription == nil) {
        categoryEntityDescription = [[NSEntityDescription entityForName:@"Category" inManagedObjectContext:managedObjectContext] retain];
    }
    return categoryEntityDescription;
}

static NSString * const kCategoryNameSubstitutionVariable = @"NAME";

- (NSPredicate *)categoryNamePredicateTemplate {
    if (categoryNamePredicateTemplate == nil) {
        NSExpression *leftHand = [NSExpression expressionForKeyPath:@"name"];
        NSExpression *rightHand = [NSExpression expressionForVariable:kCategoryNameSubstitutionVariable];
        categoryNamePredicateTemplate = [[NSComparisonPredicate alloc] initWithLeftExpression:leftHand rightExpression:rightHand modifier:NSDirectPredicateModifier type:NSLikePredicateOperatorType options:0];   
    }
    return categoryNamePredicateTemplate;
}

// Undefine this macro to compare performance without caching
#define USE_CACHING

- (Note *)noteWithName:(NSString *)name {
    NSTimeInterval before = [NSDate timeIntervalSinceReferenceDate];
#ifdef USE_CACHING
    // check cache
    CacheNode *cacheNode = [cache objectForKey:name];
    if (cacheNode != nil) {
        // cache hit, update access counter
        cacheNode.accessCounter = accessCounter++;
        Note *note = (Note *)[managedObjectContext objectWithID:cacheNode.objectID];
        totalCacheHitCost += ([NSDate timeIntervalSinceReferenceDate] - before);
        cacheHitCount++;
        return note;
    }
#endif
    // cache missed, fetch from store - if not found in store there is no category object for the name and we must create one
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:self.categoryEntityDescription];
    NSPredicate *predicate = [self.categoryNamePredicateTemplate predicateWithSubstitutionVariables:[NSDictionary dictionaryWithObject:name forKey:kCategoryNameSubstitutionVariable]];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchResults = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    NSAssert1(fetchResults != nil, @"Unhandled error executing fetch request in import thread: %@", [error localizedDescription]);
    
    Note *note = nil;
    if ([fetchResults count] > 0) {
        // get category from fetch
        note = [fetchResults objectAtIndex:0];
    } else if ([fetchResults count] == 0) {
        // category not in store, must create a new category object 
        note = [[Note alloc] initWithEntity:self.categoryEntityDescription insertIntoManagedObjectContext:managedObjectContext];
        //note.user = name;
        [note autorelease];
    }
#ifdef USE_CACHING
    // add to cache
    // first check to see if cache is full
    if ([cache count] >= cacheSize) {
        // evict least recently used (LRU) item from cache
        NSUInteger oldestAccessCount = UINT_MAX;
        NSString *key = nil, *keyOfOldestCacheNode = nil;
        for (key in cache) {
            CacheNode *tmpNode = [cache objectForKey:key];
            if (tmpNode.accessCounter < oldestAccessCount) {
                oldestAccessCount = tmpNode.accessCounter;
                [keyOfOldestCacheNode release];
                keyOfOldestCacheNode = [key retain];
            }
        }
        // retain the cache node for reuse
        cacheNode = [[cache objectForKey:keyOfOldestCacheNode] retain];
        // remove from the cache
        [cache removeObjectForKey:keyOfOldestCacheNode];
    } else {
        // create a new cache node
        cacheNode = [[CacheNode alloc] init];
    }
    cacheNode.objectID = [note objectID];
    cacheNode.accessCounter = accessCounter++;
    [cache setObject:cacheNode forKey:name];
    [cacheNode release];
#endif
    totalCacheMissCost += ([NSDate timeIntervalSinceReferenceDate] - before);
    cacheMissCount++;
    return note;
}


@end
