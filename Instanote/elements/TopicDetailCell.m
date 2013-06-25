//
//  TopicDetailCell.m
//  Instanote
//
//  Created by Man Tung on 1/30/13.
//
//

#import "TopicDetailCell.h"
#import "UILabel+Extensions.h"
#import "TopicsEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>

@implementation TopicDetailCell
@synthesize imageviewavatar;
@synthesize commentcountlabel, contentlabel, timelabel, titlelabel, avatarnamelabel;
@synthesize commentButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        //
        if (!imageviewavatar) {
            imageviewavatar = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
            [self addSubview:imageviewavatar];
        }
        
        if (!avatarnamelabel) {
            avatarnamelabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 12, 120, 16)];
            avatarnamelabel.backgroundColor = [UIColor clearColor];
            avatarnamelabel.textColor = [UIColor orangeColor];
            avatarnamelabel.font = [UIFont fontWithName:FONT_NAME size:15];
            [self addSubview:avatarnamelabel];
        }
        
        if (!timelabel) {
            timelabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 12, 80, 15)];
            timelabel.backgroundColor = [UIColor clearColor];
            timelabel.font = [UIFont fontWithName:FONT_NAME size:14];
            timelabel.textAlignment = UITextAlignmentRight;
            timelabel.textColor = [UIColor grayColor];
            [self addSubview:timelabel];
        }
        
        if (!commentcountlabel) {
            commentcountlabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 12, 38, 15)];
            commentcountlabel.backgroundColor = [UIColor clearColor];
            commentcountlabel.font = [UIFont fontWithName:FONT_NAME size:14];
            commentcountlabel.textColor = [UIColor orangeColor];
            [self addSubview:commentcountlabel];
        }
        
                
//        if (!imageviewcontent) {
//            imageviewcontent = [[UIImageView alloc] initWithFrame:CGRectZero];
//            [self addSubview:imageviewcontent];
//        }
        
        if (!titlelabel) {
            titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
            titlelabel.backgroundColor = [UIColor clearColor];
            titlelabel.font = [UIFont fontWithName:FONT_NAME size:16];
            [self addSubview:titlelabel];
        }
        
        if (!contentlabel) {
            contentlabel = [[UILabel alloc] initWithFrame:CGRectZero];
            contentlabel.backgroundColor = [UIColor clearColor];
            contentlabel.font = [UIFont fontWithName:FONT_NAME size:14];
            contentlabel.textColor = [UIColor grayColor];
            [self addSubview:contentlabel];
        }
        
        if (!commentButton) {
            commentButton = [[UIButton alloc] initWithFrame:CGRectZero];
            [self addSubview:commentButton];
        }
        
        cellheight = 0;
        
    }
    return self;
}

- (void)configurecell:(TopicsEntity *)top
{
    NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, top.userinfo.image];
    [imageviewavatar setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    avatarnamelabel.text = top.userinfo.nick;
    
    timelabel.text = [top timestamp:top.createdatetime];
    [timelabel sizeToFit];
    CGFloat timelabelX = 320 - timelabel.frame.size.width - 5;
    timelabel.frame = CGRectMake(timelabelX, 12, timelabel.frame.size.width, timelabel.frame.size.height);
    
//    CircleDetailImgsEntity * img = top.circleDetailImg[0];
//    NSString *url_content = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, img.bigimg];
//    
//    [imageviewcontent setImageWithURL:[NSURL URLWithString:url_content] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    titlelabel.frame = CGRectMake(5, 42, 310, 15);
    titlelabel.text = top.title;
    [titlelabel sizeToFitFixedWidth:310];
    CGRect titlelabelRect = CGRectMake(titlelabel.frame.origin.x, titlelabel.frame.origin.y, titlelabel.frame.size.width, timelabel.frame.size.height);
    titlelabel.frame = titlelabelRect;
    
    contentlabel.text = [self stringWithoutNbsp:top.circlecontent];
    [contentlabel sizeToFitFixedWidth:310];
    CGRect contentlabelRect = CGRectMake(5, titlelabel.frame.origin.y + titlelabel.frame.size.height + 3, contentlabel.frame.size.width, contentlabel.frame.size.height);
    contentlabel.frame = contentlabelRect;
    
    commentcountlabel.text = [NSString stringWithFormat:@"%d条评论", top.comcount];
    commentcountlabel.backgroundColor = [UIColor orangeColor];
    commentcountlabel.textColor = [UIColor whiteColor];
    commentcountlabel.layer.cornerRadius = 3.0f;
    commentcountlabel.textAlignment = NSTextAlignmentCenter;
    commentcountlabel.layer.masksToBounds = YES;
    [commentcountlabel sizeToFit];
    CGRect countlabelRect = CGRectMake(5, contentlabelRect.origin.y + contentlabelRect.size.height + 5, commentcountlabel.frame.size.width + 7, 25);
    commentcountlabel.frame = countlabelRect;
    
    commentButton.frame = CGRectMake(215, countlabelRect.origin.y, 100, 25);
    commentButton.backgroundColor = [UIColor orangeColor];
    commentButton.layer.cornerRadius = 3.0f;
    commentButton.titleLabel.font = [UIFont fontWithName:FONT_NAME size:14];
    commentButton.layer.masksToBounds = YES;
    [commentButton setTitle:@"添加新评论" forState:UIControlStateNormal];
    
    cellheight = contentlabelRect.origin.y + contentlabelRect.size.height + 38.f;
}

- (NSString *)stringWithoutNbsp:(NSString *)agr
{
    NSString * info = [[NSString alloc] init];
    info = [agr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    return info;
}

- (CGFloat)cellheights
{
    return cellheight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)dealloc
//{
//    [super dealloc];
//    [imageviewcommentcount release];
//    [imageviewavatar release];
//    [imageviewcontent release];
//    [commentcountlabel release];
//    [timelabel release];
//    [contentlabel release];
//}

@end
