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


@interface UserViewController ()

@end

@implementation UserViewController

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.row == 0 && indexPath.section == 0) {
        height = 160.f;
    } else {
        height = 40.f;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            UIImageView * userCoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
            userCoverImage.image = [UIImage imageNamed:@"user_cover1.png"];
            [cell addSubview:userCoverImage];
            [userCoverImage release];
            
            CGFloat userImageViewSize = 70.f;
            CGFloat userImageViewFromTop = 20.f;
            
            UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - userImageViewSize) / 2, userImageViewFromTop, userImageViewSize, userImageViewSize)];
            userImageView.image = [UIImage imageNamed:@"nobody_male.png"];
            userImageView.backgroundColor = [UIColor whiteColor];
            [userImageView.layer setMasksToBounds:YES];
            CGFloat radius = userImageViewSize / 2;
            [userImageView.layer setCornerRadius:radius];
            [userImageView.layer setBorderWidth:3.0];
            [userImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
            
            [cell addSubview:userImageView];
            
            [userImageView release];
            
            UILabel * userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, userImageViewSize + userImageViewFromTop + 3, 320, 20)];
            userNameLabel.textAlignment = NSTextAlignmentCenter;
            userNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
            userNameLabel.textColor = [UIColor whiteColor];
            userNameLabel.backgroundColor = [UIColor clearColor];
            userNameLabel.text = @"用户名";
            [cell addSubview:userNameLabel];
            [userNameLabel release];
            
            UIView * bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 320, 40)];
            bannerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_cover_banner"]];
            [cell addSubview:bannerView];
            
            
            UIButton * allNewsFeedButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, 120, 40)];
            [allNewsFeedButton addTarget:self action:@selector(allNewsFeedAction) forControlEvents:UIControlEventTouchUpInside];
            [bannerView addSubview:allNewsFeedButton];
            [allNewsFeedButton release];
            
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
        
        
        
        
    }
    
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - actions

- (void)allNewsFeedAction
{
    IndexViewController *homevc = [[IndexViewController alloc] init];
    homevc.pagetype = 1;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:homevc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController pushViewController:nav animated:YES];
    [homevc release];
    [nav release];
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

@end
