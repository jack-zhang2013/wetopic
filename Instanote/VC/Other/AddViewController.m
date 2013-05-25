//
//  AddViewController.m
//  Instanote
//
//  Created by Man Tung on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize managedObjectContext;
@synthesize finishTarget,finishAction;
@synthesize addInput = addInput;
//@synthesize countAddInputLabel = countAddInputLabel;
@synthesize backButton = backButton;
@synthesize saveButton = saveButton;
@synthesize note;
@synthesize delegate;
@synthesize deckDelegate;
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        if (managedObjectContext == nil) {
            managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        }
           }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Add Note";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancal" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveAction)];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
  	// Do any additional setup after loading the view.
    if (!addInput) {
        addInput = [[UITextView alloc] init];
        [addInput setFrame:CGRectMake(5, 5, 310, 180)];
        [addInput setFont:[UIFont fontWithName:@"Arial" size:17]];
        [addInput setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [addInput setReturnKeyType:UIReturnKeyDone];
        [addInput becomeFirstResponder];
        [addInput setDelegate:self];
        [addInput setText:@""];
        [self.view addSubview:addInput];
    }
    
//    if (!countAddInputLabel) {
//        countAddInputLabel = [[UILabel alloc] init];
//        [countAddInputLabel setFrame:CGRectMake(5, 5, 310, 150)];
//        [countAddInputLabel setBackgroundColor:[UIColor clearColor]];
//        [countAddInputLabel setFont:[UIFont fontWithName:@"Arial" size:13]];
//        [countAddInputLabel setTextAlignment:UITextAlignmentRight];
//        [countAddInputLabel setText:@"0"];
//        [countAddInputLabel setTextColor:[UIColor grayColor]];
//        [self.view addSubview:countAddInputLabel];
//    }
    
//    if (!actionsheet) {
//        actionsheet = [[UIActionSheet alloc] initWithTitle:@"Do you want to Save Draft?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Discard" otherButtonTitles:@"Save As Draft", nil];
//    }
//    
//    if (!saveButton) {
//        saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" 
//                                                      style:UIBarButtonSystemItemSave 
//                                                      target:self 
//                                                      action:(@selector(saveAction))];
//       // self.navigationItem.rightBarButtonItem = saveButton;
//    }
//    
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    NSString * drafttext = (NSString *)[defaults objectForKey:SAVEDRAFTSTRING];
//    if (drafttext || [drafttext length]) {
//        [addInput setText:drafttext];
//        [countAddInputLabel setText:[NSString stringWithFormat:@"%i", [drafttext length]]];
//        //[self.navigationItem.rightBarButtonItem setEnabled:YES];//useless
//    } else {
//        [self.navigationItem.rightBarButtonItem setEnabled:NO];
//    }
    
//    if (!backButton) {
//        backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
//                                                     style:UIBarButtonSystemItemUndo
//                                                     target:self
//                                                     action:@selector(backAction)];
//        self.navigationItem.leftBarButtonItem = backButton;
//    }
    
    
}

- (void)back
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [super dealloc];
    [addInput release];
  //  [countAddInputLabel release];
 //   [saveButton release];
//    [backButton release];
//    [actionsheet release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [addInput becomeFirstResponder];
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    NSString * drafttext = (NSString *)[defaults objectForKey:SAVEDRAFTSTRING];
//    if (drafttext || [drafttext length]) {
//        [addInput setText:drafttext];
//        [countAddInputLabel setText:[NSString stringWithFormat:@"%i", [drafttext length]]];
//    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    addInput = nil;
//    countAddInputLabel = nil;
    saveButton = nil;
    backButton = nil;
    actionsheet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark TextView delegate

- (void)textViewDidChange:(UITextView *)textView
{
    NSString * text = textView.text;
    if ([text length] > 0) {
        if (!self.navigationItem.rightBarButtonItem.enabled) {
            [self.navigationItem.rightBarButtonItem setEnabled:YES];
        }
    }
//    NSInteger textlength = [[textView text] length];
//    //int len = 140 - (int)textlength;
//    if (textlength > 0) {
//        //enable savebutton
//        if (!self.navigationItem.rightBarButtonItem.enabled) {
//            [self.navigationItem.rightBarButtonItem setEnabled:YES];
//        }
//        [countAddInputLabel setText:[NSString stringWithFormat:@"%i", textlength]];
//    } else {
//        [self.navigationItem.rightBarButtonItem setEnabled:NO];
//        [countAddInputLabel setText:@"0"];
//    } 
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    NSInteger lengthWithTextField = [textField.text length];
//    if (lengthWithTextField > 0) {
//        countAddInputLabel.text = (NSString *)(140 - lengthWithTextField);
//        return YES;
//    } else {
//        return NO;
//    }
//}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    NSString *text = [textField text];
//    if ([text length] > 0) {
//        [addInput resignFirstResponder];
//        return YES;
//    } else {
//        return NO;
//    }
//    
//}

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    NSLog(@"textfielddid beginediting");
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    NSLog(@"textfielddidendediting");
//}

#pragma mark navbar buttons

- (void)mydelegateAction
{
    if ([finishTarget retainCount] > 0 && [finishTarget respondsToSelector:finishAction]) {
        [finishTarget performSelector:finishAction  withObject:nil];
    }
    else {
        [self.tabBarController setSelectedIndex:0];
    }
}

- (void)backAction
{
    [note.managedObjectContext deleteObject:note];
	NSError *error = nil;
	if (![note.managedObjectContext save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    [self.delegate noteAddViewController:self didAddNote:nil];
    NSString *text = [addInput text];
    if ([text length] > 0) {
        [self saveDraftAction];
    } else {
        [self.tabBarController setSelectedIndex:0];
    }
    
}
- (void)saveAction
{
    NSString * text = addInput.text;
    if ([text length] > 0) {
        [self doAddNote:text];
    }
    [self disCardDraftAction];
}
//{
//    NSString *text = [addInput text];
//    NSLog(@"%@",text);
//    if ([text length] > 0) {
//        note.note_info = text;
//        //NSDate *currenttime = [NSDate date];
//        //note.time = currenttime;
//        NSError *error = nil;
//        if (![note.managedObjectContext save:&error]) {
//            NSLog(@"error when save %@, %@", error, [error userInfo]);
//            abort();
//        }
//        [self.delegate noteAddViewController:self didAddNote:note];
//        
//        //[self disCardDraftAction];
//    }
//}

- (void)saveDraftAction
{
//    [actionsheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
//    [actionsheet showInView:self.tabBarController.view];
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)disCardDraftAction
{
    //empty
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:@"" forKey:SAVEDRAFTSTRING];
//    [defaults synchronize];
//    if (!draft || ![draft length]) {
//        
//    }
//    [addInput setText:@""];
//    [countAddInputLabel setText:@"0"];
//    [self.navigationItem.rightBarButtonItem setEnabled:NO];
//    
//    [self.tabBarController setSelectedIndex:0];
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (void)saveToDraftAction
{
//    NSString *text = [addInput text];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    //NSString * draft = (NSString *)[defaults objectForKey:SAVEDRAFTSTRING];
//    [defaults setValue:text forKey:SAVEDRAFTSTRING];
//    [defaults synchronize];
//    
//    [self.tabBarController setSelectedIndex:0];
    
}

#pragma mark -
#pragma textview delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *tx = textView.text;
    if ([@"\n" isEqualToString:text] == YES) {
//        [self saveAtion:tx];
        [self doAddNote:tx];
        [self disCardDraftAction];
        return NO;
    }
    return YES;
}


#pragma mark actionsheet delegate
- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self performSelector:@selector(disCardDraftAction)];
            break;
        case 1:
            [self performSelector:@selector(saveToDraftAction)];
            break;
        default:
            break;
    }
    
}

#define aUserId @"userid"

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

- (void)doAddNote:(NSString *)text {
    
    if ([text length] > 0) {
        
        addNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:managedObjectContext];
        
        addNote.user_id = [NSNumber numberWithInt:[self getUserId]];
        addNote.note_info = text;
        NSDate * now = [NSDate date];
        addNote.note_date = now;
        addNote.note_lastdate = now;
        addNote.note_source = [NSNumber numberWithInt:2];
        addNote.note_id = [NSNumber numberWithInt:0];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:now];
        [dateFormatter release];
        
        addNote.str_notedate = strDate;
        addNote.str_note_lastdate = strDate;
        
        //note type def 0
        addNote.note_type = [NSNumber numberWithInt:2];
        addNote.op_log = [NSNumber numberWithInt:2];
        addNote.local_flag = [NSNumber numberWithInt:1];
//        addNote.local_note_id = [NSNumber numberWithInt:1];
        
        NSError *error = nil;
        if (![addNote.managedObjectContext save:&error]) {
            NSLog(@"error when save %@, %@", error, [error userInfo]);
            abort();
        }
        
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer 
{
    return true;
}

- (void)viewDeckController:(IIViewDeckController*)viewDeckController applyShadow:(CALayer*)shadowLayer withBounds:(CGRect)rect
{
    
}

- (void)viewDeckController:(IIViewDeckController*)viewDeckController didPanToOffset:(CGFloat)offset
{
}

- (void)viewDeckController:(IIViewDeckController*)viewDeckController slideOffsetChanged:(CGFloat)offset
{
}
- (void)viewDeckController:(IIViewDeckController *)viewDeckController didBounceWithClosingController:(UIViewController*)openController
{
    
}
- (BOOL)viewDeckControllerWillOpenLeftView:(IIViewDeckController*)viewDeckController animated:(BOOL)animated
{
    return FALSE;
}
- (void)viewDeckControllerDidOpenLeftView:(IIViewDeckController*)viewDeckController animated:(BOOL)animated
{
    
}
- (BOOL)viewDeckControllerWillCloseLeftView:(IIViewDeckController*)viewDeckController animated:(BOOL)animated
{
    return FALSE;
}
- (void)viewDeckControllerDidCloseLeftView:(IIViewDeckController*)viewDeckController animated:(BOOL)animated;
{
    
}
- (BOOL)viewDeckControllerWillOpenRightView:(IIViewDeckController*)viewDeckController animated:(BOOL)animated
{
    return FALSE;
}
- (void)viewDeckControllerDidOpenRightView:(IIViewDeckController*)viewDeckController animated:(BOOL)animated
{
    
}
- (BOOL)viewDeckControllerWillCloseRightView:(IIViewDeckController*)viewDeckController animated:(BOOL)animated
{
    return FALSE;
}
- (void)viewDeckControllerDidCloseRightView:(IIViewDeckController*)viewDeckController animated:(BOOL)animated
{
    
}
- (void)viewDeckControllerDidShowCenterView:(IIViewDeckController*)viewDeckController animated:(BOOL)animated
{ 
    
}


@end
