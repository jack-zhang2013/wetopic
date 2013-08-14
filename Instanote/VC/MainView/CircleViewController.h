//
//  CircleViewController.h
//  Instanote
//
//  Created by CMD on 7/30/13.
//
//

#import <UIKit/UIKit.h>
#import "CircleEntity.h"
#import "CircleDetailViewController.h"
#import "CircleEntity.h"

@interface CircleViewController : UITableViewController
{
    NSMutableArray *fetchArray;
    int pagenum;
    int pagesize;
    int pagetype;
    NSString *circleId;
    CircleEntity *cEntity;
    
    CircleEntity * mycircle;
    //    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
    
    int totalcommentcount;
    int mLoadingDataType;
    
    CircleDetailViewController * cdvc;

}

@property (nonatomic, assign)NSString *circleId;
@property (nonatomic, retain)CircleEntity *cEntity;

@end
