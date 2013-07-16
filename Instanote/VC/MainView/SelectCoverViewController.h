//
//  SelectCoverViewController.h
//  Instanote
//
//  Created by CMD on 7/15/13.
//
//

#import <UIKit/UIKit.h>

@interface SelectCoverViewController : UITableViewController
{
    int covertype;
}

@property (nonatomic, assign) int covertype;
@property (nonatomic, assign) id finishTarget;
@property (nonatomic, assign) SEL finishAction;

@end
