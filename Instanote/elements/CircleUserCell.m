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

@implementation CircleUserCell

@synthesize userInfoA, userInfoB, userInfoC, userInfoD;
@synthesize userNameA, userNameB, userNameC, userNameD;
@synthesize avatarA, avatarB, avatarC, avatarD;

static int avatarSize = 50;
static int radius = 25;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIColor * grayC = [UIColor colorWithRed:226/255.f green:226/255.f blue:226/255.f alpha:1];
        if (!avatarA) {
            avatarA = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, avatarSize, avatarSize)];
            avatarA.backgroundColor = [UIColor whiteColor];
            [avatarA.layer setMasksToBounds:YES];
            [avatarA.layer setCornerRadius:radius];
            [avatarA.layer setBorderWidth:1.0];
            [avatarA.layer setBorderColor:[grayC CGColor]];
            [self addSubview:avatarA];
        }
        if (!avatarB) {
            avatarB = [[UIImageView alloc] initWithFrame:CGRectMake(95, 15, avatarSize, avatarSize)];
            avatarB.backgroundColor = [UIColor whiteColor];
            [avatarB.layer setMasksToBounds:YES];
            [avatarB.layer setCornerRadius:radius];
            [avatarB.layer setBorderWidth:1.0];
            [avatarB.layer setBorderColor:[grayC CGColor]];
            [self addSubview:avatarB];
        }
        if (!avatarC) {
            avatarC = [[UIImageView alloc] initWithFrame:CGRectMake(175, 15, avatarSize, avatarSize)];
            avatarC.backgroundColor = [UIColor whiteColor];
            [avatarC.layer setMasksToBounds:YES];
            [avatarC.layer setCornerRadius:radius];
            [avatarC.layer setBorderWidth:1.0];
            [avatarC.layer setBorderColor:[grayC CGColor]];
            [self addSubview:avatarC];
        }
        if (!avatarD) {
            avatarD = [[UIImageView alloc] initWithFrame:CGRectMake(255, 15, avatarSize, avatarSize)];
            avatarD.backgroundColor = [UIColor whiteColor];
            [avatarD.layer setMasksToBounds:YES];
            [avatarD.layer setCornerRadius:radius];
            [avatarD.layer setBorderWidth:1.0];
            [avatarD.layer setBorderColor:[grayC CGColor]];
            [self addSubview:avatarD];
        }
        
        if (!userNameA) {
            userNameA = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 80, 15)];
            userNameA.backgroundColor = [UIColor clearColor];
            userNameA.textColor = [UIColor grayColor];
            userNameA.font = [UIFont fontWithName:FONT_NAME size:16];
            [self addSubview:userNameA];
        }
        if (!userNameB) {
            [userNameB = [UILabel alloc] initWithFrame:CGRectMake(80, 80, 80, 15)];
            userNameB.backgroundColor = [UIColor clearColor];
            userNameB.textColor = [UIColor grayColor];
            userNameB.font = [UIFont fontWithName:FONT_NAME size:16];
            [self addSubview:userNameB];
        }
        if (!userNameC) {
            [userNameC = [UILabel alloc] initWithFrame:CGRectMake(160, 80, 80, 15)];
            userNameC.backgroundColor = [UIColor clearColor];
            userNameC.textColor = [UIColor grayColor];
            userNameC.font = [UIFont fontWithName:FONT_NAME size:16];
            [self addSubview:userNameC];
        }
        if (!userNameD) {
            [userNameD = [UILabel alloc] initWithFrame:CGRectMake(240, 80, 80, 15)];
            userNameD.backgroundColor = [UIColor clearColor];
            userNameD.textColor = [UIColor grayColor];
            userNameD.font = [UIFont fontWithName:FONT_NAME size:16];
            [self addSubview:userNameD];
        }
        
        
        if (!userInfoA) {
            userInfoA = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 110)];
        }
        if (!userInfoB) {
            userInfoB = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 80, 110)];
        }
        if (userInfoC) {
            userInfoC = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 80, 110)];
        }
        if (userInfoD) {
            userInfoD = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 80, 110)];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
    [userNameA release];
    [userNameB release];
    [userNameC release];
    [userNameD release];
    
    [userInfoA release];
    [userInfoB release];
    [userInfoC release];
    [userInfoD release];
    
    [avatarA release];
    [avatarB release];
    [avatarC release];
    [avatarD release];
}

@end
