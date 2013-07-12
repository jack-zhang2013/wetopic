//
//  UserSettingViewController.m
//  Instanote
//
//  Created by CMD on 7/11/13.
//
//

#import "UserSettingViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface UserSettingViewController ()

@end

@implementation UserSettingViewController
@synthesize userId, userentity;

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
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (!userCoverImage) {
        userCoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    }
    
    CGFloat userImageViewSize = 70.f;
    CGFloat userImageViewFromTop = 20.f;
    
    if (!userImageView) {
        userImageView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - userImageViewSize) / 2, userImageViewFromTop, userImageViewSize, userImageViewSize)];
        userImageView.backgroundColor = [UIColor whiteColor];
        [userImageView.layer setMasksToBounds:YES];
        CGFloat radius = userImageViewSize / 2;
        [userImageView.layer setCornerRadius:radius];
        [userImageView.layer setBorderWidth:3.0];
        [userImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    }
    
    if (!userNameTextField) {
        userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 6, 205, 25)];
        userNameTextField.backgroundColor = [UIColor greenColor];
    }
    
    if (!userDescTextField) {
        userDescTextField = [[UITextView alloc] initWithFrame:CGRectMake(100, 6, 205, 116)];
        userDescTextField.backgroundColor = [UIColor greenColor];
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 1;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                
                [cell addSubview:userCoverImage];
                
                [cell addSubview:userImageView];
                
                [cell addSubview:[self coverButton]];
                
                [cell addSubview:[self avatarButton]];
                
                
                
            } else if (indexPath.row == 1) {
                
                [cell addSubview:userNameTextField];
                
            } else if (indexPath.row == 2) {
                
                [cell addSubview:userDescTextField];
                
            }
            
            
        } else if (indexPath.section == 1) {
            
            [cell addSubview:[self logoutButton]];
            
        } else {
            //nothing
        }
        
        
    }
    
    // Configure the cell...
    
    return cell;
}

- (UIButton *)coverButton
{
    UIButton * changeCover = [UIButton buttonWithType:UIButtonTypeCustom];
    changeCover.frame = CGRectMake(16, 111, 120, 34);
    changeCover.titleLabel.font = [UIFont fontWithName:FONT_NAME size:14];
    changeCover.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_setting_button.png"]];
    [changeCover setTitle:@"更改封面" forState:UIControlStateNormal];
    return changeCover;
}

- (UIButton *)avatarButton
{
    UIButton * changeAvatar = [UIButton buttonWithType:UIButtonTypeCustom];
    changeAvatar.frame = CGRectMake(184, 111, 120, 34);
    changeAvatar.titleLabel.font = [UIFont fontWithName:FONT_NAME size:14];
    changeAvatar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_setting_button.png"]];
    [changeAvatar setTitle:@"更改头像" forState:UIControlStateNormal];
    return changeAvatar;
}

- (UIButton *)logoutButton
{
    UIButton * logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(10, 0, 300, 44);
    logoutButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_logout.png"]];
    logoutButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [logoutButton setTitle:@"登出" forState:UIControlStateNormal];
    return logoutButton;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.f;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            height = 160.f;
        } else if (indexPath.row == 1) {
            height = 40.f;
        } else if (indexPath.row == 2) {
            height = 130.f;
        }
        
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        height = 40.f;
    }
    return height;
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

@end
