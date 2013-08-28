//
//  CircleDetailViewController.m
//  Instanote
//
//  Created by CMD on 7/31/13.
//
//

#import "CircleDetailViewController.h"
#import "WeiboClient.h"
#import "NSDictionaryAdditions.h"
#import "CircleDetailEntity.h"
#import "CircleCommentInfosEntity.h"
#import "CircleCommentCell.h"
#import "Circledetailcell.h"

@interface CircleDetailViewController ()

@end

@implementation CircleDetailViewController
@synthesize circleDetailEntity;

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
    self.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];
    self.title = circleDetailEntity.title;
    
    [self initpage];
    
    [self getCircleDetailInfo];
    
    [self getCircleCommentInfos];
    
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
    int numner = 2 + [fetchArray count];
    return numner;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0.f;
    if (indexPath.row == 0) {
        CircleDetailCell * cdcell = (CircleDetailCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        height = [cdcell cellHeights];
    }
    else if (indexPath.row > 0 && indexPath.row < [fetchArray count] + 1) {
        CircleCommentCell * cell = (CircleCommentCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        height = [cell cellHeights];
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
        static NSString *cellid = @"circledetailcell";
        CircleDetailCell * cell = (CircleDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil){
            cell = [[[CircleDetailCell alloc] init] autorelease];
        }
        [cell configurecellIndetail:circleDetailEntity];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.row >= 1 && indexPath.row < [fetchArray count] + 1) {
        CircleCommentCell * cell;
        cell = (CircleCommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[CircleCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        int index = indexPath.row - 1;
        CircleCommentInfosEntity * cce = [fetchArray objectAtIndex:index];
        [cell configurecell:cce];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        if (indexPath.row % 2 == 0) {
//            cell.backgroundColor = [UIColor yellowColor];//[UIColor colorWithRed:241/255.f green:241/255.f blue:241/255.f alpha:1];
//        }
        
        return cell;
        
    } else if (indexPath.row == [fetchArray count] + 1) {
        static NSString *loadmore_CellId = @"cell_loadmore_style2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loadmore_CellId];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                             reuseIdentifier:loadmore_CellId] autorelease];
        }
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
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
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

#pragma mark
#pragma actions

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-  (void)newCommentAction
{
    
}

#pragma weiboClient
- (void)getCircleDetailInfo
{
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
    [client getCircleDetailInfo:circleDetailEntity.circledetailid];
}

- (void)getCircleCommentInfos
{
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadCommentInfoDataFinished:obj:)];
    [client getCircleDetailCommentInfos:circleDetailEntity.circledetailid pageNum:pagenum pageSize:pagesize];
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

- (void)loadCommentInfoDataFinished:(WeiboClient *)sender
                     obj:(NSObject*)obj
{
    
    if (sender.hasError) {
        [sender alerterror:NSLocalizedString(@"errormessage", nil)];
    }
    else {
        
        if (mLoadingDataType == 1) {
            [self initpage];
        }
        [self convertCommentInfosdata:obj];
        [self endLoadData];
    }
}

- (void)convertdata:(NSObject *)obj
{
//    NSLog(@"%@", obj);
    int status = [[(NSDictionary *)obj objectForKey:@"status"] intValue];
    if (status == 1) {
        NSDictionary *jsondata = [(NSDictionary *)obj objectForKey:@"data"];
        NSDictionary *circleDetailInfo = [jsondata objectForKey:@"circleDetail"];
        if (circleDetailInfo) {
            CircleDetailEntity * ce = [CircleDetailEntity entityWithJsonDictionary:circleDetailInfo];
            circleDetailEntity.circlecontent = ce.circlecontent;
        }
        [self reloadtableivew];
    }
}

- (void)convertCommentInfosdata:(NSObject *)obj
{
//    NSLog(@"%@", obj);
    int status = [[(NSDictionary *)obj objectForKey:@"status"] intValue];
    if (status == 1) {
        NSDictionary *jsondata = [(NSDictionary *)obj objectForKey:@"data"];
        totalcommentcount = [jsondata getIntValueForKey:@"countComment" defaultValue:0];
        NSDictionary *circleCommentinfoList = [jsondata objectForKey:@"detailComment"];
        if (circleCommentinfoList) {
            for (NSDictionary * commentinfo in circleCommentinfoList) {
                if (![commentinfo isKindOfClass:[NSDictionary class]]) {
                    continue;
                }
                CircleCommentInfosEntity * cdie = [CircleCommentInfosEntity entityWithJsonDictionary:commentinfo];
                [fetchArray addObject:cdie];
            }
        }
        [self reloadtableivew];
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
    [self getCircleCommentInfos];
    
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
