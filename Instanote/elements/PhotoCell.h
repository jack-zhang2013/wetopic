//
//  PhotoCell.h
//  Instanote
//
//  Created by Man Tung on 12/27/12.
//
//

#import <UIKit/UIKit.h>
#import "TopicsEntity.h"
#import "CircleDetailImgsEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PhotoCell : UITableViewCell
{
    UIImageView *imageview;
}

@property (nonatomic, retain)TopicsEntity *topic;
@property (nonatomic, retain)UIImageView *imageview;

- (void)configurecell:(TopicsEntity *)top;

- (CGFloat)getcellheight;

@end
