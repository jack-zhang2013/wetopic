//
//  CircleListViewController.m
//  Instanote
//
//  Created by CMD on 7/23/13.
//
//

#import "CircleListViewController.h"
#import "CycleScrollView.h"
#import "WeiboClient.h"
#import "CircleEntity.h"

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
	// Do any additional setup after loading the view.
    picArray = [[NSMutableArray alloc] init];
    
    CGRect bound = [[UIScreen mainScreen] bounds];
    
    CycleScrollView *cycle = [[CycleScrollView alloc] initWithFrame:bound
                                                     cycleDirection:CycleDirectionLandscape
                                                           pictures:picArray];
    cycle.delegate = self;
    [self.view addSubview:cycle];
    [cycle release];
    
    [self getCircles];
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
    }
}

- (void)convertdata:(NSObject *)obj
{
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

- (void)genCircles
{
    CGRect bound = [[UIScreen mainScreen] bounds];
    UIView *firstviews = [[UIView alloc] initWithFrame:bound];
    firstviews.backgroundColor = [UIColor greenColor];
    
    UIView *secondviews = [[UIView alloc] initWithFrame:bound];
    secondviews.backgroundColor = [UIColor redColor];
    
    UIView *thirdviews = [[UIView alloc] initWithFrame:bound];
    thirdviews.backgroundColor = [UIColor blueColor];
    
    [picArray addObject:firstviews];
    [picArray addObject:secondviews];
    [picArray addObject:thirdviews];
    
    [firstviews release];
    [secondviews release];
    [thirdviews release];
}

//- (UIView *)circleView:(CircleView)


- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didSelectImageView:(int)index {
    if (index == 4) {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didScrollImageView:(int)index {
    
    //    self.title = [NSString stringWithFormat:@"第%d张", index];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    [picArray release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    picArray = nil;
}

@end
