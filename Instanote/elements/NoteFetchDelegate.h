//
//  NoteFetchDelegate.h
//  Instanote
//
//  Created by Man Tung on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "ResultNote.h"
#import "ResultAbstractNote.h"


@interface NoteFetchDelegate : NSObject
{
    
@private
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;


- (id)initWithManagedObjectContext:(NSManagedObjectContext *)manageOBC;

-(NSArray *)fetchDataWithPredicate:(NSPredicate *)predicate;

- (NSArray *)fetchLocalData;

- (NSArray *)fetchAbstractData;

- (int)fetchNoteCount;

- (NSArray *)fetchNoteWithNoteId:(NSNumber *)_note_id;

- (NSArray *)fetchNoteWithNoteId:(NSNumber *)_note_id Source:(NSNumber *)_note_source;

- (void)opLocalDataWithFlag:(NSNumber *)number;

- (NSString *)generateAbstractNoteOne:(NSArray *)array;

- (NSString *)generateAbstractNote:(NSArray *)array;

- (NSString *)generateNote:(NSArray *)array;

- (NSArray *)fetchOneNoteWithServerId:(NSNumber *)server_id;

- (NSArray *)fetchOneNoteWithNoteInfo:(NSString *)noteinfo;

//////////ops

- (BOOL)serverNoteSave:(ResultNote *)note;

- (BOOL)serverNoteComplexSave:(ResultNote *)note;

- (BOOL)serverAbstractNoteFetchNote:(ResultAbstractNote *)note;

- (BOOL)NoteModify:(Note *)note OpLog:(NSNumber *)oplog;

- (BOOL)NoteModify:(Note *)note Flag:(NSNumber *)flag;

- (void)OpreationAbstractNoteWithString:(NSString *)string WithOp:(NSNumber *)op;

- (long long)getLastSyncTime:(BOOL)isSave;

@end
