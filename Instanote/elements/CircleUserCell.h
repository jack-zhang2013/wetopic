//
//  CircleUserCell.h
//  Instanote
//
//  Created by CMD on 8/26/13.
//
//

#import <UIKit/UIKit.h>
#import "UsersEntity.h"

@interface CircleUserCell : UITableViewCell
{
    UIImageView *avatarImageView;
    UILabel *nameLabel;
    UILabel *descLabel;
    CGFloat height;
    UIButton *authorViewButton;
}

@property (nonatomic, retain)UIButton *authorViewButton;

- (void)configCell:(UsersEntity *)userentity;
- (CGFloat)cellHeights;

@end
