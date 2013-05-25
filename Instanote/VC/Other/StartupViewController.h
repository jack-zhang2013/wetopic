//
//  StartupViewController.h
//  Instanote
//
//  Created by CMD on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NoteFetchDelegate.h"
#import "TempData.h"
//UIStatusBar
#import "MTStatusBarOverlay.h"

@class Note;
@class BaseCell;

@interface StartupViewController : UIViewController <UITableViewDelegate,UITableViewDataSource , UITextViewDelegate, UIImagePickerControllerDelegate, NSFetchedResultsControllerDelegate, MTStatusBarOverlayDelegate>
{
    
//    Note * addNote;
    UITableView *tableView;
    
    //add view
    UIView * mDisableViewOverlay;
    UITapGestureRecognizer * tapgr;
    UITextView * addInputView;
    
    NoteFetchDelegate * fd;
    
    NSString * tempabstractValue; 
    
    NSArray * tempAbstractNotes;
    
@private
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    
}


@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;
//@property (nonatomic, retain) Note * addNote;
@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) NoteFetchDelegate * fd;

// the start action of synchronize
- (void)StartSync;

//- (void)synchronizeNote;



//- (void)queryLocalCount;

//step 1
- (void)syncPushLocalSimpleData;

//step 2
- (void)syncPushLocalData;
- (void)syncPushLocalDataSucess;


- (BOOL)OpreationNoteWithString:(NSString *)string;
- (void)OpreationAbstractNoteWithString:(NSString *)string;


- (NSString *)jsondataWithResultFlag:(int)flag ResultAbstractnum:(int)abstractnum ResultAbstractValue:(NSString *)abstractvalue ResultInstanoteNum:(int)instanotenum Resultinstanotevalue:(NSString *)instanotevalue Resulttip:(NSString *)tip ClientSucessFlag:(NSString *)clientsucessflag ServerSucessFlag:(NSString *)serversucessflag LastSyncTime:(NSString *)synctime;

- (void)isGoLogin;

- (void)addAction;

- (void)showNote:(Note *)note animated:(BOOL)animated;
- (void)configureCell:(BaseCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)viewDeckControllerWillOpenRightView:(IIViewDeckController*) viewDeckController animated:(BOOL)animated;
@property (nonatomic, retain) UIPopoverController* popoverController;

@end
