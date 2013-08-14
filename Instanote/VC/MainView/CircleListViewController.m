//
//  CircleListViewController.m
//  Instanote
//
//  Created by CMD on 7/23/13.
//
//

#import "CircleListViewController.h"
#import "CircleViewController.h"
#import "WeiboClient.h"
#import "CircleEntity.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface CircleListViewController ()

@end

@implementation CircleListViewController

static int cellSize;

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
    
    self.title = @"圈子列表";
    
    self.view.backgroundColor = [UIColor colorWithRed:219/255.f green:108/255.f blue:86/255.f alpha:1];
    
    [self cellSizeGen];
    
    [self getCircles];
    
    
    
    self.navigationItem.leftBarButtonItem = [self leftBarButton];
    
    
    
//    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 320, 15)];
//    titleLabel.text = @"圈子列表";
//    titleLabel.font = [UIFont fontWithName:FONT_NAME size:15];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.textColor = [UIColor whiteColor];
//    [self.view insertSubview:titleLabel atIndex:1];
//    [titleLabel release];
    
}

- (UIBarButtonItem *)leftBarButton
{
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake(14, 14, 22, 16);
    [face setImage:[UIImage imageNamed:@"circle_left_button.png"] forState:UIControlStateNormal];
    [face addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
    
}

- (void)backAction
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cellSizeGen
{
    CGFloat screenSize = [UIScreen mainScreen].bounds.size.height;
    if (screenSize == 480) {
        cellSize = 140;
    } else if (screenSize == 568) {
        cellSize = 160;
    }
}

- (void)genPages
{
    XLCycleScrollView *csView = [[XLCycleScrollView alloc] initWithFrame:self.view.bounds];
    csView.delegate = self;
    csView.datasource = self;
    [self.view insertSubview:csView atIndex:0];
}

- (NSInteger)numberOfPages
{
    return 2;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    CGRect bound = [[UIScreen mainScreen] bounds]; 
    UIView * view = [[[UIView alloc] initWithFrame:bound] autorelease];
    if (index < 2 && circleArray.count > 0) {
        for (int i = index * 6, j = 1; i < (index + 1) * 6; i ++, j ++) {
            if (i == 11) {
                
            } else if (i < 11 && i >= 0) {
                [view addSubview:[self circleView:circleArray[i] Frame:CGRectMake((160 * ((j - 1) % 2)), 5 + cellSize * (((j + 1) / 2) - 1), 160, cellSize) Index:i]];
            }
            
        }
        
    }
    return view;
}

//- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                    message:[NSString stringWithFormat:@"当前点击第%d个页面",index]
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//    [alert release];
//}

// first get the UserDefaults object,if null,request the API.
- (void)getCircles
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSObject * obj = [df objectForKey:@"circleList"];
    if (obj) {
        [self convertdata:obj];
    } else {
        WeiboClient *client = [[WeiboClient alloc] initWithTarget:self
                                                            action:@selector(loadDataFinished:obj:)];
        [client getCircles];
    }
    
}

- (void)loadDataFinished:(WeiboClient *)sender
                     obj:(NSObject*)obj
{
    
    if (sender.hasError) {
        [sender alerterror:NSLocalizedString(@"errormessage", nil)];
    }
    else {
        [self convertdata:obj];
        [self genPages];
    }
}

- (void)convertdata:(NSObject *)obj
{
//    NSLog(@"%@", obj);
    circleArray = [[NSMutableArray alloc] init];
    NSDictionary *jsondata = [(NSDictionary *)obj objectForKey:@"data"];
//    totalcommentcount = [jsondata getIntValueForKey:@"count" defaultValue:0];
    NSDictionary *circleInfoList = [jsondata objectForKey:@"circleInfoList"];
    if (circleInfoList) {
        for (NSDictionary * cir in circleInfoList) {
            if (![cir isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            CircleEntity * circleentity = [CircleEntity entityWithJsonDictionary:cir];
            [circleArray addObject:circleentity];
        }
    }
}

- (UIView *)circleView:(CircleEntity *)entity Frame:(CGRect)rect Index:(int)index
{
    CGFloat ringImageviewLeft = 0, ringImageviewSize = 0;
    CGFloat circleImageViewLeft = 0, circleImageviewSize = 0;
    CGFloat titleLabelTop = 0, circleOwnLabelTop = 0;
    
    if (cellSize == 140) {
        
        ringImageviewLeft = 35;
        ringImageviewSize = 90;
        circleImageViewLeft = 47;
        circleImageviewSize = 66;
        titleLabelTop = 95;
        circleOwnLabelTop = 115;
        
        
    } else if (cellSize == 160) {
        
        ringImageviewLeft = 25;
        ringImageviewSize = 110;
        circleImageViewLeft = 39;
        circleImageviewSize = 82;
        titleLabelTop = 115;
        circleOwnLabelTop = 135;
        
    }
    
    UIView * cv = [[UIView alloc] initWithFrame:rect];
    UIImageView *ringImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ringImageviewLeft, 0, ringImageviewSize, ringImageviewSize)];
    ringImageView.image = [UIImage imageNamed:@"circle_ring.png"];
    [cv addSubview:ringImageView];
    [ringImageView release];
    
    UIImageView *circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(circleImageViewLeft, (ringImageviewSize - circleImageviewSize) / 2, circleImageviewSize, circleImageviewSize)];
    circleImageView.backgroundColor = [UIColor whiteColor];
    [circleImageView.layer setMasksToBounds:YES];
    CGFloat radius = circleImageviewSize / 2;
    [circleImageView.layer setCornerRadius:radius];
    [circleImageView.layer setBorderWidth:2.5];
    [circleImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, entity.circlebigimg];
    [circleImageView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"circle_placeholder.png"]];
    
    [cv addSubview:circleImageView];
    [circleImageView release];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabelTop, 160, 15)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:FONT_NAME size:14];
    titleLabel.text = entity.circlename;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [cv addSubview:titleLabel];
    [titleLabel release];
    
    UILabel * circleOwnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, circleOwnLabelTop, 160, 12)];
    circleOwnLabel.textColor = [UIColor whiteColor];
    circleOwnLabel.backgroundColor = [UIColor clearColor];
    circleOwnLabel.font = [UIFont fontWithName:FONT_NAME size:12];
    circleOwnLabel.text = entity.userinfo.nick;
    circleOwnLabel.textAlignment = NSTextAlignmentCenter;
    [cv addSubview:circleOwnLabel];
    [circleOwnLabel release];
    
    UIButton * circleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 110)];
    circleButton.titleLabel.text = entity.circleid;
    circleButton.tag = index;
    [circleButton addTarget:self action:@selector(circleAction:) forControlEvents:UIControlEventTouchUpInside];
    [cv addSubview:circleButton];
    [circleButton release];
    
    return cv;
}

- (void)circleAction:(UIButton *)sender
{
    CircleViewController *circleVC = [[CircleViewController alloc] init];
    circleVC.circleId = sender.titleLabel.text;
    circleVC.cEntity = circleArray[sender.tag];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:circleVC];
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"circle_banner.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController pushViewController:circleVC animated:YES];
    [circleVC release];
//    [nav release];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    [circleArray release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    circleArray = nil;
}

@end
