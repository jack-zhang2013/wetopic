//
//  SettingViewController.h
//  Instanote
//
//  Created by CMD on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMFeedback.h"

@interface SettingViewController : UITableViewController <UMFeedbackDataDelegate ,UIAlertViewDelegate> {
    UMFeedback *_umFeedback;
}
@property (nonatomic, strong) UMFeedback *umFeedback;

- (void)feedbackAction;
- (void)signoutAction;
- (void)signinAction;

@end
