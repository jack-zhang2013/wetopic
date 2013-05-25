//
//  Note.h
//  Instanote
//
//  Created by CMD on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSNumber * local_flag;
@property (nonatomic, retain) NSNumber * local_note_id;
@property (nonatomic, retain) NSDate * note_date;
@property (nonatomic, retain) NSNumber * note_id;
@property (nonatomic, retain) NSString * note_info;
@property (nonatomic, retain) NSDate * note_lastdate;
@property (nonatomic, retain) NSNumber * note_source;
@property (nonatomic, retain) NSNumber * note_type;
@property (nonatomic, retain) NSNumber * op_log;
@property (nonatomic, retain) NSString * str_note_lastdate;
@property (nonatomic, retain) NSString * str_notedate;
@property (nonatomic, retain) NSNumber * user_id;

@end
