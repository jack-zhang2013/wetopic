//
//  NewsFeedCell.m
//  Instanote
//
//  Created by CMD on 6/14/13.
//
//

#import "NewsFeedCell.h"
#import "UILabel+Extensions.h"
#import "TopicViewController.h"
#import "UserViewController.h"

@implementation NewsFeedCell

@synthesize authorNameButton;
@synthesize authorNameLabel;
@synthesize descLabel;

@synthesize authorView;
@synthesize authorViewButton;

@synthesize contentLabel;

@synthesize commentButton;
@synthesize commentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (!authorNameButton) {
            authorNameButton = [[UIButton alloc] initWithFrame:CGRectZero];
            [self addSubview:authorNameButton];
        }
        
        if (!authorNameLabel) {
            authorNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            authorNameLabel.textColor = [UIColor orangeColor];
            authorNameLabel.font = [UIFont fontWithName:FONT_NAME size:13];
            [self addSubview:authorNameLabel];
        }
        
        
        if (!descLabel) {
            descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            descLabel.font = [UIFont fontWithName:FONT_NAME size:13];
            descLabel.textColor = [UIColor grayColor];
            [self addSubview:descLabel];
        }
        
        if (!authorView) {
            authorView = [[UIImageView alloc] initWithFrame:CGRectZero];
            [self addSubview:authorView];
        }
        
        if (!authorViewButton) {
            authorViewButton = [[UIButton alloc] initWithFrame:CGRectZero];
            [self addSubview:authorViewButton];
        }
        
        if (!timeLabel) {
            timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            timeLabel.font = [UIFont fontWithName:FONT_NAME size:12];
            timeLabel.textColor = [UIColor grayColor];
            [self addSubview:timeLabel];
        }
        
        if (!contentLabel) {
            contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            contentLabel.font = [UIFont fontWithName:FONT_NAME size:15];
            contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [self addSubview:contentLabel];
        }
        
        if (!commentButton) {
            commentButton = [[UIButton alloc] initWithFrame:CGRectZero];
            [self addSubview:commentButton];
        }
        
        if (!commentLabel) {
            commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            commentLabel.font = [UIFont fontWithName:FONT_NAME size:13];
            commentLabel.textColor = [UIColor darkGrayColor];
            [self addSubview:commentLabel];
        }
        
        cellHeight = 0;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configurecell:(TopicsEntity *)top
{
    authorNameLabel.frame = CGRectMake(5, 5, 50, 14);
    authorNameLabel.text = top.userinfo.nick;
    [authorNameLabel sizeToFit];
    CGRect authorNameLabelRect = authorNameLabel.frame;
    authorNameLabel.frame = authorNameLabelRect;
    authorNameButton.frame = authorNameLabel.frame;
    authorNameButton.tag = top.userid;
    
    
    
    CGRect descLabelRect = authorNameLabel.frame;
    descLabelRect.origin.x = authorNameLabelRect.origin.x + authorNameLabelRect.size.width;
    descLabelRect.size.width = 150;
    descLabel.frame = descLabelRect;
    descLabel.text = @"创建了此话题";
    
    CGRect authorViewRect = CGRectMake(320 - 5 - 15, 5, 15, 15);
    authorView.frame = authorViewRect;
    
    NSString * image = top.userinfo.image;
    NSString * otheraccountuserimage = top.userinfo.otheraccountuserimage;
    if (![image length] && ![otheraccountuserimage length]) {
        
        [authorView setImage:[UIImage imageNamed:@"nobody_male.png"]];
        
    } else {
        NSString *realimage = image ? image : otheraccountuserimage;
        NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, realimage];
        [authorView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"nobody_male.png"]];
    }
    
    authorViewButton.frame = authorViewRect;
    authorViewButton.tag = top.userid;
    
    CGRect timeLabelRect = CGRectMake(177, 7, 120, 13);
    timeLabel.frame = timeLabelRect;
    timeLabel.text = [top timestamp:top.createdatetime];
    timeLabel.textAlignment = NSTextAlignmentRight;
    
    contentLabel.frame = CGRectMake(5, 25, 310, 15);
    contentLabel.text = top.title;
    [contentLabel sizeToFitFixedWidth:310];
    CGRect contentButtonRect = contentLabel.frame;
    
    int indexAt = 68;
    commentLabel.frame = CGRectMake(5, contentButtonRect.origin.y + contentButtonRect.size.height + 5, 310, 13);
    NSString *content = [top.circlecontent length] > indexAt ? [NSString stringWithFormat:@"%@...", [top.circlecontent substringToIndex:indexAt]] : top.circlecontent;
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    commentLabel.text = [[content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] stringByTrimmingCharactersInSet:whitespace];
    [commentLabel sizeToFitFixedWidth:310];
    CGRect commentLabelRect = commentLabel.frame;
    commentButton.frame = commentLabelRect;
    
//    CircleCommentInfosEntity *commentinfoentity =  top.circleCommentInfo[0];
//    [commentButton setTitle:commentinfoentity.commentinfo forState:UIControlStateNormal];
    
    cellHeight = commentLabelRect.origin.y + commentLabelRect.size.height + 5;
}

- (CGFloat)cellHeights
{
    return cellHeight;
}

- (void)dealloc
{
    [super dealloc];
    [authorNameButton release];
    [authorNameLabel release];
    [descLabel release];
    [authorView release];
    [authorViewButton release];
    [contentLabel release];
    [commentButton release];
    [commentLabel release];
}

@end
