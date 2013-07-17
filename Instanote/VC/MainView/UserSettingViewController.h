//
//  UserSettingViewController.h
//  Instanote
//
//  Created by CMD on 7/11/13.
//
//

#import <UIKit/UIKit.h>
#import "UsersEntity.h"

@interface UserSettingViewController : UITableViewController <UITextFieldDelegate, UITextViewDelegate>
{
    UIImageView * userCoverImage;
    UIImageView *userImageView;
    
    UITextField * userNameTextField;
    UITextView * userDescTextView;
    
    UsersEntity * userentity;
    int userId;
}

@property (nonatomic, assign)int userId;
@property (nonatomic, retain)UsersEntity *userentity;

@property (nonatomic, assign) id finishTarget;
@property (nonatomic, assign) SEL finishAction;

@end
