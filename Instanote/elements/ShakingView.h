//
//  ShakingView.h
//  Two1Cake
//
//  Created by CMD on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShakeDelegate;

@interface ShakingView : UIView
{
    id <ShakeDelegate> myDelegate;
}

@property (assign) id<ShakeDelegate> delegate;

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;

- (BOOL)canBecomeFirstResponder;

@end

@protocol ShakeDelegate

- (void)ShakeWithSomething;

@end
