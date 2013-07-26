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
#import "WeiboClient.h"
#import "NSDictionaryAdditions.h"

@interface UserSettingViewController ()

@end

@implementation UserSettingViewController
@synthesize userId, userentity;
@synthesize finishAction, finishTarget;

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
    
    self.navigationItem.rightBarButtonItem = [self rightButtonForCenterPanel];
    self.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];
    
    if (!userentity) {
        userentity = [self UserEntity];
    }
    
    if (!userCoverImage) {
        userCoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 11, 284, 145)];
        [userCoverImage.layer setCornerRadius:6.f];
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

- (UsersEntity *)UserEntity
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    userentity = [[UsersEntity alloc] init];
    userentity.email = [def stringForKey:@"email"];
    userentity.image = [def stringForKey:@"image"];
    userentity.nick = [def stringForKey:@"nick"];
    userentity.otheraccountuserimage = [def stringForKey:@"otheraccountuserimage"];
    userentity.password = [def stringForKey:@"password"];
    userentity.otheraccount = [def integerForKey:@"otheraccount"];
    userentity.otheraccountypeid = [def integerForKey:@"otheraccountypeid"];
    userentity.sex = [def integerForKey:@"sex"];
    userentity.registertime = [def integerForKey:@"registertime"];
    userentity.userid = [def integerForKey:@"userid"];
    userentity.userlevel = [def integerForKey:@"userlevel"];
    userentity.address = [def stringForKey:@"address"];
    userentity.hobby = [def stringForKey:@"hobby"];
    userentity.what = [def stringForKey:@"what"];
    userentity.website = [def stringForKey:@"website"];
    userentity.covertype = [userentity.website length] > 0 ? [self covertype:userentity.website] : 0;
    return userentity;
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
    if (section == 0) {
        return 3;
    }
//    else if (section == 1) {
//        return 1;
//    }
    else {
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
            
//            [cell addSubview:[self logoutButton]];
            
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
        
    }
//    else if (indexPath.section == 1 && indexPath.row == 0) {
//        height = 38.f;
//    }
    return height;
}

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     [detailViewController release];
//     */
//}

#pragma mark - button actions

-(void)changeCoverAction
{
    SelectCoverViewController * selectCoverVC = [[SelectCoverViewController alloc] init];
    selectCoverVC.covertype = [self covertype];
    selectCoverVC.finishAction = @selector(changeUserCover:);
    selectCoverVC.finishTarget = self;
    [self.navigationController pushViewController:selectCoverVC animated:YES];
    [selectCoverVC release];
}

- (void)changeAvatarAction
{
    
}


#pragma mark connections


- (void)loadDataFinishedWithType:(WeiboClient *)sender
                     obj:(NSObject*)obj
{
    if (sender.hasError) {
        [sender alerterror:NSLocalizedString(@"errormessage", nil)];
    }
    else {
        
        NSString *status = [(NSDictionary *)obj objectForKey:@"status"];
        NSDictionary * data = [(NSDictionary *)obj objectForKey:@"data"];
        if ([status intValue] == 1) {
            
            NSDictionary * user = [data objectForKey:@"user"];
            UsersEntity * u = [UsersEntity entityWithJsonDictionary:user];
            [self saveUser:u];
            
            [self refeshAll];
            
        }
    }
}


- (void)loadDataFinished:(WeiboClient *)sender
                     obj:(NSObject*)obj
{
    
    if (sender.hasError) {
        [sender alerterror:NSLocalizedString(@"errormessage", nil)];
    }
    else {
        NSString *status = [(NSDictionary *)obj objectForKey:@"status"];
        if ([status intValue] == 1) {
            [userNameTextField resignFirstResponder];
            [userDescTextView resignFirstResponder];
            [self setUserName:userNameTextField.text userDesc:userDescTextView.text];
            [self backAction];
        }
    }
}

//- (void)alerterror:(NSString *)title
//{
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"more_logout_yes", nil) otherButtonTitles:nil, nil];
//    [alert show];
//}

- (void)setUserName:(NSString *)username userDesc:(NSString *)desc
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:username forKey:@"nick"];
    [defaults setObject:desc forKey:@"what"];
    [defaults synchronize];
}

- (void)saveUser:(UsersEntity *)user
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:user.email forKey:@"email"];
    [def setObject:user.image forKey:@"image"];
    [def setObject:user.nick forKey:@"nick"];
    [def setObject:user.otheraccountflag forKey:@"otheraccountflag"];
    [def setObject:user.otheraccountuserimage forKey:@"otheraccountuserimage"];
    [def setObject:user.password forKey:@"password"];
    [def setObject:user.what forKey:@"what"];
    [def setInteger:user.otheraccount forKey:@"otheraccount"];
    [def setInteger:user.otheraccountypeid forKey:@"otheraccountypeid"];
    [def setInteger:user.sex forKey:@"sex"];
    [def setInteger:user.registertime forKey:@"registertime"];
    [def setInteger:user.userid forKey:aUserId];
    [def setInteger:user.userlevel forKey:@"userlevel"];
    [def setObject:user.address forKey:@"address"];
    [def setObject:user.hobby forKey:@"hobby"];
    [def setObject:user.website forKey:@"website"];
    [def setInteger:[self covertype:user.website] forKey:@"covertype"];
    [def synchronize];
}

- (int)covertype:(NSString *)website
{
    NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    int value = [[[website substringFromIndex:10] stringByTrimmingCharactersInSet:nonDigits] intValue];
    return value;
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

//- (UIButton *)logoutButton
//{
//    UIButton * logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    logoutButton.frame = CGRectMake(10, 0, 300, 38);
//    logoutButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setting_logout.png"]];
//    logoutButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
//    [logoutButton setTitle:@"登出" forState:UIControlStateNormal];
//    return logoutButton;
//    
//}

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

- (void)changeUserCover:(NSString *)index
{
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinishedWithType:obj:)];
    [client updateUserCover:userId Cover:[index intValue]];
}

- (void)setUserWebSite:(int)index
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%d", index] forKey:@"covertype"];
    [defaults setObject:[NSString stringWithFormat:@"http://1mily.com/images/usercover/bj%d.jpg", index] forKey:@"website"];
    [defaults synchronize];
}

- (void)refeshAll
{
    [self refreshUserEntity];
    [self refreshTableView];
}

- (void)refreshUserEntity
{
    [userentity release];
    userentity = nil;
    userentity = [self UserEntity];
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
//    NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
//    int value = [[[userentity.website substringFromIndex:10] stringByTrimmingCharactersInSet:nonDigits] intValue];
//    return value;
    return userentity.covertype;
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

- (UIBarButtonItem *)leftButtonForCenterPanel {
    UIImage *faceImage = [UIImage imageNamed:@"cancel_button.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake(0, 10, 40, 25);
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (void)backAction
{
    if ([finishTarget retainCount] > 0 && [finishTarget respondsToSelector:finishAction]) {
        [finishTarget performSelector:finishAction  withObject:nil];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)saveProfileAction
{
    NSString * textName = userNameTextField.text;
    NSString * textDesc = userDescTextView.text;
    if ([textName length] > 0 && [textDesc length] > 0 && (![textDesc isEqualToString:userentity.what] || ![textName isEqualToString:userentity.nick])) {
        WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
        [client updateUserInfo:userId Nick:textName What:textDesc];
    } else {
        [self backAction];
    }
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
