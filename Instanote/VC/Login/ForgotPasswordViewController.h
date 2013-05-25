//
//  ForgotPasswordViewController.h
//  Instanote
//
//  Created by Man Tung on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "msgView.h"

@interface ForgotPasswordViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    UITableView * tableview;
    UITextField * usernameInputField;
    UIButton * sendButton;
    
    //msg
    msgView * msgview;
//    UIActivityIndicatorView * activityindicator;
    
}

@property (nonatomic, retain) UITableView * tableview;
@property (nonatomic, retain) UITextField * usernameInputField;
@property (nonatomic, retain) UIButton * sendButton;

- (void)sendAction;
- (void)backAction;


@end
