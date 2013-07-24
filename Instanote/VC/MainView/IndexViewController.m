//
//  IndexViewController.m
//  Instanote
//
//  Created by Man Tung on 10/26/12.
//
//

#import "IndexViewController.h"
#import "LoginViewController.h"
#import "JSON.h"
#import "NSDictionaryAdditions.h"
#import "TopicsEntity.h"
#import "PhotoCell.h"
#import "PhotoHeaderView.h"
#import "WeiboClient.h"
#import "TopicViewController.h"
#import "NewsFeedCell.h"
#import "UserViewController.h"
#import "WelcomeViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize topicviewcontroller;
@synthesize pagetype = pagetype;
@synthesize indexUserId = indexUserId;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!loadMoreLabel) {
        loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 14, 150, 17)];
        [loadMoreLabel setFont:[UIFont fontWithName:FONT_NAME size:13]];
        [loadMoreLabel setTextColor:[UIColor grayColor]];
        [loadMoreLabel setBackgroundColor:[UIColor clearColor]];
    }
    [self firstsignin];
    
}

- (void)firstsignin
{
    NSUserDefaults * df = [NSUserDefaults standardUserDefaults];
    if (![[df objectForKey:@"amilogin"] isEqual:@"yes"]) {
        [df setObject:@"yes" forKey:@"amilogin"];
        WelcomeViewController * welcomeVC = [[WelcomeViewController alloc] init];
        [self presentModalViewController:welcomeVC animated:NO];
        [welcomeVC release];
    }
}

//- (void)avatarAction
//{
//    if ([self getUserIdandEmail]) {
//        [self userAction];
//        
//    } else {
//        [self signinAction];
//    }
//}

//- (void)userislogin
//{
//    if ([self getUserIdandEmail]) {
//        NSString *stringurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, [self getUserImage]];
//        [avatarview setImageWithURL:[NSURL URLWithString:stringurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//    } else {
//        [avatarview setImage:[UIImage imageNamed:@"nobody.png"]];
//    }
//}


//- (void)signinAction
//{
//    LoginViewController *loginvc = [[LoginViewController alloc] init];
//    loginvc.finishAction = @selector(viewDidLoad);
//    loginvc.finishTarget = self;
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginvc];
//    navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    [self presentModalViewController:navigationController animated:YES];
//    [navigationController release];
//    [loginvc release];
//}

/*
- (void)segmentAction:(id)sender
{
	UISegmentedControl *segc = (UISegmentedControl *)sender;
    [self initpage];
	switch (segc.selectedSegmentIndex) {
        case 0:
            pagetype = 1;
            break;
        case 1:
            pagetype = 2;
            break;
        default:
            break;
    }
    [self loadDataBegin];
    [self.tableView reloadData];
}
 
 */

- (void)loadDataBegin
{
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
    [client timeline:pagesize pageNum:pagenum pageType:pagetype userId:indexUserId];
}

- (void)loadDataFinished:(WeiboClient *)sender
                     obj:(NSObject*)obj
{
    
    if (sender.hasError) {
        [self alerterror:NSLocalizedString(@"errormessage", nil)];
    }
    else {
        [self convertdata:obj];
        [self endLoadData];
    }
}

- (void)alerterror:(NSString *)title
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"more_logout_yes", nil) otherButtonTitles:nil, nil];
    [alert show];
}


- (void)convertdata:(NSObject *)obj
{
//    NSLog(@"%@", obj);
    NSDictionary *jsondata = [(NSDictionary *)obj objectForKey:@"data"];
    totalcommentcount = [jsondata getIntValueForKey:@"count" defaultValue:0];
    NSDictionary *allTopics = [jsondata objectForKey:@"allTopics"];
    if (allTopics) {
        for (NSDictionary * topic in allTopics) {
            if (![topic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            TopicsEntity * tps = [TopicsEntity entityWithJsonDictionary:topic];
            [fetchArray addObject:tps];
        }
        if ([fetchArray count] == 0) {
            loadMoreLabel.text = @"还没有话题";
        }
    }
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    fetchArray = nil;
    topicviewcontroller = nil;
    loadMoreLabel = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    [fetchArray release];
    [topicviewcontroller release];
    [loadMoreLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - login

- (void)start
{
    [self initpage];
    [self loadDataBegin];
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

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	_reloading = YES;
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    initialContentOffset = scrollView.contentOffset.y;
    previousContentDelta = 0.f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!_reloading) {
        if(scrollView.isDragging && scrollView.contentOffset.y >=  scrollView.contentSize.height - scrollView.frame.size.height + DRAG_HEIGHT) {
            if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) {
                [self loadMoreData];
            }
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 1;
    count = [fetchArray count] + 1;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0.f;
    if (indexPath.row < [fetchArray count]) {
        NewsFeedCell * cell = (NewsFeedCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        height = [cell cellHeights];
    } else if (indexPath.row == [fetchArray count]) {
        height = 48.f;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NewsFeedCell * cell;
    // Configure the cell...
    if (indexPath.row < [fetchArray count]) {
        
        cell = [[[NewsFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        TopicsEntity * tp = [fetchArray objectAtIndex:indexPath.row];
        [cell configurecell:tp];
        [cell.authorNameButton addTarget:self action:@selector(userAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.authorViewButton addTarget:self action:@selector(userAction:) forControlEvents:UIControlEventTouchUpInside];
        
    } else if (indexPath.row == [fetchArray count]) {
        UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell_loadmore_style2"];
        if (cell == nil){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:@"cell_loadmore_style2"] autorelease];
            
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
        }
        
        return cell;
        
    } else {
        
        UITableViewCell *bcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (bcell == nil) {
            bcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return bcell;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [fetchArray count]) {
        TopicsEntity * te = [fetchArray objectAtIndex:indexPath.row];
        topicviewcontroller = [[TopicViewController alloc] init];
        topicviewcontroller.mytopic = te;
        [self.navigationController pushViewController:topicviewcontroller animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!fetchArray) {
        [self start];
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
    [self loadDataBegin];

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


- (void)refreshData
{
    if (![self beforeRefreshData])  return;
    [self initpage];
    [self loadDataBegin];
}

- (void)tableviewScrollToTop:(BOOL)animated
{
    [self.tableView setContentOffset:CGPointMake(0,0) animated:animated];
}

- (BOOL)ifCanLoadMore
{
    return ((pagenum + 1) * pagesize <= STATUSDATA_MAX_PAGE && [fetchArray count] > 0 && [fetchArray count] < totalcommentcount);
}


@end
