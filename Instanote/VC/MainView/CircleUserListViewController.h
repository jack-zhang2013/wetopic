//
//  CircleUserListViewController.h
//  Instanote
//
//  Created by CMD on 8/26/13.
//
//

#import <UIKit/UIKit.h>
#import "CircleEntity.h"

@interface CircleUserListViewController : UITableViewController
{
    NSMutableArray *fetchArray;
    int pagenum;
    int pagesize;
	BOOL _reloading;
    
    int totalcommentcount;
    int mLoadingDataType;
    
    CircleEntity * circleEntity;
    
}

@property (nonatomic, retain) CircleEntity * circleEntity;

@end
