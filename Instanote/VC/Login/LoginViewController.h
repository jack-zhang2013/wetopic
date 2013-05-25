//
//  LoginViewController.h
//  Instanote
//
//  Created by Man Tung on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellWithTextField.h"
#import "msgView.h"

@interface LoginViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    UITableView * tableview;
    UITextField * usernameInputField;
    UITextField * passwordInputField;
    
    UIButton * signInButton;
    
//    UIButton * _forgetPasswordButton;
//    
//    UIButton * _registerButton;
    
    //msg
    msgView *msgview;
    
    UISegmentedControl *segmentedControl;
//    UIActivityIndicatorView * activityindicator;
    
}

@property (nonatomic, retain) UITableView * tableview;
@property (nonatomic, retain) UITextField * usernameInputField;
@property (nonatomic, retain) UITextField * passwordInputField;
@property (nonatomic, retain) UIButton * signInButton;
//@property (nonatomic, retain) UIButton * _forgetPasswordButton;
//@property (nonatomic, retain) UIButton * _registerButton;
@property (nonatomic,assign) id finishTarget;
@property (nonatomic,assign) SEL finishAction;


- (void)signinAction;
- (void)forgotPasswordAction;
- (void)registerAction;

@end
