//
//  TopicsEntity.m
//  Instanote
//
//  Created by Man Tung on 12/27/12.
//
//

#import "TopicsEntity.h"
#import "NSDictionaryAdditions.h"

@implementation TopicsEntity
@synthesize def1,def2,def3,def4;
@synthesize display,userinfo,circledetailid,circleCommentInfo,circlecontent,circleDetailImg;
@synthesize circleid,comcount,createdatetime,ctag,gztopics,isgz,ispk,title,topicPks,updatedatetime;
@synthesize userid,visitcount;//,createdatetime_String, updatedatetimeString;

- (TopicsEntity *)initWithJsonDictionary:(NSDictionary *)dic
{
    self = [super self];
    if (self) {
//        NSLog(@"%@", dic);
        def1 = [[dic getStringValueForKey:@"def1" defaultValue:@""] retain];
        def2 = [[dic getStringValueForKey:@"def2" defaultValue:@""] retain];
        def3 = [[dic getStringValueForKey:@"def3" defaultValue:@""] retain];
        def4 = [[dic getStringValueForKey:@"def4" defaultValue:@""] retain];
        display = [dic getIntValueForKey:@"display" defaultValue:-1];
        NSDictionary *userinfoDic = [dic objectForKey:@"userinfo"];
        if ([userinfoDic isKindOfClass:[NSDictionary class]]) {
            userinfo = [[UsersEntity entityWithJsonDictionary:userinfoDic] retain];
        }
        circledetailid = [[dic getStringValueForKey:@"circledetailid" defaultValue:@""] retain];
        circlecontent = [[dic getStringValueForKey:@"circlecontent" defaultValue:@""] retain];
        
//        circleCommentInfo = [[NSMutableArray alloc] initWithCapacity:0];
//        NSDictionary * commentInfoDic = [dic objectForKey:@"topicCommentInfo"];
//        for (NSDictionary * commentinfo in commentInfoDic) {
//            if (![commentinfo isKindOfClass:[NSDictionary class]]) {
//                continue;
//            }
//            CircleCommentInfosEntity *ccie = [CircleCommentInfosEntity entityWithJsonDictionary:commentinfo];
//            [circleCommentInfo addObject:ccie];
//        }
        
        
        NSDictionary *imgDic = [[dic objectForKey:@"circleDetailImg"] retain];
        
        circleDetailImg = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (NSDictionary * imgdetial in imgDic) {
            if (![imgdetial isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            CircleDetailImgsEntity * cdi = [CircleDetailImgsEntity entityWithJsonDictionary:imgdetial];
            [circleDetailImg addObject:cdi];
        }
        circleid = [[dic getStringValueForKey:@"circleid" defaultValue:@""] retain];
        comcount = [dic getIntValueForKey:@"comcount" defaultValue:0];
        createdatetime = [dic getTimeValueForKey:@"createdatetime" defaultValue:0];
        //createdatetime_String = [dic getStringValueForKey:@"createdatetime" defaultValue:0];
        ctag = [[dic getStringValueForKey:@"ctag" defaultValue:@""] retain];
        gztopics = [[dic getStringValueForKey:@"gztopics" defaultValue:@""] retain];
        isgz = [[dic getStringValueForKey:@"isgz" defaultValue:@""] retain];
        ispk = [[dic getStringValueForKey:@"ispk" defaultValue:@""] retain];
        title = [[dic getStringValueForKey:@"title" defaultValue:@""] retain];
        topicPks = [[dic getStringValueForKey:@"topicPks" defaultValue:@""] retain];
        updatedatetime = [dic getTimeValueForKey:@"updatedatetimeLong" defaultValue:0];
//        updatedatetime_String = [dic getStringValueForKey:@"updatedatetime" defaultValue:0];
        userid = [[dic getStringValueForKey:@"userid" defaultValue:@""] retain];
        visitcount = [dic getIntValueForKey:@"circleid" defaultValue:0];
    }
    return self;
}

+ (TopicsEntity *)entityWithJsonDictionary:(NSDictionary *)dic
{
    return [[[TopicsEntity alloc] initWithJsonDictionary:dic] autorelease];
}

//- (NSString*)timestamp:(time_t )create_at
//{
//	NSString *_timestamp;
//    // Calculate distance time string
//    
//    time_t now;
//    time(&now);
//    
//    int distance = (int)difftime(now, create_at);
//    if (distance < 0) distance = 0;
//    
//    if (distance < 60) {
//        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
//    }
//    else if (distance < 60 * 60) {
//        distance = distance / 60;
//        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
//    }
//    
//    else {
//        static NSDateFormatter *dateFormatter = nil;
//        if (dateFormatter == nil) {
//            dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] autorelease]];
//        }
//        
//        struct tm * createAtTM = localtime(&create_at);
//        NSDate * currentlytime = [NSDate date];
//        NSCalendar * gregorian = gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//        NSDateComponents * currentlytimeComponents = [gregorian components:NSDayCalendarUnit fromDate:currentlytime];
//        if (createAtTM->tm_mday == [currentlytimeComponents day]) {
//            [dateFormatter setDateFormat:@"HH:mm"];
//        }
//        else if (createAtTM->tm_mday == ([currentlytimeComponents day] - 1) ) {
//            [dateFormatter setDateFormat:@"'昨' HH:mm"];
//        }
//        else {
//            [dateFormatter setDateFormat:@"MM.dd HH:mm"];
//        }
//        
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:create_at];
//        _timestamp = [dateFormatter stringFromDate:date];
//        
//    }
//    return _timestamp;
//}

@end
