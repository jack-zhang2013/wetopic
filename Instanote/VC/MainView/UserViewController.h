//
//  UserViewController.h
//  Instanote
//
//  Created by Man Tung on 3/21/13.
//
//

#import <UIKit/UIKit.h>
#import "UsersEntity.h"

@interface UserViewController : UITableViewController
{
    UIImageView * userCoverImage;
    UIImageView *userImageView;
    UILabel * userNameLabel;
    
    UILabel * userLevelLabel;
    UILabel * userAddressLabel;
    UILabel * userDescLablel;
    UILabel * userHobbyLable;
    
    
    UsersEntity * userentity;
    NSString * userId;
}

@property (nonatomic, retain)NSString * userId;
@property (nonatomic, retain)UsersEntity *userentity;

@end
