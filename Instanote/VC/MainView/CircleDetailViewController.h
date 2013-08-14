//
//  CircleDetailViewController.h
//  Instanote
//
//  Created by CMD on 7/31/13.
//
//

#import <UIKit/UIKit.h>
#import "CircleDetailEntity.h"

@interface CircleDetailViewController : UITableViewController
{
    CircleDetailEntity * circleDetailEntity;
    NSMutableArray *fetchArray;
    int pagenum;
    int pagesize;
	BOOL _reloading;
    
    int totalcommentcount;
    int mLoadingDataType;
    
    UILabel *circleDetialTitleLabel;
    UILabel *circleDetailContentLabel;
}

@property (nonatomic, retain) CircleDetailEntity * circleDetailEntity;

@end
