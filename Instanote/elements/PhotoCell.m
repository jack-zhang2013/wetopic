//
//  PhotoCell.m
//  Instanote
//
//  Created by Man Tung on 12/27/12.
//
//

#import "PhotoCell.h"


@implementation PhotoCell
@synthesize imageview;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 310, 114)];
        [self addSubview:imageview];
    }
    return self;
}

- (void)configurecell:(TopicsEntity *)top
{
    CircleDetailImgsEntity * img = top.circleDetailImg[0];
    NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, img.bigimg];
    [imageview setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}

- (CGFloat)getcellheight
{
    return 118;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)dealloc
//{
//    [super dealloc];
//    [imageview release];
//}

@end
