//
//  CommentCell.h
//  Instanote
//
//  Created by Man Tung on 1/6/13.
//
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CircleCommentInfosEntity.h"

@interface CommentCell : UITableViewCell
{
    UIImageView *userImageView;
    UILabel *cotentLabel;
//    UILabel *timeLabel;
    CGFloat cellheight;
    UILabel *commentcountLabel;
}

@property (nonatomic, retain)UIImageView *userImageView;
@property (nonatomic, retain)UILabel *contentLabel;
//@property (nonatomic, retain)UILabel *timeLabel;
@property (nonatomic, assign)CGFloat cellheight;
@property (nonatomic, retain)UILabel *commentcountLabel;

- (void)configurecell:(CircleCommentInfosEntity *)cce;

- (float)ch;

@end
