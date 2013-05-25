//
//  CommentCell.m
//  Instanote
//
//  Created by Man Tung on 1/6/13.
//
//

#import "CommentCell.h"
#import "CircleCommentInfosEntity.h"
#import "UILabel+Extensions.h"
#import "NSString+HTML.h"
#import <QuartzCore/QuartzCore.h>

@implementation CommentCell
@synthesize userImageView;
@synthesize contentLabel;
//@synthesize timeLabel;
@synthesize cellheight;
@synthesize commentcountLabel;

#define SUBSTRING_LENGTH 60

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
        userImageView.layer.cornerRadius = 3.0f;
        userImageView.layer.masksToBounds = YES;
        [self addSubview:userImageView];
        
//        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 180, 13)];
//        timeLabel.textAlignment = UITextAlignmentLeft;
//        timeLabel.textColor = [UIColor orangeColor];
//        timeLabel.font = [UIFont fontWithName:FONT_NAME size:13];
//        [self addSubview:timeLabel];
        
        commentcountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 180, 13)];
        commentcountLabel.textAlignment = UITextAlignmentLeft;
        commentcountLabel.textColor = [UIColor whiteColor];
        commentcountLabel.backgroundColor = [UIColor orangeColor];
        commentcountLabel.layer.cornerRadius = 3.0f;
        commentcountLabel.textAlignment = NSTextAlignmentCenter;
        commentcountLabel.font = [UIFont fontWithName:FONT_NAME size:12];
        
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 0, 0)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.font = [UIFont fontWithName:FONT_NAME size:15];
        [contentLabel setNumberOfLines:0];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview:contentLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configurecell:(CircleCommentInfosEntity *)cce
{
    NSString *stringurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, cce.userinfo.image];
    [userImageView setImageWithURL:[NSURL URLWithString:stringurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    NSString * info = [[self stringWithoutNbsp:cce.commentinfo] stringByConvertingHTMLToPlainText];
    
    contentLabel.text = info;
    [contentLabel sizeToFitFixedWidth:270];
    
    commentcountLabel.frame = CGRectMake(10, 40, 25, 15);
    commentcountLabel.text = cce.def1;
//    [commentcountLabel sizeToFit];
    [self addSubview:commentcountLabel];
    
    
//    timeLabel.text = [cce timestamp:cce.createdate];
//    timeLabel.frame = CGRectMake(40, contentLabel.frame.size.height + contentLabel.frame.origin.y + 5, 100, 15);
    
    if (contentLabel.frame.size.height < 40) {
        cellheight = 65.f;
    } else {
        cellheight = contentLabel.frame.size.height + 18.f;
    }
}

- (NSString *)stringWithoutNbsp:(NSString *)agr
{
    NSString * info = [[NSString alloc] init];
    info = [agr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
//    if ([info length] > SUBSTRING_LENGTH) {
//        info = [NSString stringWithFormat:@"%@...", [info substringToIndex:SUBSTRING_LENGTH]];
//    }
    return info;
}

- (CGFloat)ch
{
    return cellheight;
}

//- (void)dealloc
//{
//    [super dealloc];
//    [userImageView release];
//    [timeLabel release];
//    [contentLabel release];
//}

@end
