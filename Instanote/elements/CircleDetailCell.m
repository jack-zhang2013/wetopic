//
//  CircleDetailCell.m
//  Instanote
//
//  Created by CMD on 7/31/13.
//
//

#import "CircleDetailCell.h"
#import "UILabel+Extensions.h"
#import "CircleDetailImgsEntity.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CircleDetailCell
@synthesize circleCommentCount, circleDesc, cellheight, circleImage, circleTime, circleTitle;
@synthesize userImageView, userName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        if (!circleTitle) {
            circleTitle = [[UILabel alloc] initWithFrame:CGRectZero];
            circleTitle.textColor = [UIColor colorWithRed:219/255.f green:108/255.f blue:86/255.f alpha:1];
            circleTitle.font = [UIFont fontWithName:FONT_NAME_BOLD size:15];
            [self addSubview:circleTitle];
        }
        
        if (!circleDesc) {
            circleDesc = [[UILabel alloc] initWithFrame:CGRectZero];
            circleDesc.font = [UIFont fontWithName:FONT_NAME size:12];
            [self addSubview:circleDesc];
        }
        
        if (!circleTime) {
            circleTime = [[UILabel alloc] initWithFrame:CGRectZero];
            circleTime.font = [UIFont fontWithName:FONT_NAME size:11];
            circleTime.textColor = [UIColor grayColor];
            [self addSubview:circleTime];
        }
        
        if (!circleCommentCount) {
            circleCommentCount = [[UILabel alloc] initWithFrame:CGRectZero];
            circleCommentCount.font = [UIFont fontWithName:FONT_NAME size:11];
            circleCommentCount.textColor = [UIColor grayColor];
            circleCommentCount.textAlignment = NSTextAlignmentRight;
        }
        
        CGFloat ImageSize = 55.f;
        if (!circleImage) {
            circleImage = [[UIImageView alloc] initWithFrame:CGRectZero];
            circleImage.backgroundColor = [UIColor whiteColor];
            [circleImage.layer setMasksToBounds:YES];
            CGFloat radius = ImageSize / 2;
            [circleImage.layer setCornerRadius:radius];
            [circleImage.layer setBorderWidth:1.0];
            UIColor * grayC = [UIColor colorWithRed:226/255.f green:226/255.f blue:226/255.f alpha:1];
            [circleImage.layer setBorderColor:[grayC CGColor]];
            
        }
        if (!userImageView) {
            userImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            userImageView.backgroundColor = [UIColor whiteColor];
            [userImageView.layer setMasksToBounds:YES];
            CGFloat radius = ImageSize / 2;
            [userImageView.layer setCornerRadius:radius];
            [userImageView.layer setBorderWidth:1.0];
            UIColor * grayC = [UIColor colorWithRed:226/255.f green:226/255.f blue:226/255.f alpha:1];
            [userImageView.layer setBorderColor:[grayC CGColor]];
            
        }
        if (!userName) {
            userName = [[UILabel alloc] initWithFrame:CGRectZero];
            userName.textColor = [UIColor colorWithRed:219/255.f green:108/255.f blue:86/255.f alpha:1];
            userName.font = [UIFont fontWithName:FONT_NAME size:12];
        }
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)configurecell:(CircleDetailEntity *)circleentity
{
    circleTitle.frame = CGRectMake(10, 15, 222, 17);
    circleTitle.text = [self stringWithoutNbsp:circleentity.title];
    [circleTitle sizeToFitFixedWidth:222.f];
    
    CGFloat circleDescWidth = 220.f;
    CGFloat circleDescTop = circleTitle.frame.size.height + circleTitle.frame.origin.y + 10;
    circleDesc.frame = CGRectMake(10, circleDescTop, circleDescWidth, 17);
    circleDesc.text = [self stringWithoutNbsp:circleentity.circlecontent];
    [circleDesc sizeToFitFixedWidth:circleDescWidth];
    
    CGFloat circleTimeTop = circleDescTop + circleDesc.frame.size.height + 10;
    circleTime.text = [circleentity timestamp:circleentity.createdatetime];
    circleTime.frame = CGRectMake(10, circleTimeTop, 100, 12);
    
    circleCommentCount.text = [NSString stringWithFormat:@"%d回应", circleentity.comcount];
    circleCommentCount.frame = CGRectMake(137, circleTimeTop, 100, 12);
    [self addSubview:circleCommentCount];
    
    CGFloat ImageSize = 55.f;
    CGFloat ImageFromTop = 15.f;
    circleImage.frame = CGRectMake(320 - ImageFromTop - ImageSize, ImageFromTop, ImageSize, ImageSize);
    if ([circleentity.circleDetailImg count]) {
        CircleDetailImgsEntity * cdie = [circleentity.circleDetailImg objectAtIndex:0];
        NSString * urlstring = cdie.bigimg;
        NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, urlstring];
        [circleImage setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"circle_placeholder.png"]];
    } else {
        [circleImage setImage:[UIImage imageNamed:@"circle_placeholder.png"]];
    }
    [self addSubview:circleImage];
    
    cellheight = circleTimeTop + 30.f;
    
}

- (void)configurecellIndetail:(CircleDetailEntity *)circleentity
{
    circleTitle.frame = CGRectMake(10, 15, 290, 17);
    circleTitle.text = [self stringWithoutNbsp:circleentity.title];
    [circleTitle sizeToFitFixedWidth:290];
    
    CGFloat ImageSize = 55.f;
    CGFloat ImageFromTop = 15.f;
    userImageView.frame = CGRectMake(ImageFromTop, circleTitle.frame.origin.y + circleTitle.frame.size.height + ImageFromTop, ImageSize, ImageSize);
    NSString * urlstring = circleentity.userinfo.image;
    NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, urlstring];
    [userImageView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [self addSubview:userImageView];
    
    CGFloat circleUserNameTop = circleTitle.frame.size.height + circleTitle.frame.origin.y + 25;
    userName.text = circleentity.userinfo.nick;
    userName.frame = CGRectMake(80, circleUserNameTop, 200, 15);
    [self addSubview:userName];
    
    CGFloat circleTimeTop = userName.frame.size.height + userName.frame.origin.y + 15;
    circleTime.text = [circleentity timestamp:circleentity.createdatetime];
    circleTime.frame = CGRectMake(83, circleTimeTop, 200, 15);
    
    CGFloat circleDescTop = userImageView.frame.size.height + userImageView.frame.origin.y + 10;
    circleDesc.frame = CGRectMake(15, circleDescTop, 290, 17);
    circleDesc.text = [self stringWithoutNbsp:circleentity.circlecontent];
    [circleDesc sizeToFitFixedWidth:290];
    
    cellheight = circleDesc.frame.origin.y + circleDesc.frame.size.height + 30.f;
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

- (CGFloat)cellHeights
{
    return cellheight;
}

@end
