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

@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize topicviewcontroller;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [self rightButtonGen];
    
    NSArray *segmentTextContent = [NSArray arrayWithObjects:
                                   NSLocalizedString(@"segmentnewest", @""),
                                   NSLocalizedString(@"segmenthot", @""),
								   nil];
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
	segmentedControl.selectedSegmentIndex = 0;
	segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.frame = CGRectMake(90, 7, 140, 30);
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	[self.navigationController.navigationBar addSubview:segmentedControl];
    [segmentedControl release];
    
//    if (!mLoadMoreAIView) {
//        mLoadMoreAIView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100, 12, 19, 19)];
//        mLoadMoreAIView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    if (_refreshHeaderView == nil) {
//		
//		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
//		view.delegate = self;
//		[self.tableView addSubview:view];
//		_refreshHeaderView = view;
//		[view release];
//		
//	}
    
//    avatarbutton = [[UIButton alloc] initWithFrame:CGRectMake(2, 12, 60, 20)];
//    [avatarbutton addTarget:self action:@selector(avatarAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar addSubview:avatarbutton];
//    
//    double avatarviewsize = 28;
//    avatarview = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, avatarviewsize, avatarviewsize)];
//    avatarview.layer.masksToBounds = YES;
//    avatarview.layer.cornerRadius = avatarviewsize / 2.0;
//    avatarview.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar addSubview:avatarview];
    
	//  update the last update date
//	[_refreshHeaderView refreshLastUpdatedDate];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (UIBarButtonItem *)rightButtonGen {
    UIImage *faceImage = [UIImage imageNamed:@"refresh.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 0, 0, 22, 22 );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self
             action:@selector(refreshData)
   forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (void)avatarAction
{
    if ([self getUserIdandEmail]) {
        [self userAction];
        
    } else {
        [self signinAction];
    }
}

//- (void)userislogin
//{
//    if ([self getUserIdandEmail]) {
//        NSString *stringurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, [self getUserImage]];
//        [avatarview setImageWithURL:[NSURL URLWithString:stringurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//    } else {
//        [avatarview setImage:[UIImage imageNamed:@"nobody.png"]];
//    }
//}


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

- (void)userAction
{
//    NSLog(@"hello,world!");
}

- (void)segmentAction:(id)sender
{
	// The segmented control was clicked, handle it here
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

- (void)loadDataBegin
{
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
    [client timeline:pagesize pageNum:pagenum pageType:pagetype];
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
    }
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    fetchArray = nil;
//    _refreshHeaderView = nil;
//    msgview = nil;
//    avatarview = nil;
//    avatarbutton = nil;
    topicviewcontroller = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    [fetchArray release];
//    _refreshHeaderView = nil;
//    [msgview release];
//    [avatarview release];
//    [avatarbutton release];
//    [segmentedControl release];
    [topicviewcontroller release];
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
//    NSString * image = [def objectForKey:@"image"];
//    NSLog(@"%d,%@,%@", userid, email, image);
    if (userid && [email length]) {
        return YES;
    } else {
        return NO;
    }
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

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    TopicsEntity * topic = [fetchArray objectAtIndex:section];
//    return topic.title;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0.f;
    if (indexPath.row < [fetchArray count]) {
        NewsFeedCell * cell = (NewsFeedCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        height = [cell cellHeights];
    } else if (indexPath.row == [fetchArray count]) {
        height = 48.f;
    }
//    if (indexPath.section == [fetchArray count] - 1 && indexPath.row == 1) {
//        return 48.f;
//    } else {
//        height = 121.f;
//    }
    return height;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 44.f;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    PhotoHeaderView *headview = [[PhotoHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
//    if (section < [fetchArray count]) {
//        TopicsEntity *tp = [fetchArray objectAtIndex:section];
//        [headview layoutSub:tp];
//    }
//    return headview;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NewsFeedCell * cell;
    // Configure the cell...
    if (indexPath.row < [fetchArray count]) {
        
        cell = [[[NewsFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        TopicsEntity * tp = [fetchArray objectAtIndex:indexPath.row];
        [cell configurecell:tp];
        
    } else if (indexPath.row == [fetchArray count]) {
        
        UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell_loadmore_style2"];
        if (cell == nil){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:@"cell_loadmore_style2"] autorelease];
            UILabel * loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 14, 150, 17)];
            [loadMoreLabel setFont:[UIFont fontWithName:FONT_NAME size:13]];
            [loadMoreLabel setTextColor:[UIColor grayColor]];
            [loadMoreLabel setBackgroundColor:[UIColor clearColor]];
            
            [loadMoreLabel setText:@"上拉加载更多"];
            
            [cell addSubview:loadMoreLabel];
            [loadMoreLabel release];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
//        [cell addSubview:mLoadMoreAIView];
//        UIButton * loadMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [loadMoreButton setFrame:CGRectMake(80.f, 0.f, 160.f, 60.f)];
//        [loadMoreButton setBackgroundColor:[UIColor clearColor]];
//        [loadMoreButton addTarget:self action:(@selector(loadMoreData)) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:loadMoreButton];
        
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
//    [avatarview setHidden:YES];
//    [avatarbutton setHidden:YES];
//    [segmentedControl setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self userislogin];
//    [avatarbutton setHidden:NO];
//    [avatarview setHidden:NO];
//    [segmentedControl setHidden:NO];
    
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
    pagetype = 1;
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
