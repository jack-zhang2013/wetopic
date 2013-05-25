//
//  NoteFetchDelegate.m
//  Instanote
//
//  Created by Man Tung on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NoteFetchDelegate.h"

#import "TempData.h"

@implementation NoteFetchDelegate
@synthesize managedObjectContext;


- (id)initWithManagedObjectContext:(NSManagedObjectContext *)manageOBC;
{
    self = [super init];
    if (self) {
        self.managedObjectContext = manageOBC;
    }
    return self;
}

-(NSArray *)fetchDataWithPredicate:(NSPredicate *)predicate
{
    NSFetchRequest * request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *noteEntity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:noteEntity];
    NSPredicate * pre = predicate;
    [request setPredicate:pre];
    NSError *error = nil;
    NSArray * array = [managedObjectContext executeFetchRequest:request error:&error];
    return array;
}

#pragma mark-
#pragma mark- fetch data

- (NSArray *)fetchLocalData
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(local_flag = %@) AND ((op_log = %@) OR (op_log = %@))", @"1", @"1", @"2"];
    return [self fetchDataWithPredicate:predicate];
    
}

- (NSArray *)fetchAbstractData
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(local_flag = %@) AND ((op_log = %@) OR (op_log = %@))", @"2", @"2", @"3"];
    return [self fetchDataWithPredicate:predicate];
}

- (NSArray *)fetchOneNoteWithServerId:(NSNumber *)server_id
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"note_id = %@", server_id];
    return [self fetchDataWithPredicate:predicate];
}

- (NSArray *)fetchOneNoteWithNoteInfo:(NSString *)noteinfo
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"note_info = %@", noteinfo];
    return [self fetchDataWithPredicate:predicate];
}



- (int)fetchNoteCount
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(op_log != %@)", @"3"];
    NSArray *objects = [self fetchDataWithPredicate:predicate];
    return [objects count];
}

- (void)opLocalDataWithFlag:(NSNumber *)number
{
    NSArray *objects = [self fetchLocalData];
    int count = [objects count];
    if (count > 0) {
        for (Note * note in objects) {
            if (note.op_log == [NSNumber numberWithInt:2]) {
                [self NoteModify:note Flag:number];
            } else {
                [self NoteDelete:note];
            }
            
        }
    }
}

- (NSArray *)fetchNoteWithNoteId:(NSNumber *)_note_id Source:(NSNumber *)_note_source
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(note_id = %@) AND (note_source = %@)", _note_id, _note_source];
    return [self fetchDataWithPredicate:predicate];
}

- (NSArray *)fetchNoteWithNoteId:(NSNumber *)_note_id
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(note_id = %@)", _note_id];
    return [self fetchDataWithPredicate:predicate];
}



#pragma mark-
#pragma mark- operation data to json

- (NSString *)generateAbstractNoteOne:(NSArray *)array
{
    int count = [array count];
    NSMutableString * strnote = [[NSMutableString alloc] init];
    if (count == 1) {
        Note * note = (Note *)[array objectAtIndex:0];
        [strnote appendString:@"{"];
        [strnote appendFormat:@"\"localnoteid\": \"%@\",", note.local_note_id];
        [strnote appendFormat:@"\"servernoteid\": \"%@\",", note.note_id];
        [strnote appendFormat:@"\"localflag\": \"%@\",", note.local_flag];
        [strnote appendFormat:@"\"optflag\": \"%@\",", note.op_log];
        [strnote appendFormat:@"\"notetype\": \"%@\",", note.note_type];
        NSString * lastupdatetime_smtp = [NSString stringWithFormat:@"%lld", (long long)([note.note_lastdate timeIntervalSince1970] * 1000)];
        [strnote appendFormat:@"\"lastupdatetime\": \"%@\",", lastupdatetime_smtp];
        [strnote appendFormat:@"\"strLastupdatetime\": \"%@\"", note.str_note_lastdate];
        [strnote appendString:@"}"];
        //nothing happend
        [self NoteModify:note OpLog:[NSNumber numberWithInt:0]];
    } else {
        [strnote appendString:@""];
    }
    
    return strnote;
}

- (NSString *)generateAbstractNote:(NSArray *)array
{
    int count = [array count];
    NSMutableString * jsonstr = [[NSMutableString alloc] init];
    if (count > 0) {
        int i = 1;
        for (Note * note in array) {
            NSMutableString * strnote = [[NSMutableString alloc] init];
            [strnote appendString:@"{"];
            [strnote appendFormat:@"\"localnoteid\": \"%@\",", note.local_note_id];
            [strnote appendFormat:@"\"servernoteid\": \"%@\",", note.note_id];
            [strnote appendFormat:@"\"localflag\": \"%@\",", note.local_flag];
            [strnote appendFormat:@"\"optflag\": \"%@\",", note.op_log];
            [strnote appendFormat:@"\"notetype\": \"%@\",", note.note_source];
            NSString * lastupdatetime_smtp = [NSString stringWithFormat:@"%lld", (long long)([note.note_lastdate timeIntervalSince1970] * 1000)];
            [strnote appendFormat:@"\"lastupdatetime\": \"%@\",", lastupdatetime_smtp];
            [strnote appendFormat:@"\"strLastupdatetime\": \"%@\"", note.str_note_lastdate];
            [strnote appendString:@"}"];
            if (count == i) {
                [jsonstr appendFormat:@"%@" ,strnote];
            } else {
                [jsonstr appendFormat:@"%@," ,strnote];
            }
            i ++;
        }
    } else {
        [jsonstr appendString:@""];
    }
    return jsonstr;
}

- (NSString *)generateNote:(NSArray *)array
{
    int count = [array count];
    NSMutableString * jsonstr = [[NSMutableString alloc] init];
    if (count > 0) {
        int i = 1;
        for (Note * note in array) {
            NSMutableString * strnote = [[NSMutableString alloc] init];
            [strnote appendString:@"{"];
            if (note.note_id == 0) {
                [strnote appendFormat:@"\"noteId\": \"%@\",", @""];
            } else {
                [strnote appendFormat:@"\"noteId\": \"%@\",", note.note_id];
            }
            NSString * trimmedString = [note.note_info stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
            [strnote appendFormat:@"\"noteInfo\": \"%@\",", trimmedString];
            [strnote appendFormat:@"\"noteUserid\": \"%@\",", note.user_id];
            [strnote appendFormat:@"\"noteSource\": \"%@\",", note.note_source];
            [strnote appendFormat:@"\"localFlag\": \"%@\",", note.local_flag];
            [strnote appendFormat:@"\"optFlag\": \"%@\",", note.op_log];
            [strnote appendFormat:@"\"strNoteDate\": \"%@\",", note.str_notedate];
            [strnote appendFormat:@"\"strNoteLastdate\": \"%@\",", note.str_note_lastdate];
            
            NSString * notedatetime_smtp = [NSString stringWithFormat:@"%lld", (long long)([note.note_date timeIntervalSince1970] * 1000)];
            [strnote appendFormat:@"\"noteDate\": \"%@\",", notedatetime_smtp];
            
            NSString * lastupdatetime_smtp = [NSString stringWithFormat:@"%lld", (long long)([note.note_lastdate timeIntervalSince1970] * 1000)];
            [strnote appendFormat:@"\"noteLastdate\": \"%@\"", lastupdatetime_smtp];
            
            [strnote appendString:@"}"];
            
            
            if (count == i) {
                [jsonstr appendFormat:@"%@" ,strnote];
            } else {
                [jsonstr appendFormat:@"%@," ,strnote];
            }
            i ++;
        }
    } else {
        [jsonstr appendString:@""];
    }
    return jsonstr;
}

#pragma mark-
#pragma mark- json data as agru to 

- (NSString *)jsondataWithResultFlag:(int)flag ResultAbstractnum:(int)abstractnum ResultAbstractValue:(NSString *)abstractvalue ResultInstanoteNum:(int)instanotenum Resultinstanotevalue:(NSString *)instanotevalue Resulttip:(NSString *)tip ClientSucessFlag:(NSString *)clientsucessflag ServerSucessFlag:(NSString *)serversucessflag LastSyncTime:(NSString *)synctime
{
    NSMutableString * jsondata = [[NSMutableString alloc] init];
    
    [jsondata appendString:@"{"];
    
    [jsondata appendFormat:@"\"resultflag\": \"%i\",", flag];
    [jsondata appendFormat:@"\"resultinstanotenum\": \"%i\",", instanotenum];
    [jsondata appendFormat:@"\"resultabstractvalue\": [%@],", abstractvalue];
    [jsondata appendFormat:@"\"resulttip\": \"%@\",", tip];
    [jsondata appendFormat:@"\"clientsucessflag\": \"%@\",", clientsucessflag];
    [jsondata appendFormat:@"\"serversucessflag\": \"%@\",", serversucessflag];
    [jsondata appendFormat:@"\"resultabstractnum\": \"%i\",", abstractnum];
    [jsondata appendFormat:@"\"resultinstanotevalue\": [%@],", instanotevalue];
    [jsondata appendFormat:@"\"lastsynctime\": \"%@\"", synctime];
    [jsondata appendString:@"}"];
    
    return jsondata;
}

- (void)generateShareNote:(NSString *)notestrings
{
    
}

#pragma mark -
#pragma mark - op Note


- (BOOL)serverNoteSave:(ResultNote *)note
{
    Note * _note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:managedObjectContext];
    _note.note_id = note._noteId;
    _note.note_date = note._noteDate;
//    NSString *trimmedString = [note._noteInfo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSString * trimmedString = [note._noteInfo stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    _note.note_info = note._noteInfo;
    _note.note_lastdate = note._noteLastdate;
    _note.note_source = note._noteSource;
    _note.note_type = note.noteType;
    _note.str_notedate = note._strNotedate;
    _note.str_note_lastdate = note._strNoteLastdate;
    _note.user_id = note._noteUserid;
    
    _note.local_flag = [NSNumber numberWithInt:2];//come from server
    _note.local_note_id = [NSNumber numberWithInt:0];//note.noteLocalId;
    _note.op_log = note.op_log;
    
    NSError *error;
    if (![_note.managedObjectContext save:&error]) {
        NSLog(@"note_date is %@ and error track is %@", note._noteDate, [error userInfo]);
        return FALSE;
        abort();
    }
    return TRUE;

}

- (BOOL)serverNoteComplexSave:(ResultNote *)note
{
    NSArray * array = [self fetchNoteWithNoteId:note._noteId Source:note._noteSource];
//    if (note._noteId == 0) {
//        array = [self fetchOneNoteWithNoteInfo:note._noteInfo];
//    } else {
//        array = [self fetchOneNoteWithServerId:note._noteId];
//    }
    if ([array count] == 0) {
//        if ([note.op_log intValue] != 3) {
//            
//            
//        }
        [self serverNoteSave:note];
        
    } else {
        
        Note * _note = [array objectAtIndex:0];
        _note.note_lastdate = note._noteLastdate;
        _note.note_type = note.noteType;
        _note.note_source = note._noteSource;
        _note.note_info = note._noteInfo;
        _note.op_log = note.op_log;
        _note.local_flag = note.local_flag;
        
        NSError * error;
        if(![_note.managedObjectContext save:&error]) {
            NSLog(@"note_date is %@ and error track is %@", note._noteDate, [error userInfo]);
            return FALSE;
            abort();
        }
    }
    return FALSE;
}

- (BOOL)serverAbstractNoteFetchNote:(ResultAbstractNote *)note
{
    
    return TRUE;
}

- (BOOL)NoteModify:(Note *)note OpLog:(NSNumber *)oplog
{
    note.op_log = oplog;
    NSError *error;
    if (![note.managedObjectContext save:&error]) {
        NSLog(@"error track is %@", [error userInfo]);
        return FALSE;
        abort();
    }
    return TRUE;
}

- (BOOL)NoteModify:(Note *)note Flag:(NSNumber *)flag
{
    note.local_flag = flag;
    NSError *error;
    if (![note.managedObjectContext save:&error]) {
        NSLog(@"error track is %@", [error userInfo]);
        return FALSE;
        abort();
    }
    return TRUE;
}

- (void)NoteDelete:(Note *)note
{
    [managedObjectContext delete:note];
    [managedObjectContext save:nil];
}


- (void)OpreationAbstractNoteWithString:(NSString *)string WithOp:(NSNumber *)op
{
    NSDictionary * ary =  (NSDictionary *)string;
    for (NSDictionary * dic in ary) {
        if (![dic isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        ResultAbstractNote * abstractnote = [ResultAbstractNote ResultsWithJsonDictionary:dic];
        NSArray * array = [self fetchNoteWithNoteId:abstractnote.serverNoteId];
        [self ModifyNote:array WithOp:[NSNumber numberWithInt:0]];
    }
}

- (void)ModifyNote:(NSArray *)array WithOp:(NSNumber *)op
{
    int count = [array count];
    if (count == 1) {
        Note * note = (Note *)[array objectAtIndex:0];
        [self NoteModify:note OpLog:op];
    }
}


#pragma mark -
#pragma mark - tools

#define LASTSYNCTIME @"lastsynctime"

- (long long)getLastSyncTime:(BOOL)isSave
{
    long long nowtime = (long long)[[NSDate date] timeIntervalSince1970];
    nowtime = nowtime * 1000;
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString * defLastSyncTime = [def stringForKey:LASTSYNCTIME];
    if (isSave) {
        [def setValue:[NSString stringWithFormat:@"%lld", nowtime] forKey:LASTSYNCTIME];
        [def synchronize];
    }
    if (defLastSyncTime) {
        nowtime = [defLastSyncTime longLongValue];
    }
    return nowtime;
}                       

@end
