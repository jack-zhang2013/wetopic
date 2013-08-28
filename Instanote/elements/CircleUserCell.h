//
//  CircleUserCell.h
//  Instanote
//
//  Created by CMD on 8/26/13.
//
//

#import <UIKit/UIKit.h>

@interface CircleUserCell : UITableViewCell
{
    UIImageView *avatarA;
    UIImageView *avatarB;
    UIImageView *avatarC;
    UIImageView *avatarD;
    UILabel *userNameA;
    UILabel *userNameB;
    UILabel *userNameC;
    UILabel *userNameD;
    UIButton *userInfoA;
    UIButton *userInfoB;
    UIButton *userInfoC;
    UIButton *userInfoD;
}

@property (nonatomic, retain)UIImageView *avatarA;
@property (nonatomic, retain)UIImageView *avatarB;
@property (nonatomic, retain)UIImageView *avatarC;
@property (nonatomic, retain)UIImageView *avatarD;
@property (nonatomic, retain)UILabel *userNameA;
@property (nonatomic, retain)UILabel *userNameB;
@property (nonatomic, retain)UILabel *userNameC;
@property (nonatomic, retain)UILabel *userNameD;
@property (nonatomic, retain)UIButton *userInfoA;
@property (nonatomic, retain)UIButton *userInfoB;
@property (nonatomic, retain)UIButton *userInfoC;
@property (nonatomic, retain)UIButton *userInfoD;

@end
