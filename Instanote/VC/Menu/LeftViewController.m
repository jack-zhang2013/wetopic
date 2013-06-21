//
//  LeftViewController.m
//  Chinesetoday
//
//  Created by CMD on 6/3/13.
//  Copyright (c) 2013 Man Tung. All rights reserved.
//

#import "LeftViewController.h"
#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "IndexViewController.h"
#import "VersionViewController.h"
#import "UMFeedbackViewController.h"
#import "LoginViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"


@interface LeftViewController ()

@end

@implementation LeftViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIButton *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(218, 14, 20, 20)];
    [settingButton setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(tapSettingView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:settingButton];
    [settingButton release];
    
//    UIButton *noticeButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 14, 20, 20)];
//    [noticeButton setImage:[UIImage imageNamed:@"notice.png"] forState:UIControlStateNormal];
//    [self.navigationController.navigationBar addSubview:noticeButton];
//    [noticeButton release];
    
    if (!userName) {
        userName = [[UILabel alloc] init];
        userName.font = [UIFont fontWithName:FONT_NAME size:15];
        userName.textColor = [UIColor grayColor];
    }
    
    if (!userDesc) {
        userDesc = [[UILabel alloc] init];
        userDesc.font = [UIFont fontWithName:FONT_NAME size:12];
        userDesc.textColor = [UIColor grayColor];
    }
    
    if (!avatarView) {
        avatarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nobody.png"]];
    }
    
    if (!avatarButton) {
        avatarButton = [[UIButton alloc] init];
    }
    
    [self fillUserInfo];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.row == 0) {
        height = 65.f;
    } else {
        height = 40.f;
    }
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor grayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            
            avatarButton.frame = CGRectMake(0, 0, 240, 40);
            
            avatarView.frame = CGRectMake(10, 10, 40, 40);
            
            userName.frame = CGRectMake(55, 12, 200, 16);
            userName.text = @"登陆就可以显示用户名啦";
            
            userDesc.frame = CGRectMake(55, 33, 220, 13);
            userDesc.text = @"点击登陆";
            
            [cell addSubview:avatarView];
            [cell addSubview:avatarButton];
            [cell addSubview:userName];
            [cell addSubview:userDesc];
            
        } else if (indexPath.row == 1) {
            
            UIImageView * homeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home.png"]];
            homeImageView.frame = CGRectMake(10, 10, 20, 20);
            UILabel * homeLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 150, 14)];
            homeLable.text = @"首页";
            homeLable.font = [UIFont fontWithName:FONT_NAME size:15];
            
            [cell addSubview:homeImageView];
            [cell addSubview:homeLable];
            
            [homeImageView release];
            [homeLable release];
            
            
        } else if (indexPath.row == 2) {
            
            UIImageView * settingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feedback.png"]];
            settingImageView.frame = CGRectMake(10, 10, 20, 20);
            UILabel * settingLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 150, 14)];
            settingLable.text = @"反馈";
            settingLable.font = [UIFont fontWithName:FONT_NAME size:15];
            
            [cell addSubview:settingImageView];
            [cell addSubview:settingLable];
            
            [settingImageView release];
            [settingLable release];
            
        } else if (indexPath.row == 3) {
            
            UIImageView * aboutImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about.png"]];
            aboutImageView.frame = CGRectMake(10, 10, 20, 20);
            UILabel * aboutLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 150, 14)];
            aboutLable.text = @"关于";
            aboutLable.font = [UIFont fontWithName:FONT_NAME size:15];
            
            [cell addSubview:aboutImageView];
            [cell addSubview:aboutLable];
            
            [aboutImageView release];
            [aboutLable release];
        }
        
    }
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        
        
    } else if (indexPath.row == 1) {
        [self tapHomeView];
    } else if (indexPath.row == 2) {
        [self tapFeedbackView];
    } else if (indexPath.row == 3) {
        [self tapAboutView];
    }
}

- (void)tapAboutView {
    SettingViewController *aboutvc = [[SettingViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:aboutvc];
    //[nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    [self presentModalViewController:nav animated:YES];
    [aboutvc release];
    [nav release];
}

- (void)tapHomeView {
    IndexViewController *homevc = [[IndexViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:homevc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    self.sidePanelController.centerPanel = nav;
    [homevc release];
    [nav release];
}

- (void)tapSettingView {
    SettingViewController *settingvc = [[SettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:settingvc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    [self presentModalViewController:nav animated:YES];
    [settingvc release];
    [nav release];
}

- (void)tapFeedbackView {
    UMFeedbackViewController *feedbackViewController = [[UMFeedbackViewController alloc] initWithNibName:@"UMFeedbackViewController" bundle:nil];
    feedbackViewController.appkey = UMENG_APPKEY;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [self presentModalViewController:navigationController animated:YES];
}

#pragma mark
#pragma userinfo

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

- (NSString *)getUserImage
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString *userimage = [def objectForKey:@"image"];
    if (userimage) {
        return userimage;
    } else {
        return @"";
    }
}

- (void)fillUserInfo
{
    if ([self getUserIdandEmail]) {
        NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
        NSString *userimage = [def objectForKey:@"image"];
        NSString *username = [def objectForKey:@"nick"];
        NSString *userdesc = [def objectForKey:@"what"];
        userName.text = username;
        userDesc.text = userdesc;
        
        NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, userimage];
        [avatarView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [avatarButton addTarget:self action:@selector(userAction) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [avatarButton addTarget:self action:@selector(signinAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}


-(BOOL)getUserIdandEmail
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSUInteger userid = [def integerForKey:aUserId];
    NSString * email  =[def objectForKey:@"email"];
    //    NSString * image = [def objectForKey:@"image"];
    //    NSLog(@"%d,%@,%@", userid, email, image);
    if (userid && [email length]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)avatarAction
{
    if ([self getUserIdandEmail]) {
        [self userAction];
        
    } else {
        [self signinAction];
    }
}

- (void)userAction
{
    //push to userview
}

- (void)signinAction
{
    LoginViewController *loginvc = [[LoginViewController alloc] init];
    loginvc.finishAction = @selector(viewDidLoad);
    loginvc.finishTarget = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginvc];
    navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
    [loginvc release];
}






@end
