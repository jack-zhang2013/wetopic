//
//  LeftViewController.h
//  Chinesetoday
//
//  Created by CMD on 6/3/13.
//  Copyright (c) 2013 Man Tung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UITableViewController
{
    UIImageView *avatarView;
    UILabel *userName;
    UILabel *userDesc;
    
    UIButton *signoutButton;
}

@property (nonatomic, retain)UIImageView *avatarView;
@property (nonatomic, retain)UILabel *userName;
@property (nonatomic, retain)UILabel *userDesc;

@end
