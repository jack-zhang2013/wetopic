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
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reLoadTableView) name:@"load user info" object:nil];
    
    if (!userCoverImage) {
        userCoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    }
    
    CGFloat userImageViewSize = 70.f;
    CGFloat userImageViewFromTop = 20.f;
    CGFloat labelHight = 16.f;
    
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

    if (!userNameLabel) {
        userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, userImageViewSize + userImageViewFromTop + 3, 320, 20)];
        userNameLabel.textAlignment = NSTextAlignmentCenter;
        userNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        userNameLabel.textColor = [UIColor whiteColor];
        userNameLabel.backgroundColor = [UIColor clearColor];
        //                userNameLabel.text = @"用户名";
    }
    
    if (!userLevelLabel) {
        userLevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 13, 205, labelHight)];
        userLevelLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
    }
    
    if (!userAddressLabel) {
        userAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 11, 205, labelHight)];
        userAddressLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
    }
    
    if (!userHobbyLable) {
        userHobbyLable = [[UILabel alloc] initWithFrame:CGRectMake(95, 11, 205, labelHight)];
        userHobbyLable.font = [UIFont fontWithName:FONT_NAME size:labelHight];
    }
    
    if (!userDescLablel) {
        userDescLablel = [[UILabel alloc] initWithFrame:CGRectMake(95, 11, 205, labelHight)];
        userDescLablel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
    }
    [self loadUserEntity];
}

- (void)loadUserEntity
{
    if (!userentity) {
        
        self.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];
        
        [self userService];
        
    } else {
        
        self.navigationItem.rightBarButtonItem = [self rightButtonForCenterPanel];
        
        [self refreshTableView];
    }
}

- (void)reLoadTableView
{
    [self.tableView reloadData];
}

- (void)allNewsFeedAction
{
    IndexViewController *homevc = [[IndexViewController alloc] init];
    homevc.pagetype = 1;
    homevc.title = @"用户动态";
    homevc.indexUserId = userId;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:homevc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    homevc.navigationItem.leftBarButtonItem = [self doneButton];
    [self presentModalViewController:nav animated:YES];
    [homevc release];
    [nav release];

}

- (UIBarButtonItem *)doneButton {
    UIImage *faceImage = [UIImage imageNamed:@"done_button.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 12, 12, 40, 25 );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (UIBarButtonItem *)leftButtonForCenterPanel {
    UIImage *faceImage = [UIImage imageNamed:@"arrow.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 12, 12, 24, 16 );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(backActionWithPush) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (UIBarButtonItem *)rightButtonForCenterPanel {
    UIImage *faceImage = [UIImage imageNamed:@"user_setting.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake(0, 10, 22, 22);
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(userSetting) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (void)userSetting
{
    NSLog(@"hello,world");
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
//    NSLog(@"%@", data);
    NSDictionary * dic = (NSDictionary *)data;
    int status = [dic getIntValueForKey:@"status" defaultValue:0];
    if (status == 1) {
        NSDictionary * data = [dic objectForKey:@"data"];
        NSDictionary * user = [data objectForKey:@"user"];
        
        userentity = [UsersEntity entityWithJsonDictionary:user];
        
        [self refreshTableView];
        
    } else {
        //show message.
    }
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
    CGFloat labelHight = 16.f;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            
//            [self userCoverImageSet];
            
            [cell addSubview:userCoverImage];
            
//            [self userImageSet];
            
            [cell addSubview:userImageView];
            
            
//            userNameLabel.text = userentity.nick;
            
            
            [cell addSubview:userNameLabel];
            
            
            UIView *bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 320, 40)];
            bannerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_cover_banner"]];
            
            UILabel * allNewsFeedLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 12, 134, 16)];
            allNewsFeedLabel.text = @"所有动态";
            allNewsFeedLabel.backgroundColor = [UIColor clearColor];
            allNewsFeedLabel.textAlignment = NSTextAlignmentRight;
            allNewsFeedLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            allNewsFeedLabel.textColor = [UIColor whiteColor];
            [bannerView addSubview:allNewsFeedLabel];
            [allNewsFeedLabel release];
            
            UIButton *allNewsFeedButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, 120, 40)];
            [allNewsFeedButton addTarget:self action:@selector(allNewsFeedAction) forControlEvents:UIControlEventTouchUpInside];
            [bannerView addSubview:allNewsFeedButton];
            [allNewsFeedButton release];
            
            UIImageView * allNewsFeedAccessory = [[UIImageView alloc] initWithFrame:CGRectMake(295, 13, 14, 14)];
            allNewsFeedAccessory.image = [UIImage imageNamed:@"user_cover_arrow"];
            [bannerView addSubview:allNewsFeedAccessory];
            [allNewsFeedAccessory release];
            
            [cell addSubview:bannerView];
            [bannerView release];
            
        }
        
        else if (indexPath.section == 1 && indexPath.row == 0) {
            
            UILabel * innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 80, labelHight)];
            innerLabel.text = @"逸族身份";
            innerLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            innerLabel.textColor = [UIColor grayColor];
            [cell addSubview:innerLabel];
            [innerLabel release];
            
//            userLevelLabel.text = !userentity.sex ? @"骑士" : @"千金";
            
            [cell addSubview:userLevelLabel];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.section == 1 && indexPath.row == 1) {
            
            UILabel * innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 80, labelHight)];
            innerLabel.text = @"所在城市";
            innerLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            innerLabel.textColor = [UIColor grayColor];
            [cell addSubview:innerLabel];
            [innerLabel release];
            
//            userAddressLabel.text = userentity.address;
            
            [cell addSubview:userAddressLabel];
            
        }
        else if (indexPath.section == 1 && indexPath.row == 2) {
            
            UILabel * innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, 80, labelHight)];
            innerLabel.text = @"兴趣爱好";
            innerLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            innerLabel.textColor = [UIColor grayColor];
            [cell addSubview:innerLabel];
            [innerLabel release];
            
            
            
//            userHobbyLable.text = userentity.hobby;
            
            
            [cell addSubview:userHobbyLable];
            //            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        else if (indexPath.section == 1 && indexPath.row == 3) {
            
            UILabel * innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 80, labelHight)];
            innerLabel.text = @"个人素描";
            innerLabel.font = [UIFont fontWithName:FONT_NAME size:labelHight];
            innerLabel.textColor = [UIColor grayColor];
            [cell addSubview:innerLabel];
            [innerLabel release];
            
//            userDescLablel.text = userentity.what;
            
            [cell addSubview:userDescLablel];
            //            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    
       
    // Configure the cell...
    
    return cell;
}

#pragma mark - actions



- (void)backAction
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)backActionWithPush
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)userCoverImageSet
{
    NSString *ws = userentity.website;
    if ([ws length] > 0) {
        char index_usercover = [ws characterAtIndex:([ws length] - 5)];
        [self userCoverSet:index_usercover];
    } else {
        userCoverImage.image = [UIImage imageNamed:@"user_cover_default.png"];
    }
}

- (void)userCoverSet:(char )c
{
    if (c < 60 && c > 48) {
        userCoverImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_cover%c", c]];
    } else {
        userCoverImage.image = [UIImage imageNamed:@"user_cover_default.png"];
    }
}

- (void)userImageSet
{
    if (![userentity.image length] && ![userentity.otheraccountuserimage length]) {
        
        [userImageView setImage:[UIImage imageNamed:@"nobody_male.png"]];
        
    } else {
        
        NSString *realimage = userentity.image ? userentity.image : userentity.otheraccountuserimage;
        NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, realimage];
        [userImageView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"nobody_male.png"]];
    }
}

- (void)refreshTableView
{
    [self userCoverImageSet];
    
    [self userImageSet];
    
    userNameLabel.text = userentity.nick;
    
    
    userHobbyLable.text = [userentity.hobby length] == 0 ? @"还没有添加兴趣" : userentity.hobby;
    [userHobbyLable sizeToFitFixedWidth:205.f];
    
    userDescLablel.text = [userentity.what length] == 0 ? @"什么也没有" : userentity.what;
    [userDescLablel sizeToFitFixedWidth:205.f];
    
    userLevelLabel.text = userentity.sex ? @"骑士" : @"千金";
    
    userAddressLabel.text = [userentity.address length] == 0 ? @"还没有填写地址" : userentity.address;
    
    [self.tableView reloadData];
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
//    [bannerView release];
//    [allNewsFeedButton release];
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
//    bannerView = nil;
//    allNewsFeedButton = nil;
}

@end
