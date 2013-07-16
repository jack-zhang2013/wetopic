//
//  UserSettingViewController.m
//  Instanote
//
//  Created by CMD on 7/11/13.
//
//

#import "UserSettingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "SelectCoverViewController.h"

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
    
    self.navigationItem.leftBarButtonItem = [self rightButtonForCenterPanel];
    
    if (!userCoverImage) {
        userCoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 11, 284, 145)];
        [userCoverImage.layer setCornerRadius:8.f];
        [userCoverImage.layer setMasksToBounds:YES];
    }
    
    CGFloat userImageViewSize = 70.f;
    CGFloat userImageViewFromTop = 45.f;
    
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
        userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 11, 205, 20)];
        userNameTextField.textColor = [UIColor grayColor];
        userNameTextField.returnKeyType = UIReturnKeyNext;
        userNameTextField.delegate = self;
        userNameTextField.font = [UIFont fontWithName:FONT_NAME size:14];
    }
    
    if (!userDescTextView) {
        userDescTextView = [[UITextView alloc] initWithFrame:CGRectMake(94, 2, 205, 116)];
        userDescTextView.textColor = [UIColor grayColor];
        userDescTextView.backgroundColor = [UIColor clearColor];
        userDescTextView.delegate = self;
        userDescTextView.font = [UIFont fontWithName:FONT_NAME size:14];
    }
    
    [self refreshTableView];
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
                
                UILabel * innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 13, 80, 16)];
                innerLabel.text = @"用户昵称";
                innerLabel.font = [UIFont fontWithName:FONT_NAME size:14];
//                innerLabel.textColor = [UIColor grayColor];
                innerLabel.backgroundColor = [UIColor clearColor];
                [cell addSubview:innerLabel];
                [innerLabel release];
                
                [cell addSubview:userNameTextField];
                
            } else if (indexPath.row == 2) {
                
                UILabel * innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 13, 80, 16)];
                innerLabel.text = @"个人素描";
                innerLabel.font = [UIFont fontWithName:FONT_NAME size:14];
//                innerLabel.textColor = [UIColor grayColor];
                innerLabel.backgroundColor = [UIColor clearColor];
                [cell addSubview:innerLabel];
                [innerLabel release];
                
                [cell addSubview:userDescTextView];
                
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.f;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            height = 203.f;
        } else if (indexPath.row == 1) {
            height = 40.f;
        } else if (indexPath.row == 2) {
            height = 130.f;
        }
        
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        height = 38.f;
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

#pragma mark - button actions

-(void)changeCoverAction
{
    SelectCoverViewController * selectCoverVC = [[SelectCoverViewController alloc] init];
    selectCoverVC.covertype = [self covertype];
    [self.navigationController pushViewController:selectCoverVC animated:YES];
    [selectCoverVC release];
}

- (void)changeAvatarAction
{
    
}


#pragma mark - button gens

- (UIButton *)coverButton
{
    UIButton * changeCover = [UIButton buttonWithType:UIButtonTypeCustom];
    changeCover.frame = CGRectMake(25, 165, 106, 28);
    changeCover.titleLabel.font = [UIFont fontWithName:FONT_NAME size:12];
    changeCover.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_setting_button.png"]];
    [changeCover setTitle:@"更改封面" forState:UIControlStateNormal];
    [changeCover addTarget:self action:@selector(changeCoverAction) forControlEvents:UIControlEventTouchUpInside];
    return changeCover;
}

- (UIButton *)avatarButton
{
    UIButton * changeAvatar = [UIButton buttonWithType:UIButtonTypeCustom];
    changeAvatar.frame = CGRectMake(189, 165, 106, 28);
    changeAvatar.titleLabel.font = [UIFont fontWithName:FONT_NAME size:12];
    changeAvatar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_setting_button.png"]];
    [changeAvatar setTitle:@"更改头像" forState:UIControlStateNormal];
    return changeAvatar;
}

- (UIButton *)logoutButton
{
    UIButton * logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(10, 0, 300, 38);
    logoutButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_logout.png"]];
    logoutButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [logoutButton setTitle:@"登出" forState:UIControlStateNormal];
    return logoutButton;
    
}

#pragma mark - UITextView, UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == userNameTextField) {
        [userNameTextField resignFirstResponder];
        [userDescTextView becomeFirstResponder];
    }
    return YES;
}


#pragma mark refresh tableview


- (void)refreshTableView
{
    [self userCoverImageSet];
    
    [self userImageSet];
    
    userNameTextField.text = userentity.nick;
    userDescTextView.text = [userentity.what length] == 0 ? @"什么也没有" : userentity.what;
    
    [self.tableView reloadData];
}

- (void)userCoverImageSet
{
    int type = [self covertype];
    if (type > 0 && type < 13) {
        userCoverImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_cover%d", type]];
    } else {
        userCoverImage.image = [UIImage imageNamed:@"user_cover_default.png"];
    }
}

- (int)covertype
{
    NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    int value = [[[userentity.website substringFromIndex:10] stringByTrimmingCharactersInSet:nonDigits] intValue];
    return value;
}


- (void)userImageSet
{
    if (![userentity.image length] && ![userentity.otheraccountuserimage length]) {
        
        [userImageView setImage:[UIImage imageNamed:@"nobody_male.png"]];
        
    } else {
        
        NSString *realimage = userentity.image ? userentity.image : userentity.otheraccountuserimage;
        NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, realimage];
        [userImageView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"nobody_male.png"]];
    }
}

- (UIBarButtonItem *)rightButtonForCenterPanel {
    UIImage *faceImage = [UIImage imageNamed:@"done_button.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake(0, 10, 40, 25);
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(saveProfileAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (void)saveProfileAction
{
    NSLog(@"saved!");
}

- (void)dealloc
{
    [super dealloc];
    [userCoverImage release];
    [userImageView release];
    [userNameTextField release];
    [userDescTextView release];
    [userentity release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    userCoverImage = nil;
    userImageView = nil;
    userNameTextField = nil;
    userDescTextView = nil;
    userentity = nil;
}





@end
