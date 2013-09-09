//
//  CircleUserCell.m
//  Instanote
//
//  Created by CMD on 8/26/13.
//
//

#import "CircleUserCell.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UsersEntity.h"
#import "UILabel+Extensions.h"

@implementation CircleUserCell
@synthesize authorViewButton;
static int avatarSize = 50;
static int radius = 25;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        if (!avatarImageView) {
            avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, avatarSize, avatarSize)];
            avatarImageView.backgroundColor = [UIColor whiteColor];
            [avatarImageView.layer setMasksToBounds:YES];
            [avatarImageView.layer setCornerRadius:radius];
            [avatarImageView.layer setBorderWidth:1.0];
            UIColor * grayC = [UIColor colorWithRed:226/255.f green:226/255.f blue:226/255.f alpha:1];
            [avatarImageView.layer setBorderColor:[grayC CGColor]];
            [self addSubview:avatarImageView];
        }
        if (!authorViewButton) {
            authorViewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
            [self addSubview:authorViewButton];
        }
        
        if (!nameLabel) {
            nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 17, 240, 17)];
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.font = [UIFont fontWithName:FONT_NAME_BOLD size:16];
            [self addSubview:nameLabel];
        }
        
        if (!descLabel) {
            descLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 45, 240, 15)];
            descLabel.backgroundColor = [UIColor clearColor];
            descLabel.font = [UIFont fontWithName:FONT_NAME size:14];
            descLabel.textColor = [UIColor grayColor];
            [self addSubview:descLabel];
        }
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCell:(UsersEntity *)userentity
{
    NSString * urlstring = userentity.image;
    NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, urlstring];
    [avatarImageView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"circle_placeholder.png"]];
    
    nameLabel.text = userentity.nick;
    descLabel.text = userentity.what;
    [descLabel sizeToFitFixedWidth:240];
    height = descLabel.frame.origin.y + descLabel.frame.size.height + 15;
    
    authorViewButton.tag = userentity.userid;
}

- (CGFloat)cellHeights
{
    if (height < 80) {
        height = 80;
    }
    return height;
}

- (void)dealloc
{
    [super dealloc];
    [avatarImageView release];
    [nameLabel release];
    [descLabel release];
    [authorViewButton release];
}

@end
