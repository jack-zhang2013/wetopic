//
//  AddViewController.m
//  Instanote
//
//  Created by Man Tung on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WeiboClient.h"
#import "NSDictionaryAdditions.h"
#import "UsersEntity.h"

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize finishTarget,finishAction;
@synthesize addInput;
//@synthesize countAddInputLabel;
@synthesize topicid;
//@synthesize backButton = backButton;
//@synthesize saveButton = saveButton;
//@synthesize note;
//@synthesize delegate;


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
    
    self.title = @"添加评论";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleBordered target:self action:@selector(saveAction)];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
  	// Do any additional setup after loading the view.
    if (!addInput) {
        addInput = [[UITextView alloc] init];
        [addInput setFrame:CGRectMake(5, 5, 310, 180)];
        [addInput setFont:[UIFont fontWithName:FONT_NAME size:17]];
        [addInput setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [addInput setReturnKeyType:UIReturnKeyDone];
        addInput.delegate = self;
        [addInput setText:@""];
//        [addInput becomeFirstResponder];
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
    
}

- (void)loadDataFinished:(WeiboClient *)sender
                     obj:(NSObject*)obj
{
    
    if (sender.hasError) {
        [sender alerterror:NSLocalizedString(@"errormessage", nil)];
    }
    else {
        [self convertdata:obj];
    }
}


//- (void)alerterror:(NSString *)title
//{
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"more_logout_yes", nil) otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
//}

- (void)convertdata:(NSObject *)obj
{
    
//    NSLog(@"%@", obj);
    
    int status = [(NSDictionary *)obj getIntValueForKey:@"status" defaultValue:0];
//    NSString * msg = [(NSDictionary *)obj getStringValueForKey:@"msg" defaultValue:0];
    if (status == 0) {
        NSDictionary *jsondata = [(NSDictionary *)obj objectForKey:@"data"];
        NSDictionary *user = [jsondata objectForKey:@"user"];
        UsersEntity *userentity = [UsersEntity entityWithJsonDictionary:user];
        [self saveUser:userentity];
        [self mydelegateAction];
        [self back];
    } else if (status == 1) {
        [self mydelegateAction];
        [self back];
    } else {
        [self back];
    }
    
}


- (void)saveUser:(UsersEntity *)user
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:user.email forKey:@"email"];
    [def setObject:user.image forKey:@"image"];
    [def setObject:user.nick forKey:@"nick"];
    [def setObject:user.otheraccountflag forKey:@"otheraccountflag"];
    [def setObject:user.otheraccountuserimage forKey:@"otheraccountuserimage"];
    [def setObject:user.password forKey:@"password"];
    [def setObject:user.what forKey:@"what"];
    [def setInteger:user.otheraccount forKey:@"otheraccount"];
    [def setInteger:user.otheraccountypeid forKey:@"otheraccountypeid"];
    [def setInteger:user.sex forKey:@"sex"];
    [def setInteger:user.registertime forKey:@"registertime"];
    [def setInteger:user.userid forKey:aUserId];
    [def setInteger:user.userlevel forKey:@"userlevel"];
    [def synchronize];
}

- (void)back
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [super dealloc];
    [addInput release];
//    [countAddInputLabel release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [addInput becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    addInput = nil;
//    countAddInputLabel = nil;
//    saveButton = nil;
//    backButton = nil;
//    actionsheet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark navbar buttons

- (void)mydelegateAction
{
    if ([finishTarget retainCount] > 0 && [finishTarget respondsToSelector:finishAction]) {
        [finishTarget performSelector:finishAction  withObject:nil];
    }
}

- (void)saveAction
{
    NSString * text = addInput.text;
    if ([text length] > 0) {
        [self doAddNote:text];
    }
}

#pragma mark -
#pragma textview delegate

- (void)textViewDidChange:(UITextView *)textView
{
    NSString * text = textView.text;
    if ([text length] > 0) {
        if (!self.navigationItem.rightBarButtonItem.enabled) {
            [self.navigationItem.rightBarButtonItem setEnabled:YES];
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *tx = textView.text;
    if ([@"\n" isEqualToString:text] == YES) {
        [self doAddNote:tx];
        return NO;
    }
    return YES;
}

- (void)doAddNote:(NSString *)text {
    
    if ([text length] > 0) {
        WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
        [client addComment:topicid userId:[self getUserId] commentContent:text Source:1];
    }
}

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

@end
