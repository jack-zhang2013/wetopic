//
//  TopicViewController.h
//  Instanote
//
//  Created by Man Tung on 12/29/12.
//
//

#import <UIKit/UIKit.h>
#import "TopicsEntity.h"
#import "EGORefreshTableHeaderView.h"
#import "msgView.h"
#import "CommentDetailViewController.h"
#import "AddViewController.h"

@interface TopicViewController : UITableViewController
{
    NSMutableArray *fetchArray;
    int pagenum;
    int pagesize;
    TopicsEntity * mytopic;
//    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
    
    int totalcommentcount;
    int mLoadingDataType;
    
//    msgView *msgview;
    
    UIButton * loadMoreButton;

    UIButton * btn_comment;
    UIButton * btn_back;
    
    CommentDetailViewController * commentdetailvc;
    
}

//- (void)reloadTableViewDataSource;
//- (void)doneLoadingTableViewData;

@property (nonatomic, retain)TopicsEntity *mytopic;
@property (nonatomic, retain)CommentDetailViewController *commentdetailvc;


@end
