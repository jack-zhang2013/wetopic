//
//  TopicViewController.m
//  Instanote
//
//  Created by Man Tung on 12/29/12.
//
//

#import "TopicViewController.h"
#import "WeiboClient.h"
#import "CommentCell.h"
#import "TopicDetailCell.h"
#import "CircleCommentInfosEntity.h"
#import "NSDictionaryAdditions.h"
#import "CommentDetailViewController.h"
#import "AddViewController.h"
#import "UMSocialSnsService.h"
#import "UMSocialSnsPlatformManager.h"

@interface TopicViewController ()

@end

@implementation TopicViewController
@synthesize mytopic;
@synthesize commentdetailvc;

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
    
    [self initpage];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    
//    CGRect tableviewRect = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height + 44.f);
//    [self.tableView setFrame:tableviewRect];
    
    self.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];
    self.navigationItem.rightBarButtonItem = [self rightButtonForCenterPanel];
    
//    msgview = [[msgView alloc] initWithFrame:CGRectMake(80, 200, 160, 40)];
//    [self.view addSubview:msgview];
    
    
    
//    if (_refreshHeaderView == nil) {
//		
//		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
//		view.delegate = self;
//		[self.tableView addSubview:view];
//		_refreshHeaderView = view;
//		[view release];
//	}
//	
//	//  update the last update date
//	[_refreshHeaderView refreshLastUpdatedDate];
    
    
    
    UISwipeGestureRecognizer * swipegr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    [self.tableView addGestureRecognizer:swipegr];
    [swipegr release];
    
    [self loadDataBegin];
}





 - (void)commentAction
{
    AddViewController *addvc = [[AddViewController alloc] init];
    addvc.topicid = mytopic.circledetailid;
    addvc.finishAction = @selector(refreshviewAction);
    addvc.finishTarget = self;
    UINavigationController * addnav = [[UINavigationController alloc] initWithRootViewController:addvc];
    [addnav.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    [self presentModalViewController:addnav animated:YES];
    [addvc release];
    [addnav release];
}

- (void)shareAction
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMENG_APPKEY
                                      shareText:@"分享这个话题"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina, UMShareToWechat, UMShareToRenren, UMShareToDouban, UMShareToSms, UMShareToEmail, nil]
                                       delegate:nil];
}


- (void)refreshviewAction
{
    [fetchArray release];
    fetchArray = [[NSMutableArray alloc] init];
    [self loadDataBegin];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)gob
//{
//    if (!_reloading) {
//        [self.navigationController dismissModalViewControllerAnimated:YES];
//    }
//}

- (void)loadDataBegin
{
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
    [client topicCommnet:mytopic.circledetailid pageNum:pagenum pageSize:pagesize];
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
        [self endLoadData];
        
        [[self tableView] reloadData];
    }
}

- (void)convertdata:(NSObject *)obj
{
    int status = [[(NSDictionary *)obj objectForKey:@"status"] intValue];
    if (status == 3) {
        NSDictionary *jsondata = [(NSDictionary *)obj objectForKey:@"data"];
        totalcommentcount = [jsondata getIntValueForKey:@"comCount" defaultValue:0];
        NSDictionary *commentList = [jsondata objectForKey:@"commentList"];
        if (commentList) {
            for (NSDictionary * commentinfo in commentList) {
                if (![commentinfo isKindOfClass:[NSDictionary class]]) {
                    continue;
                }
                CircleCommentInfosEntity * cce = [CircleCommentInfosEntity entityWithJsonDictionary:commentinfo];
                [fetchArray addObject:cce];
            }
        }
        [self reloadtableivew];
    }
}

- (void)reloadtableivew
{
    [self.tableView reloadData];
    //[self.tv setContentSize:CGSizeMake(320, tv.contentSize.height)];
}

- (BOOL)ifCanLoadMore
{
    return ((pagenum + 1) * pagesize <= STATUSDATA_MAX_PAGE && [fetchArray count] > 0 && [fetchArray count] < totalcommentcount);
}

#pragma mark -
#pragma mark msg

//- (void)alerterror:(NSString *)title
//{
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"more_logout_yes", nil) otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
//}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

//- (void)reloadTableViewDataSource {
//	
//	//  should be calling your tableviews data source model to reload
//	//  put here just for demo
//    [self initpage];
//    [self loadDataBegin];
//    
//	_reloading = YES;
//	
//}

/*
- (void)doneLoadingTableViewData {
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}
 */

#pragma mark -
#pragma mark UIScrollViewDelegate Methods


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
    if (!_reloading) {
//        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        if(scrollView.isDragging && scrollView.contentOffset.y >=  scrollView.contentSize.height - scrollView.frame.size.height + DRAG_HEIGHT) {
            if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) {
                [self loadMoreData];
            }
        }
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
//	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark
#pragma mark - tableview delegate

- (void)tableviewScrollToTop:(BOOL)animated
{
    [self.tableView setContentOffset:CGPointMake(0,0) animated:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 2;
    count += [fetchArray count];
    return count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0.f;
    if (indexPath.row == 0) {
        TopicDetailCell * topcell = (TopicDetailCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        height = [topcell cellheights];
    }
    else if (indexPath.row > 0 && indexPath.row < [fetchArray count] + 1) {
        CommentCell * cell = (CommentCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        height = [cell ch];
    }
    else if (indexPath.row == [fetchArray count] + 1) {
        height = 45.f;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if (indexPath.row == 0) {
        static NSString *cellid = @"topcell";
        TopicDetailCell * cell = (TopicDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil){
            cell = [[[TopicDetailCell alloc] init] autorelease];
        }
        [cell configurecell:mytopic];
        
        [cell.commentButton addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.row >= 1 && indexPath.row < [fetchArray count] + 1) {
        CommentCell * cell;
        cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        int index = indexPath.row - 1;
        CircleCommentInfosEntity * cce = [fetchArray objectAtIndex:index];
        [cell configurecell:cce];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.row == [fetchArray count] + 1) {
        
        UITableViewCell * cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:@"cell_loadmore_style2"] autorelease];
        
        UILabel * loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 14, 150, 17)];
        [loadMoreLabel setFont:[UIFont fontWithName:FONT_NAME size:13]];
        [loadMoreLabel setTextColor:[UIColor grayColor]];
        
        [cell addSubview:loadMoreLabel];
        [loadMoreLabel release];

        if ([fetchArray count] < totalcommentcount) {
            [loadMoreLabel setText:@"上拉加载更多"];
        } else {
            if ([fetchArray count] == 0) {
                [loadMoreLabel setText:@"正在加载"];
            } else {
                [loadMoreLabel setText:@"没有更多了"];
            }
            
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        return cell;
        
    } else {
        
        UITableViewCell *bcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (bcell == nil) {
            bcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return bcell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0 && indexPath.row <= [fetchArray count]) {
        CircleCommentInfosEntity * commententity = [fetchArray objectAtIndex:indexPath.row - 1];
        commentdetailvc = [[CommentDetailViewController alloc] init];
        commentdetailvc.mycomment = commententity;
        [self.navigationController pushViewController:commentdetailvc animated:YES];
    }
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.f;
}
 
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * navView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    navView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"banner.png"]];
    [self.view addSubview:navView];
    
    btn_comment = [[UIButton alloc] initWithFrame:CGRectMake(288, 10, 24, 24)];
    [btn_comment setImage:[UIImage imageNamed:@"share_white.png"] forState:UIControlStateNormal];
    [btn_comment addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:btn_comment];
    [btn_comment release];
    
    btn_back = [[UIButton alloc] initWithFrame:CGRectMake(10, 14, 24, 16)];
    [btn_back setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [btn_back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:btn_back];
    
    return navView;
}

 */

- (UIBarButtonItem *)leftButtonForCenterPanel {
    UIImage *faceImage = [UIImage imageNamed:@"arrow.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 12, 12, 24, 16 );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (UIBarButtonItem *)rightButtonForCenterPanel {
    UIImage *faceImage = [UIImage imageNamed:@"share_white.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 10, 10, 24, 24 );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

#pragma mark
#pragma mark - page inits

- (void)initpage
{
    pagenum = 1;
    pagesize = 20;
    //totalcommentcount = mytopic.comcount;
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
//    [msgview setFrame:CGRectMake(20, 150, 280, 30)];
//    [msgview setText:@"正在获取内容"];
    [self tableviewScrollToTop:YES];
    return YES;
}
-(void)endRefreshData
{
//    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [self reloadtableivew];
    mLoadingDataType = 0;
    _reloading = NO;
}

- (void)refreshData
{
    if (![self beforeRefreshData])  return;
    [self initpage];
    [self loadDataBegin];
}

#pragma mark - lifecircle

- (void)dealloc
{
//    _refreshHeaderView = nil;
    [mytopic release];
    [fetchArray release];
//    [msgview release];
    [btn_comment release];
    [btn_back release];
    [super dealloc];
}

- (void)viewDidUnload
{
//    _refreshHeaderView = nil;
    mytopic = nil;
    fetchArray = nil;
//    msgview = nil;
    btn_comment = nil;
    btn_back = nil;
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
