//
//  CircleListViewController.m
//  Instanote
//
//  Created by CMD on 7/23/13.
//
//

#import "CircleListViewController.h"
#import "WeiboClient.h"
#import "CircleEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CircleListViewController ()

@end

@implementation CircleListViewController

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
    
    [self getCircles];
    
}

- (void)genPages
{
    XLCycleScrollView *csView = [[XLCycleScrollView alloc] initWithFrame:self.view.bounds];
    csView.delegate = self;
    csView.datasource = self;
    [self.view addSubview:csView];
}

- (NSInteger)numberOfPages
{
    return 3;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    CGRect bound = [[UIScreen mainScreen] bounds];
    UIView * view = [[[UIView alloc] initWithFrame:bound] autorelease];
    view.backgroundColor = [UIColor grayColor];
//    if (index < 3) {
//        if (circleArray.count > 0) {
//            for (int i = index * 6, j = 1; i < (index + 1) * 6; i ++, j ++) {
//                
//                [view addSubview:[self circleView:circleArray[i] Frame:CGRectMake(160 * (j % 2), 44 + 130 * (int)(j / 2), 160, 130)]];
//                
//            }
//        }
//        
//    }
    return view;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[NSString stringWithFormat:@"当前点击第%d个页面",index]
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

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

- (UIView *)circleView:(CircleEntity *)entity Frame:(CGRect)rect
{
    UIView * cv = [[UIView alloc] initWithFrame:rect];
    UIImageView *ringImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 110, 110)];
    ringImageView.image = [UIImage imageNamed:@"circle_ring.png"];
    [cv addSubview:ringImageView];
    [ringImageView release];
    
    UIImageView *circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 106, 106)];
    NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, entity.circlebigimg];
    [circleImageView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [cv addSubview:circleImageView];
    [circleImageView release];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, 160, 20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:FONT_NAME size:16];
    titleLabel.text = entity.circlename;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [cv addSubview:titleLabel];
    [titleLabel release];
    
    UILabel * circleOwnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 145, 160, 16)];
    circleOwnLabel.textColor = [UIColor whiteColor];
    circleOwnLabel.font = [UIFont fontWithName:FONT_NAME size:16];
    circleOwnLabel.text = entity.userinfo.nick;
    circleOwnLabel.textAlignment = NSTextAlignmentCenter;
    [cv addSubview:circleOwnLabel];
    [circleOwnLabel release];
    
    return cv;
    
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
