//
//  IndexViewController.h
//  Instanote
//
//  Created by Man Tung on 10/26/12.
//
//

#import <UIKit/UIKit.h>
//#import "EGORefreshTableHeaderView.h"
#import "TopicViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface IndexViewController : UITableViewController
{
    NSMutableArray *fetchArray;
    int pagenum;
    int pagesize;
    int pagetype;
    int indexUserId;
    
    UIActivityIndicatorView *mLoadMoreAIView;        //页面加载更多转场
//    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
    
    int totalcommentcount;
    int mLoadingDataType;
    
//    msgView *msgview;
    
    CGFloat previousContentDelta;
    CGFloat initialContentOffset;
    
    TopicViewController *topicviewcontroller;
    
//    UIImageView *avatarview;
//    UIButton * avatarbutton;
    
//    UISegmentedControl *segmentedControl;
//    UIButton * refreshbtn;
    
    
}

@property (nonatomic, retain)TopicViewController *topicviewcontroller;
@property (nonatomic, assign)int pagetype;
@property (nonatomic, assign)int indexUserId;

- (void)reloadTableViewDataSource;
//- (void)doneLoadingTableViewData;

@end
