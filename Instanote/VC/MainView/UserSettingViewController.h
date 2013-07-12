//
//  UserSettingViewController.h
//  Instanote
//
//  Created by CMD on 7/11/13.
//
//

#import <UIKit/UIKit.h>
#import "UsersEntity.h"

@interface UserSettingViewController : UITableViewController
{
    UIImageView * userCoverImage;
    UIImageView *userImageView;
    
    UITextField * userNameTextField;
    UITextView * userDescTextField;
    
    UsersEntity * userentity;
    int userId;
}

@property (nonatomic, assign)int userId;
@property (nonatomic, retain)UsersEntity *userentity;

@end
