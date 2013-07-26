//
//  WelcomeViewController.m
//  Instanote
//
//  Created by CMD on 7/19/13.
//
//

#import "WelcomeViewController.h"
#import "IntroControll.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.wantsFullScreenLayout = YES;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    IntroModel *model1 = [[IntroModel alloc] initWithTitle:@"闲情偶寄"
                                               description:@"李涵 一处闲情 漫天播寄，谁人收？"
                                                     image:@"welcome_0.png"];
    
    IntroModel *model2 = [[IntroModel alloc] initWithTitle:@"伤心爱情"
                                               description:@"南十字星 难舍、难忘，一历即终生。"
                                                     image:@"welcome_1.png"];
    
    IntroModel *model3 = [[IntroModel alloc] initWithTitle:@"风景驿站"
                                               description:@"黑陨石 那些被心了悟过的风景，不妨栖留。"
                                                     image:@"welcome_2.png"];
    
    IntroModel *model4 = [[IntroModel alloc] initWithTitle:@"经营智慧"
                                               description:@"李勇 在思辩中前行 生意也可以很诗意。"
                                                     image:@"welcome_3.png"];
    
    NSArray * ary = [[NSArray alloc] initWithObjects:model1, model2, model3, model4, nil];
    IntroControll * intrcontroll = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:ary];
    [intrcontroll.startButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:intrcontroll];
    
}

- (void)backAction
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
