//
//  ForgotPasswordViewController.m
//  Instanote
//
//  Created by Man Tung on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
#import "NSDictionaryAdditions.h"
#import "WeiboClient.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

@synthesize tableview;
@synthesize usernameInputField;
@synthesize sendButton;

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
    
    self.title = NSLocalizedString(@"forgot_title", @"");
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    
    if (!tableview) {
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
        tableview.delegate = self;
        tableview.dataSource = self;
        UIView * bkview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        bkview.backgroundColor = [UIColor whiteColor];
        tableview.backgroundView = bkview;
        [self.view insertSubview:tableview atIndex:0];
    }
    
    if (!usernameInputField) {
        usernameInputField = [[UITextField alloc] init];
        [usernameInputField setFrame:CGRectMake(20, 15, 280, 20)];
        [usernameInputField setPlaceholder:NSLocalizedString(@"forgot_username_input_placehold", @"")];
        [usernameInputField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [usernameInputField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [usernameInputField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [usernameInputField setReturnKeyType:UIReturnKeyDone];
        [usernameInputField setKeyboardType:UIKeyboardTypeEmailAddress];
        [usernameInputField setDelegate:self];
        [usernameInputField setFont:[UIFont fontWithName:FONT_NAME size:15]];
    }
    if (!sendButton) {
        sendButton = [[UIButton alloc] init];
        [sendButton setTitle:NSLocalizedString(@"forgot_button", @"") forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [sendButton setFrame:CGRectMake(60, 7, 200, 30)];
        [sendButton.titleLabel setTextAlignment:UITextAlignmentCenter];
        [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sendButton addTarget:self action:(@selector(sendAction)) forControlEvents:UIControlEventTouchUpInside];
    }
    if (!msgview) {
        msgview = [[msgView alloc] initWithFrame:CGRectMake(10, 10, 300, 46)];
        [self.view addSubview:msgview];
    }
//    if (!activityindicator) {
//        activityindicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [activityindicator setFrame:CGRectMake(185, 98, 20, 20)];
//        [self.view insertSubview:activityindicator atIndex:1];
//    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.row == 0 && indexPath.section == 0) {
        CellIdentifier = @"UserNameCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            [cell setSelectionStyle:UITableViewCellEditingStyleNone];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            //cell.userInteractionEnabled = NO;
            [cell addSubview:usernameInputField];
        }
    } else if (indexPath.row == 0 && indexPath.section == 1) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            [cell setSelectionStyle:UITableViewCellEditingStyleNone];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            [cell addSubview:sendButton];
        }
    } else {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell ...
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [usernameInputField becomeFirstResponder];
    //    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



- (void)sendAction
{
    NSString * text = usernameInputField.text;
    if ([text length] > 0) {
        [self sendService];
    } else {
        [msgview setText:NSLocalizedString(@"forgot_username_input_empty", @"")];
        [msgview show];
    }
}

#pragma mark - convert json

- (void)convertdata:(NSObject *)data
{
    NSDictionary * dic = (NSDictionary *)data;
    int status;
    status = [dic getIntValueForKey:@"status" defaultValue:0];
    if ([self statusto:status]) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"forgot_message_checkmail", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"more_logout_yes", nil) otherButtonTitles:nil, nil];
        [alert show];
        
        [alert release];
        
        [self backAction];
    }
}

//- (void)backAction
//{
////    [self.navigationController popViewControllerAnimated:NO];
//    [self dismissModalViewControllerAnimated:YES];
//}

- (BOOL)statusto:(int)status
{
    BOOL flag = false;
    switch (status) {
        case 0:
            [msgview setText:NSLocalizedString(@"login_username_not_exist", nil)];
            [msgview show];
            break;
        case 1:
            flag = true;
            break;
        case 2:
            [msgview setText:@"用户密码错误"];
            [msgview show];
            break;
        case 3:
            break;
        default:
            break;
    }
    return flag;
    
}

- (void)sendService
{
    //here is soap methods
    NSString *email = usernameInputField.text;
    
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
    
    [client forgot:email];
    
}

- (void)loadDataFinished:(WeiboClient *)sender
                     obj:(NSObject*)obj
{
    
    if (sender.hasError) {
        [sender alerterror:NSLocalizedString(@"errormessage", nil)];
    }
    else {
        
        NSDictionary * dic = (NSDictionary *)obj;
        int status;
        status = [dic getIntValueForKey:@"status" defaultValue:0];
        if ([self statusto:status]) {
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"forgot_message_checkmail", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"more_logout_yes", nil) otherButtonTitles:nil, nil];
            [alert show];
            
            [alert release];
            
            [self backAction];
        }

        
//        [self convertdata:obj];
    }
}


//- (void)alerterror:(NSString *)title
//{
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"more_logout_yes", nil) otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
//}


- (void)msgShow:(UIView *)view
{
    [view setHidden:NO];
    [self performSelector:@selector(hiddenView:) withObject:view afterDelay:2.f];
}


- (void)hiddenView:(UIView *)view;
{
    [view setHidden:YES];
}

- (void)backAction
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark textfield delegate

//- (void)textViewDidChange:(UITextView *)textView
//{
//    NSInteger textlength = [[textfield text] length];
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString * text = textField.text;
    // need regex to pattern email?
    if (text) {
        if ([text length] > 0) {
            //validate the text as email address
            [self sendAction];
            
            return YES;
        } else {
            if ([text length] == 0) {
                [msgview setText:NSLocalizedString(@"forgot_username_input_empty", @"")];
                [msgview show];
            }
            return NO;
        }
    } else {
        return NO;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    //sendButton = nil;
    tableview = nil;
    usernameInputField = nil;
    sendButton = nil;
    
    //msg
    msgview = nil;
//    activityindicator = nil;
}

- (void)dealloc
{
    [super dealloc];
    [sendButton release];
    [usernameInputField release];
    [tableview release];
    
    [msgview release];
//    [activityindicator release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
