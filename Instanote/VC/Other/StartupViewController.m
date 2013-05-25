
//
//  StartupViewController.m
//  Instanote
//
//  Created by CMD on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "AddViewController.h"
#import "StartupViewController.h"
//slider menu
#import "IIViewDeckController.h"

#import "FeedbackViewController.h"
#import "AboutUsViewController.h"
#import "DetailViewController.h"
#import "LoginViewController.h"
#import "Note.h"
#import "BaseCell.h"
#import "ReturnResults.h"
#import "ReturnSyncResults.h"
#import "ResultNote.h"
#import "ResultAbstractNote.h"
#import "JSON.h"

#import "TempData.h"

#import "InstanoteInstanoteWebServiceService.h"
#import "InoteSyncInstanoteSynchronyServiceService.h"


#import <QuartzCore/QuartzCore.h>

#define aUserId @"userid"

@interface StartupViewController ()

@end

@implementation StartupViewController

@synthesize managedObjectContext, fetchedResultsController;
//@synthesize addNote;
@synthesize tableView;
@synthesize fd;

@synthesize popoverController = _popoverController2;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editTableview)];
    //editTableview     event
    
    //StartSync         event
    
    
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:
//                                               [[UIBarButtonItem alloc] initWithTitle:@"Sync" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleRightView)],
//                                               [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(editTableview)],
//                                               nil];


    
    //self.navigationController
    
//    if ([self.navigationItem respondsToSelector:@selector(rightBarButtonItems)]) {
//        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:
//                                                   [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleRightView)],
//                                                   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(showCam:)],
//                                                   nil];
//    }
//    else {
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleRightView)];
//    }
    
    CGRect tableRect = self.view.bounds;
    tableRect.size.height -= 44.f;
    self.tableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
//    [self.tableView setEditing: YES animated: YES];
    
    [self.view insertSubview:self.tableView atIndex:0];
    
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addButton setFrame:CGRectMake(270, 365, 35, 35)];
    [addButton setTitle:@"＋" forState:UIControlStateNormal];
    [addButton addTarget:self action:(@selector(addAction)) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:addButton atIndex:1];
    
    //test for
    
    
    //add
    if (!mDisableViewOverlay) {
        mDisableViewOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        mDisableViewOverlay.backgroundColor=[UIColor blackColor];
        mDisableViewOverlay.alpha = 0; 
    }
    
    if (!tapgr) {
        tapgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignDisableViewOverlay)];
        [mDisableViewOverlay addGestureRecognizer:tapgr];
    }
    
    if (!addInputView) {
        addInputView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 310, 190)];
        [addInputView setFont:[UIFont fontWithName:@"Arial" size:16]];
        [addInputView setReturnKeyType:UIReturnKeyDone];
        [addInputView setDelegate:self];
        [addInputView setEnablesReturnKeyAutomatically:YES];
    }
    
    if (!fd) {
        fd = [[NoteFetchDelegate alloc] initWithManagedObjectContext:self.managedObjectContext];
    }
    
    [MTStatusBarOverlay sharedInstance].animation = MTStatusBarOverlayAnimationShrink;  // MTStatusBarOverlayAnimationShrink
    [MTStatusBarOverlay sharedInstance].detailViewMode = MTDetailViewModeHistory;         // enable automatic history-tracking and show in detail-view
    [MTStatusBarOverlay sharedInstance].delegate = self;
    
    //why not here fetch the data from local database. 'cause the login action take too much.
//    [self fetch];
}

/*
- (void)queryLocalCount
{
    int count = [fd fetchNoteCount];
    if (count == 0) {
        [self synchronizeNote];
    } else {
        [self fetch];
    }
}
*/


- (void)editTableview
{
    if ([self.tableView isEditing]) {
        // If the tableView is already in edit mode, turn it off. Also change the title of the button to reflect the intended verb (‘Edit’, in this case).
        [self.tableView setEditing:NO animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
    } else {
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
        // Turn on edit mode
        [self.tableView setEditing:YES animated:YES];
    }
}

#pragma mark -
#pragma mark userinfo


#define aUserId @"userid"
#define aUserFlag @"userflag"
#define aUserEmail @"useremail"
#define aUserKey @"userkey"
#define aUserPass @"userpass"
#define aUserRegisterDate @"userregisterdate"
#define aUserSource @"usersource"
#define aStrRegisterDate @"strregisterdate"


-(int)getUserId
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSUInteger userid = [def integerForKey:aUserId];
    if (userid) {
        return userid;
    } else {
        return 0;
    }
}

- (void)StartSync
{
    [self syncPushLocalSimpleData];
    //[self syncPushLocalData];
}

#define aUserName @"instanoteadmin"
#define aPassword @"instanote#admin#123456"

/*

- (void)synchronizeNote
{
    //here is soap methods
    InstanoteInstanoteWebServiceService* service = [InstanoteInstanoteWebServiceService service];
	service.logging = YES;
    service.username = aUserName;
	service.password = aPassword;
    
    int object = 2;//1 user 2 note
    int type = 6; //1:add 2:modify 3:delete 4:deleteall 5:getone 6:getlist
    int userid = [self getUserId];
    NSString *email = @"";
    NSString *password = @"";
    NSString *userSource = @"";
    NSString *newPassword = @"";
    int noteid = 0;
    NSString *noteInfo = @"";
    long notedate = 0;
    long lastdate = 0;
    short notesource = -1;
    int pagenum = 1;
    int pagesize = 100;
    NSString *active = @"";
    
    [service instanoteService:self 
                       action:@selector(instanoteServiceHandler:) 
                    intobject:object 
                      inttype:type 
                    intuserid:userid 
                     stremail:email 
                      strpass:password 
                strusersource:userSource 
                   strnewpass:newPassword 
                       noteid:noteid 
                     noteinfo:noteInfo 
                     notedate:notedate 
                 notelastdate:lastdate 
                   notesource:notesource 
                   intpagenum:pagenum 
                  intpagesize:pagesize 
                    stractive:active];
}

// Handle the response from instanoteService.

- (void) instanoteServiceHandler: (id) value {
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"There is an error:%@", value);
        NSString * errorinfo = [value localizedDescription];
        if ([errorinfo isEqualToString:@"Could not connect to the server."]) {
            UIAlertView * alert = [UIAlertView alloc];
            [alert initWithTitle:@"Notice"
                         message:@"A connection failure occurred."
                        delegate:self
               cancelButtonTitle:@"Close"
               otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"There is an soapfault:%@", value);
		return;
	}				
    
    NSString * str = (NSString *)value;
    NSObject * obj = [str JSONValue];
    
    ReturnResults * r = [ReturnResults ResultsWithJsonDictionary:(NSDictionary *)obj];
    [self OpreationNoteWithString:r.data];
    
    [self fetch];
    
}
 
 */

#define LASTSYNCTIME @"lastsynctime"

- (long long)getLastSyncTime:(BOOL)isSave
{
    long long nowtime = (long long)[[NSDate date] timeIntervalSince1970];
    nowtime = nowtime * 1000;
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString * defLastSyncTime = (NSString *)[def objectForKey:LASTSYNCTIME];
    if (isSave) {
        [def setValue:[NSString stringWithFormat:@"%lld", nowtime] forKey:LASTSYNCTIME];
        [def synchronize];
    }
    if (defLastSyncTime) {
        nowtime = [defLastSyncTime longLongValue];
    } else {
        nowtime = 0;
    }
    
//    NSLog(@"now time stmp %lld", nowtime);
    
    return nowtime;
}


#pragma mark -
#pragma mark - step one

- (void)syncPushLocalSimpleData
{
    ////////////////////////
    ReturnSyncResults * syncResults = [[ReturnSyncResults alloc] init];
    NSArray * array = [fd fetchAbstractData];
    NSString * abstractvalue = [fd generateAbstractNote:array];
    syncResults.resultabstractvalue = abstractvalue;
    syncResults.resultflag = 200;
    syncResults.resultabstractnum = [array count];
    syncResults.resultinstanotenum = 0;
    syncResults.resultinstanotevalue = @"";
    syncResults.serversucessflag = @"F";
    syncResults.clientsucessflag = @"F";
    syncResults.lastsynctime = [self getLastSyncTime:NO];
    syncResults.resulttip = @"sucess";
    
    int type = 1;
    int userid = [self getUserId];
    int pagesize = 100;
    int pagenum = 1;
    
    InoteSyncInstanoteSynchronyServiceService * service = [InoteSyncInstanoteSynchronyServiceService service];
    service.username = aUserName;
    service.password = aPassword;
    service.logging = YES;
    NSString * data = [syncResults initJsonString];
    [MTStatusBarOverlay sharedInstance].progress = 0.0;
    [[MTStatusBarOverlay sharedInstance] postMessage:@"Synchronizing..."];
    [MTStatusBarOverlay sharedInstance].progress = 0.3;
    
    
//    NSLog(@"step 1 push abstract data is %@", data);
    
    
    
    [service instanoteSynchronyService:self action:@selector(syncPushLocalSimpleDataHandler:) inttype: type intuserid: userid strdata: data intpagenum: pagenum intpagesize: pagesize];
}

-(void)syncPushLocalSimpleDataHandler:(id)value
{
    // Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"There is an error:%@", value);
        NSString * errorinfo = [value localizedDescription];
        if ([errorinfo isEqualToString:@"Could not connect to the server."]) {
            [[MTStatusBarOverlay sharedOverlay] postErrorMessage:@"Could not connect to the server" duration:2.0 animated:YES];
//            UIAlertView * alert = [UIAlertView alloc];
//            [alert initWithTitle:@"Notice"
//                         message:@"A connection failure occurred."
//                        delegate:self
//               cancelButtonTitle:@"Close"
//               otherButtonTitles:nil];
//            [alert show];
//            [alert release];
        }
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"There is an soapfault:%@", value);
		return;
	}				
    //handle the data
    NSString * str = (NSString *)value;
    
    
    
    
    NSLog(@"step 1 return data is %@", str);
    
    
    
    
    
    NSObject * obj = [str JSONValue];
    ReturnSyncResults * r = [ReturnSyncResults ResultsWithJsonDictionary:(NSDictionary *)obj];
    //not prue local data
    NSString * abstractvalue = r.resultabstractvalue;
    NSString * instanotevalue = r.resultinstanotevalue;
    if (abstractvalue == @"[]") {
        [self syncPushLocalData];
    } else {
        [self OpreationAbstractNoteWithString:abstractvalue];
    }
    if (instanotevalue != @"[]") {
        [self OpreationComplexNoteWithString:instanotevalue];
    }
    //returnvalue parse int 27856088 ,but too silly.
}

- (BOOL)OpreationNoteWithString:(NSString *)string
{
    BOOL isSucess;
    
    NSDictionary * ary =  (NSDictionary *)string;
    for (NSDictionary * dic in ary) {
        if (![dic isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        ResultNote * note = [ResultNote ResultsWithJsonDictionary:dic];
        if (![fd serverNoteSave:note]) {
            isSucess = FALSE;
        }
        
    }//end for loop
    return isSucess;
}

- (BOOL)OpreationComplexNoteWithString:(NSString *)string
{
    BOOL isSucess;
    
    NSDictionary * ary =  (NSDictionary *)string;
    for (NSDictionary * dic in ary) {
        if (![dic isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        ResultNote * note = [ResultNote ResultsWithJsonDictionary:dic];
        if (![fd serverNoteComplexSave:note]) {
            isSucess = FALSE;
        };
        
    }//end for loop
    return isSucess;
}

- (void)OpreationAbstractNoteWithFetchServerId:(NSString *)string
{
    NSDictionary * ary = (NSDictionary *)string;
    NSArray * localdataarray = [[NSArray alloc] initWithArray:tempAbstractNotes];
    int abnotecount = [ary count];
    int notecount = [localdataarray count];
    if (abnotecount == notecount) {
        int i = 0;
        for (NSDictionary * dic in ary) {
            if (![dic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            ResultAbstractNote * abstractnote = [ResultAbstractNote ResultsWithJsonDictionary:dic];
            NSUInteger objecti = i;
            Note * note = (Note *)[localdataarray objectAtIndex:objecti];
            note.note_id = abstractnote.serverNoteId;
            note.local_flag = [NSNumber numberWithInt:2];
            [note.managedObjectContext save:nil];
            i ++;
        }//end for loop
    }
    
}

- (void)OpreationAbstractNoteWithString:(NSString *)string
{
    NSMutableString * jsonstring = [[NSMutableString alloc] init];
    int count = 0;
    NSDictionary * ary =  (NSDictionary *)string;
    
    //save the as the temp. then modify them
    tempabstractValue = string;
    
    count += [ary count];
    
    int i = 1;
    for (NSDictionary * dic in ary) {
        if (![dic isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        ResultAbstractNote * abstractnote = [ResultAbstractNote ResultsWithJsonDictionary:dic];
        NSArray * array = [fd fetchNoteWithNoteId:abstractnote.serverNoteId Source:abstractnote.noteType];
        NSString * notestring = [fd generateNote:array];
        if (i == [ary count]) {
            [jsonstring appendFormat:@"%@", notestring];
        } else {
            [jsonstring appendFormat:@"%@,", notestring];
        }
        
        
        
        
//        NSLog(@"abstract to note %@", notestring);
        
        
        
        
        
        i ++;
    }//end for loop
    NSArray * localdataarray = [fd fetchLocalData];
    tempAbstractNotes = [[NSArray alloc] initWithArray:localdataarray];
    count += [localdataarray count];
    NSString * notelist = [fd generateNote:localdataarray];
    if ([localdataarray count] != 0) {
        [jsonstring appendFormat:@",%@", notelist];
    } else {
        [jsonstring appendString:notelist];
    }
    
    ReturnSyncResults * syncResults = [[ReturnSyncResults alloc] init];
    syncResults.resultflag = 200;
    syncResults.resultabstractnum = 0;
    syncResults.resultabstractvalue = @"";
    syncResults.resultinstanotenum = count;
    syncResults.resultinstanotevalue = (NSString *)jsonstring;
    syncResults.resulttip = @"sucess";
    syncResults.serversucessflag = @"T";
    syncResults.clientsucessflag = @"T";
    syncResults.lastsynctime = [self getLastSyncTime:NO];
    
    NSString * data = [syncResults initJsonString];
    
    int type = 2;
    int userid = [self getUserId];
    //the is no meaning actually. but Yan make this rule when work in lab.so we inherit this rule
    int pagesize = 100;
    int pagenum = 1;
    
    
    
    
//    NSLog(@"step 2 type is %d and userid is %d and pagesize is %d and pagenum is %d local data (mixs) is %@", type, userid, pagesize, pagenum, data);
    
    
    
    [MTStatusBarOverlay sharedOverlay].progress = 0.4;
    [[MTStatusBarOverlay sharedInstance] postMessage:@"Still Processing..." animated:YES];
    [MTStatusBarOverlay sharedInstance].progress = 0.5;
    
    InoteSyncInstanoteSynchronyServiceService * service = [InoteSyncInstanoteSynchronyServiceService service];
    service.username = aUserName;
    service.password = aPassword;
    service.logging = YES;
    
    [service instanoteSynchronyService:self action:@selector(OpreationAbstractNoteWithStringHandler:) inttype: type intuserid: userid strdata: data intpagenum: pagenum intpagesize: pagesize];
    
    
    
}

-(void)OpreationAbstractNoteWithStringHandler:(id)value
{
    // Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"There is an error:%@", value);
        NSString * errorinfo = [value localizedDescription];
        if ([errorinfo isEqualToString:@"Could not connect to the server."]) {
            [[MTStatusBarOverlay sharedOverlay] postErrorMessage:@"Could not connect to the server" duration:2.0 animated:YES];
//            UIAlertView * alert = [UIAlertView alloc];
//            [alert initWithTitle:@"Notice"
//                         message:@"A connection failure occurred."
//                        delegate:self
//               cancelButtonTitle:@"Close"
//               otherButtonTitles:nil];
//            [alert show];
//            [alert release];
        }
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"There is an soapfault:%@", value);
		return;
	}				
    //handle the data
    NSString * str = (NSString *)value;
    
    
    
//    NSLog(@"step 2 return data %@", str);
    
    
    
    
    NSObject * obj = [str JSONValue];
    ReturnSyncResults * r = [ReturnSyncResults ResultsWithJsonDictionary:(NSDictionary *)obj];
    
    
    
//    NSLog(@"step 2 return r.tip is %@ and r.serversucessflag is %@", r.resulttip, r.serversucessflag);
    
    
    
    if ([r.serversucessflag isEqualToString:@"T"]) {
        //op the local data
        if (r.resultabstractnum > 0) {
            [self OpreationAbstractNoteWithFetchServerId:r.resultabstractvalue];
        }
        
        //[fd opLocalDataWithFlag:[NSNumber numberWithInt:2]];
        
        [self syncPushLocalDataSucess];
    }
}

- (void)syncDeleteServerDataWithNoOperationFlag
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *noteEntity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:managedObjectContext];
    [request setEntity:noteEntity];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(local_flag = %@) AND ((op_log = %@) OR (op_log = %@))", @"2", @"2", @"3"];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *objects = [managedObjectContext executeFetchRequest:request error:&error];
    
    
    if (objects == nil) {
        // Handle the error.
        NSLog(@"ERRORS IN SEARCH INSIDE VIEW SUCCESS");
    }
    else {
        if ([objects count] > 0) {
            for (NSManagedObject *obj in objects) {
                [managedObjectContext deleteObject:obj];
                [managedObjectContext save:nil];
            }
        }
    }
    
}

- (void)SyncDeleteServerDataWithUnContainSimpleData:(NSString *)query
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *noteEntity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:managedObjectContext];
    [request setEntity:noteEntity];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:query];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *objects = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (objects == nil) {
        // Handle the error.
        NSLog(@"ERRORS IN SEARCH INSIDE VIEW SUCCESS");
    }
    else {
        if ([objects count] > 0) {
            for (NSManagedObject *obj in objects) {
                [managedObjectContext deleteObject:obj];
                [managedObjectContext save:nil];
            }
        }
    }

}

//step 2
- (void)syncPushLocalData
{
    NSArray * array = [fd fetchLocalData];
    tempAbstractNotes = [[NSArray alloc] initWithArray:array];
    int count = [array count];
    NSString * notelist = [fd generateNote:array];
    ReturnSyncResults * syncResults = [[ReturnSyncResults alloc] init];
    syncResults.resultflag = 200;
    syncResults.resultabstractnum = 0;
    syncResults.resultabstractvalue = @"";
    syncResults.resultinstanotenum = count;
    syncResults.resultinstanotevalue = notelist;
    syncResults.resulttip = @"sucess";
    syncResults.serversucessflag = @"T";
    syncResults.clientsucessflag = @"T";
    syncResults.lastsynctime = [self getLastSyncTime:NO];
    
    int type = 2;
    int userid = [self getUserId];
    //the is no meaning actually. but Yan make this rule when work in lab.so we inherit this rule
    int pagesize = 100;
    int pagenum = 1;
    NSString * data = [syncResults initJsonString];
    InoteSyncInstanoteSynchronyServiceService * service = [InoteSyncInstanoteSynchronyServiceService service];
    service.username = aUserName;
    service.password = aPassword;
    service.logging = YES;
    
    [[MTStatusBarOverlay sharedInstance] postMessage:@"Still Processing..." animated:YES];
    [MTStatusBarOverlay sharedInstance].progress = 0.5;
    
    [service instanoteSynchronyService:self action:@selector(syncPushLocalDataHandler:) inttype: type intuserid: userid strdata: data intpagenum: pagenum intpagesize: pagesize];
    
    /*
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *noteEntity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:managedObjectContext];
    [request setEntity:noteEntity];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(local_flag = %@) AND ((op_log = %@) OR (op_log = %@))", @"1", @"1", @"2"];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *objects = [managedObjectContext executeFetchRequest:request error:&error];
    
    int count = [objects count];
    
    if (count > 0) {
        
        NSMutableString * jsonlist = [[NSMutableString alloc] init];
        int i = 1;
        for (Note * note in objects) {
            
            NSMutableString * strnote = [[NSMutableString alloc] init];
            [strnote appendString:@"{"];
            if (note.note_id == 0) {
                [strnote appendFormat:@"\"noteId\": \"%@\",", @""];
            } else {
                [strnote appendFormat:@"\"noteId\": \"%@\",", note.note_id];
            }
            
            [strnote appendFormat:@"\"noteInfo\": \"%@\",", note.note_info];
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
                [jsonlist appendFormat:@"%@" ,strnote];
            } else {
                [jsonlist appendFormat:@"%@," ,strnote];
            }
            i ++;
            
        }
        
        int flag = 200;
        int abnum = 0;
        int instnum = count;
        NSString * abvalue = @"";
        NSString * serverflag = @"F";
        NSString * clientflag =@"F";
        NSString * tip = @"sucess";
        NSString * lastsync = [self getLastSyncTime:NO];
        
        
        NSString * jsondata = [self jsondataWithResultFlag:flag ResultAbstractnum:abnum ResultAbstractValue:abvalue ResultInstanoteNum:instnum Resultinstanotevalue:jsonlist Resulttip:tip ClientSucessFlag:clientflag ServerSucessFlag:serverflag LastSyncTime:lastsync];
        NSLog(@"first push data is %@", jsondata);
        
        InoteSyncInstanoteSynchronyServiceService * service = [InoteSyncInstanoteSynchronyServiceService service];
        service.username = aUserName;
        service.password = aPassword;
        service.logging = YES;
        
        int type = 2;
        int userid = [self getUserId];
        //the is no meaning actually. but Yan make this rule when work in lab.so we inherit this rule
        int pagesize = 100;
        int pagenum = 1;
        [service instanoteSynchronyService:self action:@selector(syncPushLocalDataHandler:) inttype: type intuserid: userid strdata: jsondata intpagenum: pagenum intpagesize: pagesize];
    }// end count is 0?
    else {
        NSLog(@"no local data sync mrak almost 601 row");
    }
     
     */
}

- (void)syncPushLocalDataHandler:(id)value
{
    // Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"There is an error:%@", value);
        NSString * errorinfo = [value localizedDescription];
        if ([errorinfo isEqualToString:@"Could not connect to the server."]) {
            [[MTStatusBarOverlay sharedOverlay] postErrorMessage:@"Could not connect to the server" duration:2.0 animated:YES];
//            UIAlertView * alert = [UIAlertView alloc];
//            [alert initWithTitle:@"Notice"
//                         message:@"A connection failure occurred."
//                        delegate:self
//               cancelButtonTitle:@"Close"
//               otherButtonTitles:nil];
//            [alert show];
//            [alert release];
        }
		return;
	}
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"There is an soapfault:%@", value);
		return;
	}
    //handle the data
    NSString * str = (NSString *)value;
    
    
    
    
//    NSLog(@"---------push local data return data---------------------- %@", str);
    
    
    
    
    
    NSObject * obj = [str JSONValue];
    
    ReturnSyncResults * r = [ReturnSyncResults ResultsWithJsonDictionary:(NSDictionary *)obj];
    
    if ([r.serversucessflag isEqualToString:@"T"]) {
        if (r.resultabstractnum > 0) {
            [self OpreationAbstractNoteWithFetchServerId:r.resultabstractvalue];
        }
        //[fd opLocalDataWithFlag:[NSNumber numberWithInt:2]];
        
        [self syncPushLocalDataSucess];
    }
}
- (void)syncPushLocalDataSucess
{
    ReturnSyncResults * syncResult = [[ReturnSyncResults alloc] init];
    syncResult.resultflag = 200;
    syncResult.resultabstractnum = 0;
    syncResult.resultabstractvalue = @"";
    syncResult.resultinstanotenum = 0;
    syncResult.resultinstanotevalue = @"";
    syncResult.resulttip = @"sucess";
    syncResult.lastsynctime = [self getLastSyncTime:NO];
    syncResult.serversucessflag = @"T";
    syncResult.clientsucessflag = @"T";// this is the only valuable
    
    InoteSyncInstanoteSynchronyServiceService * service = [InoteSyncInstanoteSynchronyServiceService service];
    service.username = aUserName;
    service.password = aPassword;
    service.logging = YES;
    
    int type = 3;
    int userid = [self getUserId];
    //the is no meaning actually. but Yan make this rule when work in lab.so we inherit this rule
    int pagesize = 100;
    int pagenum = 1;
    NSString * data = [syncResult initJsonString];
    
    // ...
    [[MTStatusBarOverlay sharedInstance] postImmediateFinishMessage:@"Synchronization Finished" duration:2.0 animated:YES];
    [MTStatusBarOverlay sharedInstance].progress = 1.0;
    
    [service instanoteSynchronyService:self action:@selector(syncPushLocalDataSucessHandler:) inttype: type intuserid: userid strdata: data intpagenum: pagenum intpagesize: pagesize];
    
}

- (void)syncPushLocalDataSucessHandler:(id)value
{
    // Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"There is an error:%@", value);
        NSString * errorinfo = [value localizedDescription];
        if ([errorinfo isEqualToString:@"Could not connect to the server."]) {
            [[MTStatusBarOverlay sharedOverlay] postErrorMessage:@"Could not connect to the server" duration:2.0 animated:YES];
//            UIAlertView * alert = [UIAlertView alloc];
//            [alert initWithTitle:@"Notice"
//                         message:@"A connection failure occurred."
//                        delegate:self
//               cancelButtonTitle:@"Close"
//               otherButtonTitles:nil];
//            [alert show];
//            [alert release];
        }
		return;
	}
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"There is an soapfault:%@", value);
		return;
	}
    NSString * str = (NSString *)value;
    NSObject * obj = [str JSONValue];
    ReturnSyncResults * r = [ReturnSyncResults ResultsWithJsonDictionary:(NSDictionary *)obj];
    
    if (![r.serversucessflag isEqualToString:@"T"]) {
        //roll back
        NSNumber * number = [NSNumber numberWithInt:1];
        [self opreationLocalDataWithFlag:number];
        
        [fd OpreationAbstractNoteWithString:tempabstractValue WithOp:[NSNumber numberWithInt:2]];
        
    } else {
        
        [self getLastSyncTime:YES];
        
        
        
//        NSLog(@"hello,world!");
    
    
    
    }
    
}






- (void)opreationLocalDataWithFlag:(NSNumber *)number
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *noteEntity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:managedObjectContext];
    [request setEntity:noteEntity];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(local_flag = %@) AND ((op_log = %@) OR (op_log = %@))", @"1", @"1", @"2"];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *objects = [managedObjectContext executeFetchRequest:request error:&error];
    for (Note * note in objects) {
        note.local_flag = number;
        NSError * error;
        if (![note.managedObjectContext save:&error]) {
            NSLog(@"error is %@", [error userInfo]);
        }
    }
    // if there is not roll back,
    if ([number intValue] == 2) {
        [self syncPushLocalDataSucess];
    }
    
    
}


- (void)fetch
{
    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}

- (void)isGoLogin
{
    //loginvc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * isLogin = [defaults objectForKey:aUserId];
    if (isLogin) {
        if ([isLogin intValue] == -1) {
            LoginViewController * loginvc = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginvc animated:NO];
            [loginvc release];
        } else {
            
            // put userid into static tempdata
            int uid = [self getUserId];
            [TempData setUserId:uid];
            [self fetch];
        }
    } else {
        LoginViewController * loginvc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginvc animated:NO];
        [loginvc release];
    }
}

#pragma mark - GestureRecognizer Selector

- (void)resignDisableViewOverlay
{
    [mDisableViewOverlay removeFromSuperview];
    [addInputView resignFirstResponder];
    addInputView.text = @"";
    [addInputView removeFromSuperview];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
}

- (void)addAction
{
//    mDisableViewOverlay.alpha = 0;
//    [self.navigationItem.rightBarButtonItem setEnabled:NO];
//    [self.view addSubview:mDisableViewOverlay];
//    [self.view addSubview:addInputView];
//    [addInputView becomeFirstResponder];
//    [UIView beginAnimations:@"FadeIn" context:nil];
//    [UIView setAnimationDuration:1.f];
//    mDisableViewOverlay.alpha = 0.6;  
//    [UIView commitAnimations];
    AddViewController * addvc = [[AddViewController alloc] init];
    UINavigationController * addvcNav = [[UINavigationController alloc] initWithRootViewController:addvc];
//    [self.navigationController pushViewController:addvc animated:YES];
    [self.navigationController presentModalViewController:addvcNav animated:YES];
    [addvcNav release];
    [addvc release];
}
//DetailViewController * detailvc = [[DetailViewController alloc] init];
//detailvc.note = note;
//[self.navigationController pushViewController:detailvc animated:YES];
//[detailvc release];


#pragma mark -
#pragma mark TextView delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    /*
    NSString *tx = textView.text;
    if ([@"\n" isEqualToString:text] == YES) {
        [self doAddNote:tx];
        [self resignDisableViewOverlay];
        return NO;
    }
     */
    return YES;
}

#pragma mark -
#pragma mark add core data

/*
- (void)doAddNote:(NSString *)text { 
    addNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:managedObjectContext];
    addNote.note_info = text;
    NSDate * now = [NSDate date];
    addNote.note_date = now;
    addNote.note_lastdate = now;
    addNote.note_source = [NSNumber numberWithInt:2];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:now];
    [dateFormatter release];
    
    addNote.str_notedate = strDate;
    addNote.str_note_lastdate = strDate;
    
    //note type def 0
    addNote.note_type = [NSNumber numberWithInt:2];
    addNote.op_log = [NSNumber numberWithInt:2];
    addNote.local_flag = [NSNumber numberWithInt:2];
    addNote.local_note_id = [NSNumber numberWithInt:1];
    
    NSError *error = nil;
    if (![addNote.managedObjectContext save:&error]) {
        NSLog(@"error when save %@, %@", error, [error userInfo]);
        abort();
    }
}
 
 */


/*

- (void)doAddNote:(NSString *)text
{
    InstanoteInstanoteWebServiceService* service = [InstanoteInstanoteWebServiceService service];
	service.logging = YES;
    service.username = aUserName;
	service.password = aPassword;
    
    int object = 2;//1 user 2 note
    int type = 1; //1:add 2:modify 3:delete 4:deleteall 5:getone 6:getlist
    int userid = 38; //handsomeocean@163.com
    NSString *email = @"";
    NSString *password = @"";
    NSString *userSource = @"";
    NSString *newPassword = @"";
    int noteid = 0;
    NSString *noteInfo = text;
    long notedate = 0;
    long lastdate = 0;
    short notesource = 2;// from ios
    int pagenum = 1;
    int pagesize = 0;
    NSString *active = @"";
    
    [service instanoteService:self 
                       action:@selector(instanoteServiceHandler_add:)
                    intobject:object 
                      inttype:type 
                    intuserid:userid 
                     stremail:email 
                      strpass:password 
                strusersource:userSource 
                   strnewpass:newPassword 
                       noteid:noteid 
                     noteinfo:noteInfo 
                     notedate:notedate 
                 notelastdate:lastdate 
                   notesource:notesource 
                   intpagenum:pagenum 
                  intpagesize:pagesize 
                    stractive:active];
    
    
}

- (void) instanoteServiceHandler_add: (id) value {
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		//NSLog(@"There is an error:%@", value);
        NSString * errorinfo = [value localizedDescription];
        if ([errorinfo isEqualToString:@"Could not connect to the server."]) {
            UIAlertView * alert = [UIAlertView alloc];
            [alert initWithTitle:@"Notice"
                         message:@"A connection failure occurred."
                        delegate:self
               cancelButtonTitle:@"Close"
               otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"There is an soapfault:%@", value);
		return;
	}				
    //handle the data
    NSString * data = (NSString *)value;
    NSObject * obj = [data JSONValue];
    
    ReturnResults * r = [ReturnResults ResultsWithJsonDictionary:(NSDictionary *)obj];
    NSDictionary * ary =  (NSDictionary *)r.data;
    //request an add operation. return an note entity. just one
    if ([ary count] == 1) {
        for (NSDictionary * dic in ary) {
            if (![dic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            //json to dic
            ResultNote * note = [ResultNote ResultsWithJsonDictionary:dic];
            // core date...
            addNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:managedObjectContext];
            addNote.note_id = note._noteId;
            addNote.note_info = note._noteInfo;
            addNote.note_date = note._noteDate;
            addNote.note_lastdate = note._noteLastdate;
            addNote.note_source = note._noteSource;
//            addNote.userinfo = 1;
            addNote.str_notedate = note._strNotedate;
            addNote.str_note_lastdate = note._strNoteLastdate;
            //note type def 0
            addNote.note_type = [NSNumber numberWithInt:0];
            addNote.op_log = [NSNumber numberWithInt:0];
            addNote.local_flag = [NSNumber numberWithInt:2];
            
            NSLog(@"%@", note._noteInfo);
            
        }//end for loop
    }//end if count equal 1
    if ([r.tip isEqualToString:@"ADD NOTE SUCCESS."]) {
        NSLog(@"");
    }
    
    
    //
    NSError *error = nil;
    if (![addNote.managedObjectContext save:&error]) {
        NSLog(@"error when save %@, %@", error, [error userInfo]);
        abort();
    }
    
}
 
 */


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    mDisableViewOverlay = nil;
    tapgr = nil;
    addInputView = nil;
    self.tableView = nil;
//    addNote = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
//     if (indexPath.section == 0) {
//         if (indexPath.row == 0) {
//             return NO;
//         }
//     }
     return YES;
 }


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         // Delete the row from the data source
         [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
     } else if (editingStyle == UITableViewCellEditingStyleInsert) {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = [[fetchedResultsController sections] count];
    
	if (count == 0) {
		count = 1;
	}
    return count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
	
    if ([[fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Dequeue or if necessary create a RecipeTableViewCell, then set its recipe to the recipe for the current row.
    static NSString *NoteCellIdentifier = @"RecipeCellIdentifier";
    
    BaseCell *noteCell = (BaseCell *)[self.tableView dequeueReusableCellWithIdentifier:NoteCellIdentifier];
    if (noteCell == nil) {
        noteCell = [[[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NoteCellIdentifier] autorelease];
		//noteCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [self configureCell:noteCell atIndexPath:indexPath];
    
    return noteCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell *cell = (BaseCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.cellheight) {
        return cell.cellheight;
    } else {
        return 40.f;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Note *note = (Note *)[fetchedResultsController objectAtIndexPath:indexPath];
    [self showNote:note animated:YES];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
        Note * note = [fetchedResultsController objectAtIndexPath:indexPath];
        if (note.local_flag == [NSNumber numberWithInt:1]) {
            //hah. here
            [context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
        } else {
            //
            Note * note = [fetchedResultsController objectAtIndexPath:indexPath];
            NSDate *nowdate = [NSDate date];
            note.note_lastdate = nowdate;
            NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease]; 
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            NSString *nowtimeStr = [formatter stringFromDate:nowdate];
            note.str_note_lastdate = nowtimeStr;
            
            note.op_log = [NSNumber numberWithInt:3];
            
//            [note.managedObjectContext save:nil];
            
        }

		// Save the context.
		NSError *error;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}   
}
- (BOOL)viewDeckControllerWillOpenRightView:(IIViewDeckController*)viewDeckController animated:(BOOL)animated
{
    return FALSE;
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(op_log != %d)", 3];
        [fetchRequest setPredicate:predicate];
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"note_date" ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
        //[self queryLocalCount];
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
	
	return fetchedResultsController;
}    


/**
 Delegate methods of NSFetchedResultsController to respond to additions, removals and so on.
 */

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller is about to start sending change notifications, so prepare the table view for updates.
	[self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	UITableView *tv = self.tableView;
	
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[tv insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeUpdate:
			[self configureCell:((BaseCell *)[tv cellForRowAtIndexPath:indexPath]) atIndexPath:indexPath];
            break;
			
		case NSFetchedResultsChangeMove:
			[tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tv insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
	}
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller has sent all current change notifications, so tell the table view to process all updates.
	[self.tableView endUpdates];
}

#pragma mark
#pragma mark - interface method delegate

- (void)showNote:(Note *)note animated:(BOOL)animated
{
    DetailViewController * detailvc = [[DetailViewController alloc] init];
    detailvc.note = note;
    [self.navigationController pushViewController:detailvc animated:YES];
    [detailvc release];
}
- (void)configureCell:(BaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if ([fetchedResultsController.fetchedObjects count] > indexPath.row) {
        Note * note = (Note *)[fetchedResultsController objectAtIndexPath:indexPath];
        cell.note = note;
        [cell layoutSubviews];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[fetchedResultsController release];
	[managedObjectContext release];
    
    [mDisableViewOverlay release];
    [tapgr release];
    [addInputView release];
    [tableView release];
//    [addNote release];
    [super dealloc];
}

#pragma mark -
#pragma mark view will appear

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!fd) {
        fd = [[NoteFetchDelegate alloc] initWithManagedObjectContext:self.managedObjectContext];
    }
    
    [self viewCallBackAction];
    
    [self isGoLogin];
}

- (void)viewCallBackAction
{
    if ([TempData OpMessage] == @"sync") {
        [self StartSync];
    }
    if ([TempData OpMessage] == @"aboutus") {
        AboutUsViewController * aboutusvc = [[AboutUsViewController alloc] init];
        [self.navigationController presentModalViewController:aboutusvc animated:YES];
        [aboutusvc release];
    }
    if ([TempData OpMessage] == @"feedback") {
        FeedbackViewController * feedbackvc = [[FeedbackViewController alloc] init];
        [self.navigationController presentModalViewController:feedbackvc animated:YES];
        [feedbackvc release];
    }
    [TempData setOpMessage:@""];
}

- (NSString *)GenerateJsonWithDictionary:(NSMutableDictionary *)dic
{
    NSError *error; 
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic 
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
        return @"";
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
}


- (NSString *)GenerateJsonWithDictionary_SBJSON:(NSMutableDictionary  *)dic
{
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    
    NSString *jsonString = [jsonWriter stringWithObject:dic];  
    
    [jsonWriter release];
    
    return jsonString;
}

- (NSString *)jsondataWithResultFlag:(int)flag ResultAbstractnum:(int)abstractnum ResultAbstractValue:(NSString *)abstractvalue ResultInstanoteNum:(int)instanotenum Resultinstanotevalue:(NSString *)instanotevalue Resulttip:(NSString *)tip ClientSucessFlag:(NSString *)clientsucessflag ServerSucessFlag:(NSString *)serversucessflag LastSyncTime:(NSString *)synctime
{
    NSMutableString * jsondata = [[NSMutableString alloc] init];
    
    [jsondata appendString:@"{"];
    
        [jsondata appendFormat:@"\"resultflag\": \"%d\",", flag];
        [jsondata appendFormat:@"\"resultinstanotenum\": \"%d\",", instanotenum];
        [jsondata appendFormat:@"\"resultabstractvalue\": [%@],", abstractvalue];
        [jsondata appendFormat:@"\"resulttip\": \"%@\",", tip];
        [jsondata appendFormat:@"\"clientsucessflag\": \"%@\",", clientsucessflag];
        [jsondata appendFormat:@"\"serversucessflag\": \"%@\",", serversucessflag];
        [jsondata appendFormat:@"\"resultabstractnum\": \"%d\",", abstractnum];
        [jsondata appendFormat:@"\"resultinstanotevalue\": [%@],", instanotevalue];
        [jsondata appendFormat:@"\"lastsynctime\": \"%@\"", synctime];
    [jsondata appendString:@"}"];
    
    return jsondata;
}


@end
