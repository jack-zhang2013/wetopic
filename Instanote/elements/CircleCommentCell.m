//
//  CircleCommentCell.m
//  Instanote
//
//  Created by CMD on 8/8/13.
//
//

#import "CircleCommentCell.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CircleDetailImgsEntity.h"
#import "UILabel+Extensions.h"

@implementation CircleCommentCell
@synthesize userNameLabel, userImageview, commentContentLabel, timeLabel, cellheight;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        if (!userImageview) {
            CGFloat ImageSize = 30;
            CGFloat ImageFromTop = 10;
            userImageview = [[UIImageView alloc] initWithFrame:CGRectMake(ImageFromTop, ImageFromTop, ImageSize, ImageSize)];
            userImageview.backgroundColor = [UIColor whiteColor];
            [userImageview.layer setMasksToBounds:YES];
            CGFloat radius = ImageSize / 2;
            [userImageview.layer setCornerRadius:radius];
            [userImageview.layer setBorderWidth:1.0];
            UIColor * grayC = [UIColor colorWithRed:226/255.f green:226/255.f blue:226/255.f alpha:1];
            [userImageview.layer setBorderColor:[grayC CGColor]];
            [self addSubview:userImageview];
        }
        
        if (!userNameLabel) {
            userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 200, 20)];
            userNameLabel.backgroundColor = [UIColor clearColor];
            userNameLabel.textColor = [UIColor colorWithRed:219/255.f green:108/255.f blue:86/255.f alpha:1];
            userNameLabel.font = [UIFont fontWithName:FONT_NAME size:16];
            [self addSubview:userNameLabel];
        }
        
        if (!timeLabel) {
            timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 45, 200, 15)];
            timeLabel.textColor = [UIColor grayColor];
            timeLabel.backgroundColor = [UIColor clearColor];
            timeLabel.font = [UIFont fontWithName:FONT_NAME size:14];
            [self addSubview:timeLabel];
        }
        
        if (!commentContentLabel) {
            commentContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 65, 260, 20)];
            commentContentLabel.backgroundColor = [UIColor clearColor];
            commentContentLabel.font = [UIFont fontWithName:FONT_NAME size:16];
            [self addSubview:commentContentLabel];
        }
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configurecell:(CircleCommentInfosEntity *)circlecommetentity
{
    NSString * urlstring = circlecommetentity.userinfo.image;
    NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, urlstring];
    [userImageview setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"circle_placeholder.png"]];
    
    userNameLabel.text = circlecommetentity.userinfo.nick;
    
    timeLabel.text = [circlecommetentity timestamp:circlecommetentity.createdate];
    
    commentContentLabel.text = circlecommetentity.commentinfo;
    [commentContentLabel sizeToFitFixedWidth:260.f];
    cellheight = commentContentLabel.frame.size.height + commentContentLabel.frame.origin.y + 10;
}

- (CGFloat)cellHeights
{
    return cellheight;
}

@end
