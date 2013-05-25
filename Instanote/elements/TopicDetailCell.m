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

@implementation TopicDetailCell
@synthesize imageviewavatar, imageviewcommentcount, imageviewcontent;
@synthesize commentcountlabel, contentlabel, timelabel, imageviewtime, titlelabel, avatarnamelabel;

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
        
        //time & comment
        
        if (!imageviewcommentcount) {
            imageviewcommentcount = [[UIImageView alloc] initWithFrame:CGRectMake(150, 13, 12, 12)];
            imageviewcommentcount.image = [UIImage imageNamed:@"comment_count.png"];
//            [self addSubview:imageviewcommentcount];
        }
        if (!commentcountlabel) {
            commentcountlabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 12, 38, 15)];
            commentcountlabel.backgroundColor = [UIColor clearColor];
            commentcountlabel.font = [UIFont fontWithName:FONT_NAME size:14];
            commentcountlabel.textColor = [UIColor orangeColor];
            [self addSubview:commentcountlabel];
        }
        
        if (!imageviewtime) {
            imageviewtime = [[UIImageView alloc] initWithFrame:CGRectMake(188, 14, 12, 12)];
            imageviewtime.image = [UIImage imageNamed:@"clock.png"];
//            [self addSubview:imageviewtime];
        }
        if (!timelabel) {
            timelabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 12, 80, 15)];
            timelabel.backgroundColor = [UIColor clearColor];
            timelabel.font = [UIFont fontWithName:FONT_NAME size:14];
            timelabel.textAlignment = UITextAlignmentRight;
            timelabel.textColor = [UIColor grayColor];
            [self addSubview:timelabel];
        }
        
        
        if (!imageviewcontent) {
            imageviewcontent = [[UIImageView alloc] initWithFrame:CGRectMake(5, 40, 310, 114)];
            [self addSubview:imageviewcontent];
        }
        
        if (!titlelabel) {
            titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 159, 300, 20)];
            titlelabel.backgroundColor = [UIColor clearColor];
            titlelabel.textColor = [UIColor orangeColor];
            titlelabel.font = [UIFont fontWithName:FONT_NAME size:20];
            [self addSubview:titlelabel];
        }
        
        if (!contentlabel) {
            contentlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 182, 300, 20)];
            contentlabel.backgroundColor = [UIColor clearColor];
            contentlabel.font = [UIFont fontWithName:FONT_NAME size:17];
            contentlabel.textColor = [UIColor blackColor];
            [self addSubview:contentlabel];
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
    CGFloat timelabelx = 320 - timelabel.frame.size.width - 5;
    timelabel.frame = CGRectMake(timelabelx, 12, timelabel.frame.size.width, timelabel.frame.size.height);
    
    CGRect imageviewtimerect = imageviewtime.frame;
    imageviewtimerect.origin.x = 320 - timelabel.frame.size.width - 13;
    imageviewtime.frame = imageviewtimerect;
    
    
    CircleDetailImgsEntity * img = top.circleDetailImg[0];
    NSString *url_content = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, img.bigimg];
    
    [imageviewcontent setImageWithURL:[NSURL URLWithString:url_content] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    titlelabel.text = top.title;
    
    [titlelabel sizeToFitFixedWidth:300];
    
    contentlabel.text = [self stringWithoutNbsp:top.circlecontent];
    [contentlabel sizeToFitFixedWidth:300];
    CGRect contentframe = CGRectMake(contentlabel.frame.origin.x, titlelabel.frame.origin.y + titlelabel.frame.size.height + 5, contentlabel.frame.size.width, contentlabel.frame.size.height);
    contentlabel.frame = contentframe;
    
    
    commentcountlabel.text = [NSString stringWithFormat:@"%d条评论", top.comcount];
    [commentcountlabel sizeToFit];
    
//    CGRect imageviewcommentrect = CGRectZero;
//    imageviewcommentrect.origin.x = 5;
//    imageviewcommentrect.origin.y = contentframe.origin.y + contentframe.size.height + 8;
//    imageviewcommentrect.size.width = 12;
//    imageviewcommentrect.size.height = 12;
//    imageviewcommentcount.frame = imageviewcommentrect;
    
    CGRect lablelcountrect = CGRectZero;
    lablelcountrect.origin.x = 10;
    lablelcountrect.origin.y = contentframe.origin.y + contentframe.size.height + 5;
    lablelcountrect.size.width = commentcountlabel.frame.size.width;
    lablelcountrect.size.height = 16;
    commentcountlabel.frame = lablelcountrect;
    
    cellheight = contentframe.origin.y + contentframe.size.height + 30.f;
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
