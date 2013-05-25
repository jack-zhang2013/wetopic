//
//  ListsViewController.h
//  Instanote
//
//  Created by CMD on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShakingView.h"
#import "Note.h"
#import "DetailViewController.h"
#import "BaseCell.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface ListsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ShakeDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate>
{
    
    UITableView * tableview;
    UIView * emptydataView;
    
    ShakingView * shakingshaking;
    
    UIView * mDisableViewOverlay;
    UITapGestureRecognizer * tapgr;
    //InputTextField;
    UITextField * inputTextField;
    NSMutableArray * noteTempArray;
    
    
@private
    NSDateFormatter *dateFormatter;
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UITableView * tableview;
@property (nonatomic, retain) ShakingView * shakingshaking;
@property (nonatomic, retain) UITextField * inputTextField;
@property (nonatomic, readonly, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSMutableArray * noteTempArray;

- (void)addWithAction;

- (void)resignDisableViewOverlay;

- (void)fetch;

- (void)isGoLogin;


- (void)showNote:(Note *)note animated:(BOOL)animated;
- (void)configureCell:(BaseCell *)cell atIndexPath:(NSIndexPath *)indexPath;


@end
