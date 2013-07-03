//
//  UserViewController.m
//  Instanote
//
//  Created by Man Tung on 3/21/13.
//
//

#import "UserViewController.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#import "IndexViewController.h"
#import "WeiboClient.h"
#import "NSDictionaryAdditions.h"
#import "UILabel+Extensions.h"

@interface UserViewController ()

@end

@implementation UserViewController

@synthesize userentity,userId;

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
    if (!userentity) {
        [self userService];
    } else {
        [self refreshTableView];
    }
}

- (void)userService
{
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
    
    [client user:userId];
    
}

- (void)loadDataFinished:(WeiboClient *)sender
                     obj:(NSObject*)obj
{
    
    if (sender.hasError) {
        [self alerterror:NSLocalizedString(@"errormessage", nil)];
    }
    else {
        [self convertdata:obj];
    }
}

- (void)convertdata:(NSObject *)data
{
    NSLog(@"%@", data);
    NSDictionary * dic = (NSDictionary *)data;
    int status = [dic getIntValueForKey:@"status" defaultValue:0];
    if (status == 1) {
        NSDictionary * data = [dic objectForKey:@"data"];
        NSDictionary * user = [data objectForKey:@"user"];
        userentity = [UsersEntity entityWithJsonDictionary:user];
    }
    [self refreshTableView];
}


- (void)alerterror:(NSString *)title
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"more_logout_yes", nil) otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    } else {
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.row == 0 && indexPath.section == 0) {
        height = 160.f;
    } else if (indexPath.row == 2 && indexPath.section == 1) {
        height = 100.f;
    } else if (indexPath.row == 3 && indexPath.section == 1) {
        height = 180.f;
    } else {
        height = 50.f;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static CGFloat labelHight = 16.f;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            
            if (!userCoverImage) {
                userCoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
                userCoverImage.image = [UIImage imageNamed:@"user_cover_default.png"];
                
            }
            [cell addSubview:userCoverImage];
            
            CGFloat userImageViewSize = 70.f;
            CGFloat userImageViewFromTop = 20.f;
            
            if (!userImageView) {
                userImageView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - userImageViewSize) / 2, userImageViewFromTop, userImageViewSize, userImageViewSize)];
                userImageView.image = [UIImage imageNamed:@"nobody_male.png"];
                userImageView.backgroundColor = [UIColor whiteColor];
                [userImageView.layer setMasksToBounds:YES];
                CGFloat radius = userImageViewSize / 2;
                [userImageView.layer setCornerRadius:radius];
                [userImageView.layer setBorderWidth:3.0];
                [userImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
            }
            [cell addSubview:userImageView];
            
            if (!userNameLabel) {
                userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, userImageViewSize + userImageViewFromTop + 3, 320, 20)];
                userNameLabel.textAlignment = NSTextAlignmentCenter;
                userNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
                userNameLabel.textColor = [UIColor whiteColor];
                userNameLabel.backgroundColor = [UIColor clearColor];
                userNameLabel.text = @"用户名";
            }
            [cell addSubview:userNameLabel];
            
            UIView * bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 320, 40)];
            bannerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_cover_banner"]];
            [cell addSubview:bannerView];
            
            
            UIButton * allNewsFeedButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, 120, 40)];
            [allNewsFeedButton addTarget:self action:@selector(allNewsFeedAction) forControlEvents:UIControlEventTouchUpInside];
            [bannerView addSubview:allNewsFeedButton];
//            [allNewsFeedButton release];
            
            UILabel * allNewsFeedLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 12, 134, 16)];
            allNewsFeedLabel.text = @"所有动态";
            allNewsFeedLabel.backgroundColor = [UIColor clearColor];
            allNewsFeedLabel.textAlignment = NSTextAlignmentRight;
            allNewsFeedLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            allNewsFeedLabel.textColor = [UIColor whiteColor];
            [bannerView addSubview:allNewsFeedLabel];
            [allNewsFeedLabel release];
            
            UIImageView * allNewsFeedAccessory = [[UIImageView alloc] initWithFrame:CGRectMake(295, 13, 14, 14)];
            allNewsFeedAccessory.image = [UIImage imageNamed:@"user_cover_arrow"];
            [bannerView addSubview:allNewsFeedAccessory];
            [allNewsFeedAccessory release];
            
            [bannerView release];
            
        }
         
        else if (indexPath.section == 1 && indexPath.row == 0) {
            
            UILabel * innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 80, labelHight)];
            innerLabel.text = @"逸族身份";
            innerLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            innerLabel.textColor = [UIColor grayColor];
            [cell addSubview:innerLabel];
            [innerLabel release];
            
            if (!userLevelLabel) {
                userLevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 13, 205, labelHight)];
                userLevelLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            }
            
            [cell addSubview:userLevelLabel];
            
        }
        else if (indexPath.section == 1 && indexPath.row == 1) {
            
            UILabel * innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 80, labelHight)];
            innerLabel.text = @"所在城市";
            innerLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            innerLabel.textColor = [UIColor grayColor];
            [cell addSubview:innerLabel];
            [innerLabel release];
            
            if (!userAddressLabel) {
                userAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 13, 205, labelHight)];
                userAddressLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            }
            [cell addSubview:userAddressLabel];
            
        }
        else if (indexPath.section == 1 && indexPath.row == 2) {
            
            UILabel * innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 80, labelHight)];
            innerLabel.text = @"兴趣爱好";
            innerLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            innerLabel.textColor = [UIColor grayColor];
            [cell addSubview:innerLabel];
            [innerLabel release];
            
            if (!userHobbyLable) {
                userHobbyLable = [[UILabel alloc] initWithFrame:CGRectMake(95, 13, 205, labelHight)];
                userHobbyLable.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            }
            
            
            [userHobbyLable sizeToFitFixedWidth:205.f];
            
            [cell addSubview:userHobbyLable];
            
            
        }
        else if (indexPath.section == 1 && indexPath.row == 3) {
            
            UILabel * innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 80, labelHight)];
            innerLabel.text = @"个人素描";
            innerLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            innerLabel.textColor = [UIColor grayColor];
            [cell addSubview:innerLabel];
            [innerLabel release];
            
            if (!userDescLablel) {
                userDescLablel = [[UILabel alloc] initWithFrame:CGRectMake(95, 13, 205, labelHight)];
                userDescLablel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            }
            
            [userDescLablel sizeToFitFixedWidth:205.f];
            
            [cell addSubview:userDescLablel];
            
        }
    }
    // Configure the cell...
    
    return cell;
}

#pragma mark - actions

- (void)allNewsFeedAction
{
    IndexViewController *homevc = [[IndexViewController alloc] init];
    homevc.pagetype = 1;
    homevc.title = @"用户动态";
    homevc.indexUserId = userentity.userid;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:homevc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    homevc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [self presentModalViewController:nav animated:YES];
    [homevc release];
    [nav release];
}

- (void)backAction
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)refreshTableView
{
    userCoverImage.image = [UIImage imageNamed:@"user_cover_default.png"];
    
    userImageView.image = [UIImage imageNamed:@"nobody_male.png"];
    
    NSString *ws = userentity.website;
    if ([ws length] > 0) {
        char index_usercover = [ws characterAtIndex:([ws length] - 5)];
        NSLog(@"%c", index_usercover);
    }
    userHobbyLable.text = userentity.hobby;
    
    userDescLablel.text = userentity.what;
    
    userLevelLabel.text = userentity.sex ? @"骑士" : @"千金";
}

- (void)dealloc
{
    [super dealloc];
    [userCoverImage release];
    [userImageView release];
    [userNameLabel release];
    [userLevelLabel release];
    [userAddressLabel release];
    [userDescLablel release];
    [userHobbyLable release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    userCoverImage = nil;
    userImageView = nil;
    userNameLabel = nil;
    userLevelLabel = nil;
    userAddressLabel = nil;
    userDescLablel = nil;
    userHobbyLable = nil;
}

@end
