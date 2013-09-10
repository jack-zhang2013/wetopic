//
//  CircleViewController.m
//  Instanote
//
//  Created by CMD on 7/30/13.
//
//

#import "CircleViewController.h"
#import "CircleDescriptionViewController.h"
#import "CircleUserListViewController.h"
#import "WeiboClient.h"
#import "CircleDetailEntity.h"
#import "CircleDetailCell.h"
#import "NSDictionaryAdditions.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h> 

@interface CircleViewController ()

@end

@implementation CircleViewController
@synthesize circleId;
@synthesize cEntity;

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
    
    self.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];
//    self.navigationItem.rightBarButtonItem = [self rightButtonForCenterPanel];
    
    self.title = cEntity.circlename;
    
    [self initpage];
    
    [self loadDataBegin];
    
}

- (UIBarButtonItem *)rightButtonForCenterPanel {
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake(0, 0, 50, 44);
    [face setImage:[UIImage imageNamed:@"circle_tweet.png"] forState:UIControlStateNormal];
//    [face setImage:[UIImage imageNamed:@"circle_tweet_highlight.png"] forState:UIControlStateHighlighted];
    [face addTarget:self action:@selector(newTweetAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (UIBarButtonItem *)leftButtonForCenterPanel {
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake(0, 0, 50, 44);
    [face setImage:[UIImage imageNamed:@"circle_back_normal.png"] forState:UIControlStateNormal];
//    [face setImage:[UIImage imageNamed:@"circle_back_highlight.png"] forState:UIControlStateHighlighted];
    [face addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)newTweetAction
{
    NSLog(@"hello,world!");
}

- (void)usercountAction
{
    CircleUserListViewController * culvc = [[CircleUserListViewController alloc] init];
    culvc.circleEntity = cEntity;
    [self.navigationController pushViewController:culvc animated:YES];
}

- (void)circleDescriptionAction
{
    CircleDescriptionViewController * circledescriptionVC = [[CircleDescriptionViewController alloc] init];
    circledescriptionVC.circleentity = cEntity;
    [self.navigationController pushViewController:circledescriptionVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshviewAction
{
    [fetchArray release];
    fetchArray = [[NSMutableArray alloc] init];
    [self loadDataBegin];
}

- (void)loadDataBegin
{
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
    [client getCircleDetailInfos:circleId pageNum:pagenum pageSize:pagesize];
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
//    NSLog(@"%@", obj);
    int status = [[(NSDictionary *)obj objectForKey:@"status"] intValue];
    if (status == 1) {
        NSDictionary *jsondata = [(NSDictionary *)obj objectForKey:@"data"];
        totalcommentcount = [jsondata getIntValueForKey:@"comCount" defaultValue:0];
        NSDictionary *circledetailList = [jsondata objectForKey:@"circledetailList"];
        if (circledetailList) {
            for (NSDictionary * commentinfo in circledetailList) {
                if (![commentinfo isKindOfClass:[NSDictionary class]]) {
                    continue;
                }
                CircleDetailEntity * cde = [CircleDetailEntity entityWithJsonDictionary:commentinfo];
                [fetchArray addObject:cde];
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

#pragma mark - Table view data source


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
        height = 129.f;
    }
    else if (indexPath.row > 0 && indexPath.row < [fetchArray count] + 1) {
        CircleDetailCell * cell = (CircleDetailCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
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
        static NSString *cellid = @"topcell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil){
            cell = [[[UITableViewCell alloc] init] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
         
        CGFloat userCountViewSize = 74;
        UIView * userCountView = [[UIView alloc] initWithFrame:CGRectMake(160 + 43, 28, userCountViewSize, userCountViewSize)];
        userCountView.backgroundColor = [UIColor colorWithRed:219/255.f green:108/255.f blue:86/255.f alpha:1];
        [userCountView.layer setMasksToBounds:YES];
        CGFloat userCountViewradius = userCountViewSize / 2;
        [userCountView.layer setCornerRadius:userCountViewradius];
        [userCountView.layer setBorderWidth:3];
        UIColor *pinkorange = [UIColor colorWithRed:219/255.f green:93/255.f blue:73/255.f alpha:1];
        [userCountView.layer setBorderColor:[pinkorange CGColor]];
        [cell addSubview:userCountView];
        [userCountView release];
        
        UIButton *usercountbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        usercountbutton.frame = CGRectMake(160 + 43, 28, userCountViewSize, userCountViewSize);
        [usercountbutton addTarget:self action:@selector(usercountAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:usercountbutton];
        
        UIView * circleImageBg = [[UIView alloc] initWithFrame:CGRectMake(43, 28, userCountViewSize, userCountViewSize)];
        circleImageBg.backgroundColor = [UIColor colorWithRed:219/255.f green:108/255.f blue:86/255.f alpha:1];
        [circleImageBg.layer setMasksToBounds:YES];
        [circleImageBg.layer setCornerRadius:userCountViewradius];
        [circleImageBg.layer setBorderWidth:3];
        UIColor *pinkorangee = [UIColor colorWithRed:219/255.f green:93/255.f blue:73/255.f alpha:1];
        [circleImageBg.layer setBorderColor:[pinkorangee CGColor]];
        [cell addSubview:circleImageBg];
        [circleImageBg release];
        
        UIButton *circleDescriptionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        circleDescriptionButton.frame = CGRectMake(43, 28, userCountViewSize, userCountViewSize);
        [circleDescriptionButton addTarget:self action:@selector(circleDescriptionAction) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:circleDescriptionButton];
        
        
        CGFloat circleImageViewLeft = 52.5, circleImageviewSize = 55;
        UIImageView *circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(circleImageViewLeft, 37, circleImageviewSize, circleImageviewSize)];
        circleImageView.backgroundColor = [UIColor whiteColor];
        [circleImageView.layer setMasksToBounds:YES];
        CGFloat radius = circleImageviewSize / 2;
        [circleImageView.layer setCornerRadius:radius];
        [circleImageView.layer setBorderWidth:2];
        [circleImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, cEntity.circlebigimg];
        [circleImageView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"circle_placeholder.png"]];
        
        [cell addSubview:circleImageView];
        [circleImageView release];
        
        
        UILabel * userCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 57, 160, 16)];
        userCountLabel.textAlignment = NSTextAlignmentCenter;
        userCountLabel.backgroundColor = [UIColor clearColor];
        userCountLabel.textColor = [UIColor whiteColor];
        userCountLabel.font = [UIFont fontWithName:FONT_NAME size:15];
        userCountLabel.text = [NSString stringWithFormat:@"%d 人", cEntity.joincount];
        [cell addSubview:userCountLabel];
        [userCountLabel release];
        
        
        UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(159.5, 0, 1, 129)];
        sepView.backgroundColor = [UIColor colorWithRed:226/255.f green:226/255.f blue:226/255.f alpha:1];
        [cell addSubview:sepView];
        [sepView release];
        
        return cell;
        
    } else if (indexPath.row >= 1 && indexPath.row < [fetchArray count] + 1) {
        CircleDetailCell * cell = (CircleDetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[CircleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        int index = indexPath.row - 1;
        CircleDetailEntity * cde = [fetchArray objectAtIndex:index];
        [cell configurecell:cde];
        
        return cell;
        
    } else if (indexPath.row == [fetchArray count] + 1) {
        
        static NSString * moreCellId = @"cell_loadmore_style2";
        UITableViewCell * cell = [ tableView dequeueReusableCellWithIdentifier:moreCellId];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:moreCellId] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        UILabel * loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, 320, 17)];
        loadMoreLabel.textAlignment = NSTextAlignmentCenter;
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
        
                
        
        return cell;
        
    } else {
        
        UITableViewCell *bcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (bcell == nil) {
            bcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return bcell;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0 && indexPath.row <= [fetchArray count]) {
//        CircleDetailEntity * circleentity = [fetchArray objectAtIndex:indexPath.row - 1];
        cdvc = [[CircleDetailViewController alloc] init];
        cdvc.circleDetailEntity = [fetchArray objectAtIndex:indexPath.row - 1];
        [self.navigationController pushViewController:cdvc animated:YES];
    }
}

#pragma mark
#pragma mark - page inits

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


- (void)dealloc
{
    [mycircle release];
    [fetchArray release];
    [cdvc release];
    [super dealloc];
}

- (void)viewDidUnload
{
    mycircle = nil;
    fetchArray = nil;
    cdvc = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
