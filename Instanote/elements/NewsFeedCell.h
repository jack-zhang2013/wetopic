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
    UIButton * authornameButton;
    UILabel * descLabel;
    
    UIImageView * authorView;
    UIButton * authorviewButton;
    
    UIButton *contentButton;
    
    UIButton *commentButton;
    
    float cellheight;
}

@property (nonatomic, retain) UIButton * authornameButton;
@property (nonatomic, retain) UILabel * descLabel;

@property (nonatomic, retain) UIImageView * authorView;
@property (nonatomic, retain) UIButton * authorviewButton;

@property (nonatomic, retain) UIButton *contentButton;

@property (nonatomic, retain) UIButton *commentButton;

- (void)configurecell:(TopicsEntity *)top;

- (CGFloat)cellheights;

@end
