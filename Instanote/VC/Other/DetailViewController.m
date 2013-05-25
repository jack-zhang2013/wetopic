//
//  DetailViewController.m
//  Instanote
//
//  Created by Man Tung on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "Note.h"
#import "UILabel+Extensions.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize finishTarget,finishAction;
@synthesize addInput = addInput;
@synthesize countAddInputLabel = countAddInputLabel;
@synthesize saveButton = saveButton;
@synthesize note;

- (NSDateFormatter *)dateFormatter {
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    return dateFormatter;
}

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
    if (!addInput) {
        addInput = [[UITextView alloc] init];
        [addInput setFrame:CGRectMake(5, 5, 310, 130)];
        [addInput setFont:[UIFont fontWithName:@"Arial" size:17]];
        [addInput setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [addInput setReturnKeyType:UIReturnKeyDone];
        [addInput becomeFirstResponder];
        [addInput setDelegate:self];
        [self.view addSubview:addInput];
    }
    
    if (!countAddInputLabel) {
        countAddInputLabel = [[UILabel alloc] init];
        [countAddInputLabel setFrame:CGRectMake(250, 130 + 15, 60, 15)];
        [countAddInputLabel setBackgroundColor:[UIColor clearColor]];
        [countAddInputLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        [countAddInputLabel setTextAlignment:UITextAlignmentRight];
        [countAddInputLabel setText:@"0"];
        [countAddInputLabel setTextColor:[UIColor grayColor]];
        [self.view addSubview:countAddInputLabel];
    }
    
    if (!saveButton) {
        saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" 
                                                      style:UIBarButtonSystemItemSave 
                                                     target:self 
                                                     action:(@selector(saveAction))];
//        self.navigationItem.rightBarButtonItem = saveButton;
    }
    
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    NSString * drafttext = (NSString *)[defaults objectForKey:SAVEDRAFTSTRING];
//    if (drafttext || [drafttext length]) {
//        [addInput setText:drafttext];
//        [countAddInputLabel setText:[NSString stringWithFormat:@"%i", [drafttext length]]];
//        //[self.navigationItem.rightBarButtonItem setEnabled:YES];//useless
//    } else {
//        [self.navigationItem.rightBarButtonItem setEnabled:NO];
//    }

}

#pragma mark TextView delegate

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger textlength = [[textView text] length];
    //int len = 140 - (int)textlength;
    if (textlength > 0) {
        //enable savebutton
        if (!self.navigationItem.rightBarButtonItem.enabled) {
            [self.navigationItem.rightBarButtonItem setEnabled:YES];
        }
        [countAddInputLabel setText:[NSString stringWithFormat:@"%i", textlength]];
    } else {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [countAddInputLabel setText:@"0"];
    } 
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

//- (void)saveAction
//{
//    NSString *text = [addInput text];
//    if ([text length] > 0) {
//        note.content = text;
//        NSError *error = nil;
//        if (![note.managedObjectContext save:&error]) {
//            NSLog(@"error when save %@, %@", error, [error userInfo]);
//            abort();
//        }
//        [self disCardDraftAction];
//    }
//    NSLog(@"save method run?");
//}

- (void)saveAtion:(NSString *)text
{
    note.note_info = text;
    note.op_log = [NSNumber numberWithInt:2]; //0 no operation 1 add 2 modify 3 delete
    NSDate *nowdate = [NSDate date];
    note.note_lastdate = nowdate;
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];   
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *nowtimeStr = [formatter stringFromDate:nowdate];
    note.str_note_lastdate = nowtimeStr;
    
    NSError *error = nil;
    if (![note.managedObjectContext save:&error]) {
        NSLog(@"error when save %@, %@", error, [error userInfo]);
        abort();
    }
    [self disCardDraftAction];
}

- (void)saveDraftAction
{
    [actionsheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [actionsheet showInView:self.tabBarController.view];
}

- (void)disCardDraftAction
{
    [self.navigationController popViewControllerAnimated:YES];
//    [addInput setText:@""];
//    [countAddInputLabel setText:@"0"];
    
}
- (void)saveToDraftAction
{
//    NSString *text = [addInput text];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:text forKey:SAVEDRAFTSTRING];
//    [defaults synchronize];
    
    [self.tabBarController setSelectedIndex:0];
    
}


#pragma mark -
#pragma textview delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *tx = textView.text;
    if ([@"\n" isEqualToString:text] == YES) {
        [self saveAtion:tx];
        return NO;
    }
    return YES;
}


- (void)dealloc
{
    [super dealloc];
    [addInput release];
    [countAddInputLabel release];
    [saveButton release];
    [actionsheet release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [addInput becomeFirstResponder];
    NSString * drafttext = note.note_info;
    if (drafttext || [drafttext length]) {
        [addInput setText:drafttext];
        [countAddInputLabel setText:[NSString stringWithFormat:@"%i", [drafttext length]]];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    addInput = nil;
    countAddInputLabel = nil;
    saveButton = nil;
    actionsheet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




@end
