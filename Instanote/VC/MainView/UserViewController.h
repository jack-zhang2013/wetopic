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
    
//    UIView * bannerView;
//    UIButton * allNewsFeedButton;
    
    
    UsersEntity * userentity;
    int userId;
}

@property (nonatomic, assign)int userId;
@property (nonatomic, retain)UsersEntity *userentity;

//- (void)allNewsFeedAction;

@end
