//
//  TopicDetailCell.h
//  Instanote
//
//  Created by Man Tung on 1/30/13.
//
//

#import <UIKit/UIKit.h>
#import "TopicsEntity.h"
#import "CircleDetailImgsEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TopicDetailCell : UITableViewCell
{
    UIImageView *imageviewavatar;
    UILabel * avatarnamelabel;
    
    UILabel * timelabel;
    UILabel * commentcountlabel;
    UIImageView *imageviewcommentcount;
    UIImageView *imageviewtime;
    
    UIImageView *imageviewcontent;
    
    UILabel * titlelabel;
    UILabel * contentlabel;
    
    float cellheight;
}

@property (nonatomic, retain)UIImageView *imageviewavatar;
@property (nonatomic, retain)UILabel * avatarnamelabel;

@property (nonatomic, retain)UILabel * timelabel;
@property (nonatomic, retain)UILabel * commentcountlabel;
@property (nonatomic, retain)UIImageView *imageviewcommentcount;
@property (nonatomic, retain)UIImageView *imageviewtime;

@property (nonatomic, retain)UIImageView *imageviewcontent;

@property (nonatomic, retain)UILabel * titlelabel;
@property (nonatomic, retain)UILabel * contentlabel;

- (void)configurecell:(TopicsEntity *)top;

- (CGFloat)cellheights;

@end
