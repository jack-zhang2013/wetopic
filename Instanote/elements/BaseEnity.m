//
//  BaseEnity.m
//  Instanote
//
//  Created by Man Tung on 3/26/13.
//
//

#import "BaseEnity.h"

@implementation BaseEnity

- (NSString*)timestamp:(time_t )create_at
{
	NSString *_timestamp;
    // Calculate distance time string
    
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, create_at);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
    }
    
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] autorelease]];
        }
        
        struct tm * createAtTM = localtime(&create_at);
        NSDate * currentlytime = [NSDate date];
        NSCalendar * gregorian = gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents * currentlytimeComponents = [gregorian components:NSDayCalendarUnit fromDate:currentlytime];
        if (createAtTM->tm_mday == [currentlytimeComponents day]) {
            [dateFormatter setDateFormat:@"H时m分"];
        }
        else if (createAtTM->tm_mday == ([currentlytimeComponents day] - 1) ) {
            [dateFormatter setDateFormat:@"'昨天'H时m分"];
        }
        else {
            [dateFormatter setDateFormat:@"M月d日"];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:create_at];
        _timestamp = [dateFormatter stringFromDate:date];
        
    }
    return _timestamp;
}


@end
