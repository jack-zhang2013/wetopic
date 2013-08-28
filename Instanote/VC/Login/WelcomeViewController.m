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
    IntroModel *model1 = [[IntroModel alloc] initWithTitle:nil
                                               description:nil
                                                     image:@"welcome_0.png"];
    
    IntroModel *model2 = [[IntroModel alloc] initWithTitle:nil
                                               description:nil
                                                     image:@"welcome_1.png"];
    
    IntroModel *model3 = [[IntroModel alloc] initWithTitle:nil
                                               description:nil
                                                     image:@"welcome_2.png"];
    
//    IntroModel *model4 = [[IntroModel alloc] initWithTitle:nil
//                                               description:nil
//                                                     image:@"welcome_3.png"];
    
    NSArray * ary = [[NSArray alloc] initWithObjects:model1, model2, model3, nil];
    IntroControll * intrcontroll = [[IntroControll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) pages:ary];
    [intrcontroll.startButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:intrcontroll];
    
}

- (void)backAction
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
