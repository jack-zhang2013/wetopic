//
//  CircleDetailCell.h
//  Instanote
//
//  Created by CMD on 7/31/13.
//
//
#import <UIKit/UIKit.h>
#import "CircleDetailEntity.h"

@interface CircleDetailCell : UITableViewCell
{
    UILabel *circleTitle;
    UILabel *circleDesc;
    UILabel *circleTime;
    UILabel *circleCommentCount;
    UIImageView *circleImage;
    UIImageView *userImageView;
    UILabel *userName;
    CGFloat cellheight;
}

@property (nonatomic, retain)UILabel *circleTitle;
@property (nonatomic, retain)UILabel *circleDesc;
@property (nonatomic, retain)UILabel *circleTime;
@property (nonatomic, retain)UILabel *circleCommentCount;
@property (nonatomic, retain)UIImageView *circleImage;
@property (nonatomic, assign)CGFloat cellheight;
@property (nonatomic, retain)UIImageView *userImageView;
@property (nonatomic, retain)UILabel *userName;

- (void)configurecell:(CircleDetailEntity *)circleentity;

- (void)configurecellIndetail:(CircleDetailEntity *)circleentity;

- (CGFloat)cellHeights;

@end
