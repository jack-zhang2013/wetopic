//
//  AddViewController.h
//  Instanote
//
//  Created by Man Tung on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Note.h"
#import "IIViewDeckController.h"

#define SAVEDRAFTSTRING @"saveDraftString"

@class Note;
@protocol NoteAddDelegate;
@protocol IIViewDeckControllerDelegate;


@interface AddViewController : UIViewController <UITextViewDelegate, NSFetchedResultsControllerDelegate> {
//<UITextViewDelegate, UIActionSheetDelegate> {
//    NSFetchedResultsController * fetchedResultsController;
    NSManagedObjectContext * managedObjectContext;
    
    UITextView * addInput;
    UILabel * countAddInputLabel;
    
    UIActionSheet * actionsheet;
    //NSString * draftString;
//    
//    UIBarButtonItem * saveButton;
//    UIBarButtonItem * backButton;
    
    Note * note;
    id <NoteAddDelegate> delegate;    
    Note * addNote;
    
    id <IIViewDeckControllerDelegate>deckDelegate;

    
}

@property (nonatomic,assign) id finishTarget;
@property (nonatomic,assign) SEL finishAction; 
@property (nonatomic, retain) UITextView * addInput;
//@property (nonatomic, retain) UILabel * countAddInputLabel;
@property (nonatomic, retain) UIBarButtonItem * saveButton;
@property (nonatomic, retain) UIBarButtonItem * backButton;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) Note * note;
@property (nonatomic, assign) id <NoteAddDelegate> delegate;
@property (nonatomic, assign) id <IIViewDeckControllerDelegate> deckDelegate;

- (void)backAction;
- (void)saveAction;
- (void)saveDraftAction;
- (void)disCardDraftAction;
- (void)saveToDraftAction;

- (void)mydelegateAction;
- (void)doAddNote:(NSString *)text;
@end

@protocol NoteAddDelegate <NSObject>
// recipe == nil on cancel
- (void)noteAddViewController:(AddViewController *)addVc didAddNote:(Note *)note;

@end
