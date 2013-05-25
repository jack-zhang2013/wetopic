//
//  RegisterViewController.h
//  Instanote
//
//  Created by Man Tung on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "msgView.h"

@interface RegisterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate> {
    UITableView * tableview;
    UITextField * usernameInputField;
    UITextField * passwordInputField;
    
    UIButton * signInButton;
    
//    UIButton * _forgetPasswordButton;
    
    //UIButton * _registerButton;
    
    msgView * msgview;
//    UIActivityIndicatorView * activityindicator;
    
}

@property (nonatomic, retain) UITableView * tableview;
@property (nonatomic, retain) UITextField * usernameInputField;
@property (nonatomic, retain) UITextField * passwordInputField;
@property (nonatomic, retain) UIButton * signInButton;
//@property (nonatomic, retain) UIButton * _forgetPasswordButton;
//@property (nonatomic, retain) UIButton * _registerButton;

- (void)regAction;
- (void)backAction;


@end
