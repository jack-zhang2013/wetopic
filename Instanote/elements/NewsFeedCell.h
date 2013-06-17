//
//  NewsFeedCell.h
//  Instanote
//
//  Created by CMD on 6/14/13.
//
//

#import <UIKit/UIKit.h>
#import "TopicsEntity.h"
#import "CircleDetailImgsEntity.h"
#import "CircleCommentInfosEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NewsFeedCell : UITableViewCell
{
    UIButton *authorNameButton;
    UILabel *authorNameLabel;
    UILabel *descLabel;
    
    UIImageView *authorView;
    UIButton *authorViewButton;
    
    UILabel *contentLabel;
    
    UIButton *commentButton;
    UILabel *commentLabel;
    
    float cellHeight;
}

@property (nonatomic, retain) UIButton * authorNameButton;
@property (nonatomic, retain) UILabel * authorNameLabel;
@property (nonatomic, retain) UILabel * descLabel;

@property (nonatomic, retain) UIImageView * authorView;
@property (nonatomic, retain) UIButton * authorViewButton;

@property (nonatomic, retain) UILabel *contentLabel;

@property (nonatomic, retain) UIButton *commentButton;
@property (nonatomic, retain) UILabel *commentLabel;

- (void)configurecell:(TopicsEntity *)top;

- (CGFloat)cellHeights;

@end
