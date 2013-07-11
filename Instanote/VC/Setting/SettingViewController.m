//
//  SettingViewController.m
//  Instanote
//
//  Created by CMD on 3/15/12.
//  Copyright (c) 2012 Mantung. All rights reserved.
//

#import "SettingViewController.h"
#import "UMFeedbackViewController.h"
#import "AboutUsViewController.h"
#import "VersionViewController.h"
#import "LoginViewController.h"
#import "MobClick.h"

@implementation SettingViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];
    //[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    _umFeedback = [UMFeedback sharedInstance];
    [_umFeedback setAppkey:UMENG_APPKEY delegate:self];
    
    UIView * bgview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    bgview.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundView = bgview;
    [bgview release];
}

- (UIBarButtonItem *)leftButtonForCenterPanel {
    UIImage *faceImage = [UIImage imageNamed:@"done_button.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    [face setTitle:@"完成" forState:UIControlStateNormal];
    face.bounds = CGRectMake( 10, 8, 40, 25  );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (void)backAction
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)initrightButton
{
    UIBarButtonItem * rightbutton = [[UIBarButtonItem alloc] init];
    rightbutton.style = UIBarButtonItemStyleBordered;
    if ([self getUserIdandEmail]) {
        rightbutton.title = @"登出";
        rightbutton.target = self;
        rightbutton.action = @selector(signoutAction);
    } else {
        rightbutton.title = @"登陆";
        rightbutton.target = self;
        rightbutton.action = @selector(signinAction);
    }
    self.navigationItem.rightBarButtonItem = rightbutton;
    
}

- (void)signinAction
{
    LoginViewController *loginvc = [[LoginViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginvc];
    navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
    [loginvc release];
    
}

/**生成列表表格 Height**/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            return NSLocalizedString(@"Yizu", nil);
        } break;
        case 1: {
            return @"About";
        } break;
        default: {
            return @"";
        } break;
    }
}
 
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingCell"] autorelease];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont fontWithName:FONT_NAME size:16];
        cell.textLabel.textColor = [UIColor blackColor];
        
        if (indexPath.row == 0) {
            cell.textLabel.text = NSLocalizedString(@"more_update", nil);
        } else if (indexPath.row == 1) {
            cell.textLabel.text = NSLocalizedString(@"more_about", nil);
        }
    }
    return cell;
}
/**表格点击事件处理,查微博的详细信息**/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self versionAction];
    } else if (indexPath.row == 1) {
        [self aboutAction];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark tableviewcelldidselect methods
- (void)aboutAction
{
    VersionViewController * versionController = [[VersionViewController alloc] init];
    [self.navigationController pushViewController:versionController animated:YES];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:versionController];
//    [self presentModalViewController:navigationController animated:YES];
//    [navigationController release];
    [versionController release];
}

- (void)feedbackAction
{
    UMFeedbackViewController *feedbackViewController = [[UMFeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
    [feedbackViewController release];
}

- (void)versionAction
{
    [MobClick checkUpdate];
}

- (void)signoutAction
{
    [self confrimlogout];
}

- (void)goCover
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"-1" forKey:aUserId];
    [defaults setObject:@"" forKey:@"email"];
    [defaults synchronize];
    [self.tabBarController setSelectedIndex:0];
}

- (void)confrimlogout
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"more_logout_title", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"more_logout_no", nil) otherButtonTitles:NSLocalizedString(@"more_logout_yes", nil), nil];
    [alert show];
}

- (void)modalView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self goCover];
    }
    [alertView release];
}

-(BOOL)getUserIdandEmail
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSUInteger userid = [def integerForKey:aUserId];
    NSString * email  =[def objectForKey:@"email"];
//    NSLog(@"%d,%@", userid, email);
    if (userid && [email length]) {
        return YES;
    } else {
        return NO;
    }
}


@end
