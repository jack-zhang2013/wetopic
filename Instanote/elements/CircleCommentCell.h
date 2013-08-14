//
//  CircleCommentCell.h
//  Instanote
//
//  Created by CMD on 8/8/13.
//
//

#import <UIKit/UIKit.h>
#import "CircleCommentInfosEntity.h"

@interface CircleCommentCell : UITableViewCell
{
    UIImageView *userImageview;
    UILabel *userNameLabel;
    UILabel *timeLabel;
    UILabel *commentContentLabel;
    CGFloat cellheight;
}

@property (nonatomic, retain)UIImageView *userImageview;
@property (nonatomic, retain)UILabel *userNameLabel;
@property (nonatomic, retain)UILabel *timeLabel;
@property (nonatomic, retain)UILabel *commentContentLabel;
@property (nonatomic, assign)CGFloat cellheight;

- (void)configurecell:(CircleCommentInfosEntity *)circlecommetentity;

- (CGFloat)cellHeights;

@end
