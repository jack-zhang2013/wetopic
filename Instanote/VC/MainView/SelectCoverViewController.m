//
//  SelectCoverViewController.m
//  Instanote
//
//  Created by CMD on 7/15/13.
//
//

#import "SelectCoverViewController.h"

@interface SelectCoverViewController ()

@end

@implementation SelectCoverViewController

@synthesize covertype;
@synthesize finishAction,finishTarget;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = [self doneButton];
    self.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 11) {
        return 160.f;
    } else if (indexPath.row == 11) {
        return 170.f;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    int index = indexPath.row + 1;
    if (indexPath.row >= 0 || indexPath.row < 12) {
        [cell addSubview:[self cellView:index]];
    }
    return cell;
}

- (UIView *)cellView:(int)index
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    
    UIButton *imageViewButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 300, 150)];
    imageViewButton.tag = index;
    [imageViewButton addTarget:self action:@selector(coverSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:imageViewButton];
    [imageViewButton release];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 150)];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_cover%d.png", index]];
    [view addSubview:imageView];
    [imageView release];
    if (index == covertype) {
        UIImageView * selectView = [[UIImageView alloc] initWithFrame:CGRectMake(272, 10, 30, 60)];
        selectView.image = [UIImage imageNamed:@"bookmark.png"];
        [view addSubview:selectView];
        [selectView release];
    }
    return view;
}

- (void)coverSelectAction:(UIButton *)sender
{
    
    int index = sender.tag;
    
    [self saveAction:index];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark actions and gens

- (UIBarButtonItem *)leftButtonForCenterPanel {
    UIImage *faceImage = [UIImage imageNamed:@"arrow.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 12, 12, 24, 16 );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

//- (UIBarButtonItem *)doneButton {
//    UIImage *faceImage = [UIImage imageNamed:@"done_button.png"];
//    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
//    face.bounds = CGRectMake( 12, 12, 40, 25 );
//    [face setImage:faceImage forState:UIControlStateNormal];
//    [face addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
//    return [[UIBarButtonItem alloc] initWithCustomView:face];
//}

- (void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)saveAction:(int)index
{
    if ([finishTarget retainCount] > 0 && [finishTarget respondsToSelector:finishAction]) {
        [finishTarget performSelector:finishAction withObject:[NSString stringWithFormat:@"%d", index]];
    }
    [self backAction];
}

@end
