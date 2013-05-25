//
//  PhotoHeaderView.m
//  Instanote
//
//  Created by Man Tung on 12/28/12.
//
//

#import "PhotoHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PhotoHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSub:(TopicsEntity *)tp
{
    [self setBackgroundColor:[UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:0.93]];
    UIImageView * useravatar = [[UIImageView alloc] initWithFrame:CGRectMake(5, 4, 35, 35)];
    NSString * imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, tp.userinfo.image];
    [useravatar setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [self addSubview:useravatar];
    [useravatar release];
    
    UILabel * username = [[UILabel alloc] initWithFrame:CGRectMake(42, 12, 150, 20)];
    username.textColor = [UIColor grayColor];
    username.backgroundColor = [UIColor clearColor];
    username.textColor = [UIColor orangeColor];
    username.text = [NSString stringWithFormat:@"%@", tp.userinfo.nick];
    username.font = [UIFont fontWithName:FONT_NAME size:16];
//    username.textAlignment = UITextAlignmentRight;
    [self addSubview:username];
    [username release];
    
    UILabel * creattime = [[UILabel alloc] initWithFrame:CGRectMake(135, 12, 180, 20)];
    creattime.textColor = [UIColor grayColor];
    creattime.backgroundColor = [UIColor clearColor];
    creattime.font = [UIFont fontWithName:FONT_NAME size:14];
    creattime.text = [tp timestamp:tp.createdatetime];
    creattime.textAlignment = UITextAlignmentRight;
    [self addSubview:creattime];
    [creattime release];
    
//    UIButton * detailButton = [[UIButton alloc] initWithFrame:CGRectMake(265, 5, 50, 20)];
//    [detailButton setBackgroundColor:[UIColor darkGrayColor]];
//    [detailButton setTitle:@"Go" forState:UIControlStateNormal];
//    [self addSubview:detailButton];
//    [detailButton release];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
