//
//  CommentDetailViewController.m
//  Instanote
//
//  Created by Man Tung on 3/28/13.
//
//

#import "CommentDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UILabel+Extensions.h"

@interface CommentDetailViewController ()

@end

@implementation CommentDetailViewController
@synthesize mycomment;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    UIButton * btn_back = [[UIButton alloc] initWithFrame:CGRectMake(10, 13, 24, 16)];
//    [btn_back setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
//    [btn_back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar addSubview:btn_back];
    
    self.navigationItem.leftBarButtonItem = [self leftButtonGen];
    
	// Do any additional setup after loading the view.
    UIScrollView * scrollview = [[UIScrollView alloc] init];
    
    CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
    webFrame.origin.y = 44.f;
    webFrame.size.height -= 88.f;
    scrollview.frame = webFrame;
    [self.view addSubview:scrollview];
    [scrollview release];
    
    UIView * bannerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    bannerview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header.png"]];
    [self.view addSubview:bannerview];
    
    UIImageView * avatarview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 34, 34)];
    NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, mycomment.userinfo.image];
    [avatarview setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [bannerview addSubview:avatarview];
    UILabel * usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 15, 260, 17)];
    usernameLabel.backgroundColor = [UIColor clearColor];
    usernameLabel.textColor = [UIColor orangeColor];
    usernameLabel.text = mycomment.userinfo.nick;
    usernameLabel.font = [UIFont fontWithName:FONT_NAME size:15];
    [bannerview addSubview:usernameLabel];
    
    UILabel * userdesc = [[UILabel alloc] initWithFrame:CGRectMake(44, 25, 100, 15)];
    userdesc.backgroundColor = [UIColor clearColor];
    userdesc.textColor = [UIColor orangeColor];
    userdesc.text = mycomment.userinfo.what;
    userdesc.font = [UIFont fontWithName:FONT_NAME size:13];
    [bannerview addSubview:userdesc];
    
    
//    UIButton * agreeButton = [[UIButton alloc] initWithFrame:CGRectMake(284, 8, 28, 28)];
//    [agreeButton setBackgroundImage:[UIImage imageNamed:@"agree.png"] forState:UIControlStateNormal];
//    [agreeButton addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
//    [bannerview addSubview:agreeButton];
//    [agreeButton release];
//    
//    UIButton *disagreeButton = [[UIButton alloc] initWithFrame:CGRectMake(246, 8, 28, 28)];
//    [disagreeButton setBackgroundImage:[UIImage imageNamed:@"disagree.png"] forState:UIControlStateNormal];
//    [disagreeButton addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
//    [bannerview addSubview:disagreeButton];
//    [disagreeButton release];
    
    UILabel * contentlabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 15)];
    contentlabel.backgroundColor = [UIColor clearColor];
    contentlabel.font = [UIFont fontWithName:FONT_NAME size:17];
    contentlabel.text = [self stringWithoutNbsp:mycomment.commentinfo];
    [contentlabel sizeToFitFixedWidth:310];
    [scrollview addSubview:contentlabel];
    
    scrollview.contentSize = CGSizeMake(320, contentlabel.frame.size.height + 10);
    
    UISwipeGestureRecognizer * swipegr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    [self.view addGestureRecognizer:swipegr];
    [swipegr release];
//    [scrollview release];
}

- (UIBarButtonItem *)leftButtonGen {
    UIImage *faceImage = [UIImage imageNamed:@"arrow.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 0, 0, 24, 16 );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self
             action:@selector(backAction)
   forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)agreeAction
{
    NSLog(@"hello,world!");
}

- (NSString *)stringWithoutNbsp:(NSString *)agr
{
    NSString * info = [[NSString alloc] init];
    info = [agr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    return info;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [super dealloc];
}

@end
