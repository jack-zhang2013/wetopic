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
#import "UserViewController.h"
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
    //    [settingButton addTarget:self action:@selector(tapSettingView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:settingButton];
    [settingButton release];
    
    //    UIButton *noticeButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 14, 20, 20)];
    //    [noticeButton setImage:[UIImage imageNamed:@"notice.png"] forState:UIControlStateNormal];
    //    [self.navigationController.navigationBar addSubview:noticeButton];
    //    [noticeButton release];
    
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
        height = 50.f;
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            
            UIButton *avatarButton = [[UIButton alloc] init];
            avatarButton.frame = CGRectMake(0, 0, 240, 40);
            
            UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
            
            UILabel *userName = [[UILabel alloc] init];
            userName.font = [UIFont fontWithName:FONT_NAME size:20];
            userName.frame = CGRectMake(50, 8, 200, 20);
            
            UILabel *userDesc = [[UILabel alloc] init];
            userDesc.font = [UIFont fontWithName:FONT_NAME size:11];
            userDesc.textColor = [UIColor grayColor];
            userDesc.frame = CGRectMake(50, 30, 220, 12);
            
            if ([self getUserIdandEmail]) {
                NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
                NSString *image = [def objectForKey:@"image"];
                NSString *otheraccountuserimage = [def objectForKey:@"otheraccountuserimage"];
                NSString *username = [def objectForKey:@"nick"];
                NSString *userdesc = [def objectForKey:@"what"];
                userdesc = [userdesc length] > 0 ? userdesc : @"还没有个人简介";
                
                userName.text = username;
                userDesc.text = userdesc;
                
                if (![image length] && ![otheraccountuserimage length]) {
                    
                    [avatarView setImage:[UIImage imageNamed:@"nobody_male.png"]];
                    
                } else {
                    NSString *realimage = image ? image : otheraccountuserimage;
                    NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, realimage];
                    [avatarView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"nobody_male.png"]];
                }
                
                [avatarButton addTarget:self action:@selector(userAction) forControlEvents:UIControlEventTouchUpInside];
                
            } else {
                
                [avatarButton addTarget:self action:@selector(signinAction) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [cell addSubview:avatarView];
            [cell addSubview:avatarButton];
            [cell addSubview:userName];
            [cell addSubview:userDesc];
            
            [avatarView release];
            [avatarButton release];
            [userName release];
            [userDesc release];
            
            
        } else if (indexPath.row == 1) {
            
            UIImageView * homeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list.png"]];
            homeImageView.frame = CGRectMake(14, 13, 14, 14);
            UILabel * homeLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 150, 14)];
            homeLable.text = @"最新话题";
            homeLable.font = [UIFont fontWithName:FONT_NAME size:15];
            
            [cell addSubview:homeImageView];
            [cell addSubview:homeLable];
            
            [homeImageView release];
            [homeLable release];
            
            
        } else if (indexPath.row == 2) {
            
            UIImageView * settingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fire.png"]];
            settingImageView.frame = CGRectMake(10, 10, 20, 20);
            UILabel * settingLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 150, 14)];
            settingLable.text = @"热门话题";
            settingLable.font = [UIFont fontWithName:FONT_NAME size:15];
            
            [cell addSubview:settingImageView];
            [cell addSubview:settingLable];
            
            [settingImageView release];
            [settingLable release];
            
        } else if (indexPath.row == 3) {
            
            UIImageView * settingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feedback.png"]];
            settingImageView.frame = CGRectMake(10, 10, 20, 20);
            UILabel * settingLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 150, 14)];
            settingLable.text = @"反馈";
            settingLable.font = [UIFont fontWithName:FONT_NAME size:15];
            
            [cell addSubview:settingImageView];
            [cell addSubview:settingLable];
            
            [settingImageView release];
            [settingLable release];
            
        } else if (indexPath.row == 4) {
            
            UIImageView * aboutImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about.png"]];
            aboutImageView.frame = CGRectMake(10, 10, 20, 20);
            UILabel * aboutLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 150, 14)];
            aboutLable.text = @"关于";
            aboutLable.font = [UIFont fontWithName:FONT_NAME size:15];
            
            [cell addSubview:aboutImageView];
            [cell addSubview:aboutLable];
            
            [aboutImageView release];
            [aboutLable release];
        } else {
            //
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        [self avatarAction];
        
    } else if (indexPath.row == 1) {
        [self tapHomeView];
    } else if (indexPath.row == 2) {
        [self tapHomeViewHot];
    } else if (indexPath.row == 3) {
        [self tapFeedbackView];
    } else if (indexPath.row == 4) {
        [self tapSettingView];
    }
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
    homevc.pagetype = 1;
    homevc.title = @"最新话题";
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:homevc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    self.sidePanelController.centerPanel = nav;
    [homevc release];
    [nav release];
}

- (void)tapHomeViewHot {
    IndexViewController *homevc = [[IndexViewController alloc] init];
    homevc.pagetype = 2;
    homevc.title = @"热门话题";
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

- (void)userAction
{
    UserViewController *uservc = [[UserViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:uservc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    self.sidePanelController.centerPanel = nav;
    [nav release];
    [uservc release];
    
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

-(BOOL)getUserIdandEmail
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSUInteger userid = [def integerForKey:aUserId];
    NSString * email  =[def objectForKey:@"email"];
    if (userid && [email length]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)avatarAction
{
    NSLog(@"avataraction");
    if ([self getUserIdandEmail]) {
        
        [self userAction];
        
    } else {
        [self signinAction];
    }
}



@end
