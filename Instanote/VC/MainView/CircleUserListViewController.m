//
//  CircleUserListViewController.m
//  Instanote
//
//  Created by CMD on 8/26/13.
//
//

#import "CircleUserListViewController.h"
#import "WeiboClient.h"
#import "UsersEntity.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UILabel+Extensions.h"
#import "CircleUserCell.h"
#import "UserViewController.h"

@interface CircleUserListViewController ()

@end

@implementation CircleUserListViewController

@synthesize circleEntity;

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
    [self initpage];
    [self getMoreUsers];
    
    self.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];
    
}

#pragma mark
#pragma buttons
- (UIBarButtonItem *)leftButtonForCenterPanel {
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake(0, 0, 50, 44);
    [face setImage:[UIImage imageNamed:@"circle_back_normal.png"] forState:UIControlStateNormal];
    //    [face setImage:[UIImage imageNamed:@"circle_back_highlight.png"] forState:UIControlStateHighlighted];
    [face addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (UIBarButtonItem *)rightButtonForCenterPanel {
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake(0, 0, 50, 44);
    [face setImage:[UIImage imageNamed:@"circle_tweet.png"] forState:UIControlStateNormal];
    //    [face setImage:[UIImage imageNamed:@"circle_tweet_highlight.png"] forState:UIControlStateHighlighted];
    [face addTarget:self action:@selector(newCommentAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)userAction:(UIButton *)sender;
{
    UserViewController *uservc = [[UserViewController alloc] init];
    uservc.usertype = 2;
    uservc.userId = sender.tag;
    [self.navigationController pushViewController:uservc animated:YES];
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:uservc];
    //    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner.png"] forBarMetrics:UIBarMetricsDefault];
    //    [self presentModalViewController:nav animated:YES];
    //    [nav release];
    [uservc release];
    
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
    return [fetchArray count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.row >=0 && indexPath.row < [fetchArray count]) {
        CircleUserCell * cell = (CircleUserCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        height = [cell cellHeights];
    } else if (indexPath.row == [fetchArray count]) {
        height = 45;
    } else {
        height = 10;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    if (indexPath.row >= 0 && indexPath.row < [fetchArray count]) {
        CircleUserCell * cell = (CircleUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[CircleUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UsersEntity *userenity = [fetchArray objectAtIndex:indexPath.row];
        
        [cell.authorViewButton addTarget:self action:@selector(userAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell configCell:userenity];
        return cell;
    }  else if (indexPath.row == [fetchArray count]) {
        UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell_loadmore_style2"];
        if (cell == nil){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:@"cell_loadmore_style2"] autorelease];
            UILabel *loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, 320, 17)];
            loadMoreLabel.textAlignment = NSTextAlignmentCenter;
            [loadMoreLabel setFont:[UIFont fontWithName:FONT_NAME size:13]];
            [loadMoreLabel setTextColor:[UIColor grayColor]];
            [loadMoreLabel setBackgroundColor:[UIColor clearColor]];
            if ([fetchArray count] < totalcommentcount) {
                [loadMoreLabel setText:@"上拉加载更多"];
            } else {
                if ([fetchArray count] == 0) {
                    [loadMoreLabel setText:@"正在加载"];
                } else {
                    [loadMoreLabel setText:@"没有更多了"];
                }
            }
            
            [cell addSubview:loadMoreLabel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [loadMoreLabel release];
        }
        
        return cell;
        
    } else {
        UITableViewCell *bcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (bcell == nil) {
            bcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return bcell;
    }
}

#pragma mark
#pragma data fetch

- (void)getMoreUsers
{
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
    [client getCircleUsers:circleEntity.circleid pageNum:pagenum pageSize:pagesize];
}

- (void)loadDataFinished:(WeiboClient *)sender
                     obj:(NSObject*)obj
{
    
    if (sender.hasError) {
        [sender alerterror:NSLocalizedString(@"errormessage", nil)];
    }
    else {
        
        if (mLoadingDataType == 1) {
            [self initpage];
        }
        [self convertdata:obj];
    }
}

- (void)convertdata:(NSObject *)obj
{
//    NSLog(@"%@", obj);
    int status = [[(NSDictionary *)obj objectForKey:@"status"] intValue];
    if (status == 1) {
        NSDictionary *jsondata = [(NSDictionary *)obj objectForKey:@"data"];
        NSDictionary *circleUsers = [jsondata objectForKey:@"userCircleRls"];
        for (NSDictionary * ci in circleUsers) {
            if (![ci isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            NSDictionary * cu = [ci objectForKey:@"userinfo"];
            UsersEntity * user = [UsersEntity entityWithJsonDictionary:cu];
            [fetchArray addObject:user];
        }
        [self.tableView reloadData];
    }
}

#pragma mark -
#pragma mark page

- (void)initpage
{
    pagenum = 1;
    pagesize = 20;
    //    pagetype = 1;
    fetchArray = [[NSMutableArray alloc] init];
}

- (void)nexttpage
{
    pagenum ++;
}

- (void)prepage
{
    if (pagenum > 1) {
        pagenum --;
    } else {
        pagenum = 1;
    }
}

- (BOOL)beforeLoadMoreData
{
    if (_reloading) {
        return NO;
    }
    _reloading = YES;
    mLoadingDataType = 2;
    return YES;
}
- (void)endLoadMoreData
{
    [self reloadtableivew];
    mLoadingDataType = 0;
    _reloading = NO;
}
- (void)loadMoreData
{
    if (![self ifCanLoadMore]) return;
    if (![self beforeLoadMoreData])  return;
    [self nexttpage];
    [self getMoreUsers];
    
}

/**结束数据处理**/
- (void)endLoadData
{
    if (mLoadingDataType == 1) {
        [self endRefreshData];
    }
    else if(mLoadingDataType == 2) {
        [self endLoadMoreData];
    }
}

- (BOOL)beforeRefreshData       //返回是否可以刷新
{
    if (_reloading) {
        return NO;
    }
    _reloading = YES;
    mLoadingDataType = 1;
    //
    //    [msgview setFrame:CGRectMake(20, 150, 280, 30)];
    //    [msgview setText:@"正在获取内容"];
    
    [self tableviewScrollToTop:YES];
    
    //
    
    return YES;
}
-(void)endRefreshData
{
    //    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [self reloadtableivew];
    mLoadingDataType = 0;
    _reloading = NO;
}

- (void)reloadtableivew
{
    [self.tableView reloadData];
    //[self.tv setContentSize:CGSizeMake(320, tv.contentSize.height)];
}


//- (void)refreshData
//{
//    if (![self beforeRefreshData])  return;
//    [self initpage];
//    [self loadDataBegin];
//}

- (void)tableviewScrollToTop:(BOOL)animated
{
    [self.tableView setContentOffset:CGPointMake(0,0) animated:animated];
}

- (BOOL)ifCanLoadMore
{
    return ((pagenum + 1) * pagesize <= STATUSDATA_MAX_PAGE && [fetchArray count] > 0 && [fetchArray count] < totalcommentcount);
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
