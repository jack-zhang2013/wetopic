//
//  CircleListViewController.h
//  Instanote
//
//  Created by CMD on 7/23/13.
//
//

#import <UIKit/UIKit.h>
#import "XLCycleScrollView.h"

@interface CircleListViewController : UIViewController <XLCycleScrollViewDatasource,XLCycleScrollViewDelegate>
{
    NSMutableArray *circleArray;
}

@end
