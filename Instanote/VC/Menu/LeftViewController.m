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
#import "CircleListViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

@interface LeftViewController ()

@end

@implementation LeftViewController
@synthesize userName, userDesc, avatarView;

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
    [settingButton setImage:[UIImage imageNamed:@"about.png"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(tapSettingView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:settingButton];
    [settingButton release];
    
    //    UIButton *noticeButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 14, 20, 20)];
    //    [noticeButton setImage:[UIImage imageNamed:@"notice.png"] forState:UIControlStateNormal];
    //    [self.navigationController.navigationBar addSubview:noticeButton];
    //    [noticeButton release];
    
}

- (void)refreshTableview
{
    if ([self getUserIdandEmail]) {
        UsersEntity * userentity = [self getUserEntity];
        NSString *image = userentity.image;
        NSString *otheraccountuserimage = userentity.otheraccountuserimage;
        NSString *username = userentity.nick;
        NSString *userdesc = userentity.what;
        
        userName.text = [username length] > 0 ? username : @"用户名";
        userDesc.text = [userdesc length] > 0 ? userdesc : @"还没有个人简介";
        
        if (![image length] && ![otheraccountuserimage length]) {
            
            [avatarView setImage:[UIImage imageNamed:@"nobody_male.png"]];
            
        } else {
            
            NSString *realimage = image ? image : otheraccountuserimage;
            NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, realimage];
            [avatarView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"nobody_male.png"]];
        }
        
    } else {
        userName.text = @"用户尚未登录";
        userDesc.text = @"个人素描";
        [avatarView setImage:[UIImage imageNamed:@"nobody_male.png"]];
    }
    
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
            
            if (!avatarView) {
                CGFloat userImageViewSize = 40.f;
                avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, userImageViewSize, userImageViewSize)];
                [avatarView.layer setMasksToBounds:YES];
                CGFloat radius = userImageViewSize / 2;
                [avatarView.layer setCornerRadius:radius];
            }
            
            if (!userName) {
                userName = [[UILabel alloc] init];
                userName.font = [UIFont fontWithName:FONT_NAME size:17];
                userName.frame = CGRectMake(50, 7, 200, 20);
            }

            
            if (!userDesc) {
                userDesc = [[UILabel alloc] init];
                userDesc.font = [UIFont fontWithName:FONT_NAME size:11];
                userDesc.textColor = [UIColor grayColor];
                userDesc.frame = CGRectMake(50, 30, 220, 12);
            }
            
            [self refreshTableview];
            
            [cell addSubview:avatarView];
            [cell addSubview:userName];
            [cell addSubview:userDesc];
            
            
        } else if (indexPath.row == 1) {
            
            UIImageView * homeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_clock.png"]];
            homeImageView.frame = CGRectMake(11, 11, 18, 18);
            UILabel * homeLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 150, 14)];
            homeLable.text = @"最新话题";
            homeLable.font = [UIFont fontWithName:FONT_NAME size:15];
            
            [cell addSubview:homeImageView];
            [cell addSubview:homeLable];
            
            [homeImageView release];
            [homeLable release];
            
            
        } else if (indexPath.row == 2) {
            
            UIImageView * settingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fire.png"]];
            settingImageView.frame = CGRectMake(10, 9, 20, 20);
            UILabel * settingLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 150, 14)];
            settingLable.text = @"热门话题";
            settingLable.font = [UIFont fontWithName:FONT_NAME size:15];
            
            [cell addSubview:settingImageView];
            [cell addSubview:settingLable];
            
            [settingImageView release];
            [settingLable release];
            
        } else if (indexPath.row == 3) {
            
            UIImageView * settingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feedback.png"]];
            settingImageView.frame = CGRectMake(10, 9, 20, 20);
            UILabel * settingLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 150, 14)];
            settingLable.text = @"反馈";
            settingLable.font = [UIFont fontWithName:FONT_NAME size:15];
            
            [cell addSubview:settingImageView];
            [cell addSubview:settingLable];
            
            [settingImageView release];
            [settingLable release];
            
        } else if (indexPath.row == 4) {
            
            UIImageView * aboutImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting.png"]];
            aboutImageView.frame = CGRectMake(10, 10, 20, 20);
            UILabel * aboutLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 13, 150, 14)];
            aboutLable.text = @"设置";
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
        [self circleListView];
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
    loginvc.finishAction = @selector(refreshTableview);
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

- (void)circleListView
{
    CircleListViewController *circlevc = [[CircleListViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:circlevc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"circle_banner.png"] forBarMetrics:UIBarMetricsDefault];
    [self presentModalViewController:nav animated:YES];
    [circlevc release];
    [nav release];
}

- (void)tapHelp
{
    
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
    UsersEntity * userentity = [self getUserEntity];
//    uservc.userentity = userentity;
    uservc.userId = userentity.userid;
    uservc.usertype = 1;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:uservc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    self.sidePanelController.centerPanel = nav;
    [nav release];
    [uservc release];
    
}

#pragma mark
#pragma userinfo

- (UsersEntity *)getUserEntity
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    UsersEntity * userentity = [[UsersEntity alloc] init];
    userentity.email = [def stringForKey:@"email"];
    userentity.image = [def stringForKey:@"image"];
    userentity.nick = [def stringForKey:@"nick"];
    userentity.otheraccountuserimage = [def stringForKey:@"otheraccountuserimage"];
    userentity.password = [def stringForKey:@"password"];
    userentity.otheraccount = [def integerForKey:@"otheraccount"];
    userentity.otheraccountypeid = [def integerForKey:@"otheraccountypeid"];
    userentity.sex = [def integerForKey:@"sex"];
    userentity.registertime = [def integerForKey:@"registertime"];
    userentity.userid = [def integerForKey:@"userid"];
    userentity.userlevel = [def integerForKey:@"userlevel"];
    userentity.address = [def stringForKey:@"address"];
    userentity.hobby = [def stringForKey:@"hobby"];
    userentity.what = [def stringForKey:@"what"];
    userentity.website = [def stringForKey:@"website"];
    userentity.covertype = [userentity.website length] > 0 ? [self covertype:userentity.website] : 0;
    return userentity;
}

- (int)covertype:(NSString *)ws
{
    NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    int value = [[[ws substringFromIndex:10] stringByTrimmingCharactersInSet:nonDigits] intValue];
    return value;
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
    if ([self getUserIdandEmail]) {
        
        [self userAction];
        
    } else {
        [self signinAction];
    }
}

- (void)dealloc
{
    [super dealloc];
    [avatarView release];
    [userName release];
    [userDesc release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    avatarView = nil;
    userName = nil;
    userDesc = nil;
    
}

@end
