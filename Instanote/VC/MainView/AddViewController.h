//
//  AddViewController.h
//  Instanote
//
//  Created by Man Tung on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol NoteAddDelegate;

@interface AddViewController : UIViewController <UITextViewDelegate> {
    
    UITextView * addInput;
//    UILabel * countAddInputLabel;
    
    NSString * topicid;
    
//    UIActionSheet * actionsheet;
    //NSString * draftString;
//    
//    UIBarButtonItem * saveButton;
//    UIBarButtonItem * backButton;
//    id <NoteAddDelegate> delegate;
}

@property (nonatomic,assign)id finishTarget;
@property (nonatomic,assign)SEL finishAction;
@property (nonatomic, retain)UITextView * addInput;
//@property (nonatomic, retain)UILabel * countAddInputLabel;
@property (nonatomic, retain)NSString *topicid;
//@property (nonatomic, retain) UIBarButtonItem * saveButton;
//@property (nonatomic, retain) UIBarButtonItem * backButton;
//@property (nonatomic, assign) id <NoteAddDelegate> delegate;

//- (void)backAction;
- (void)saveAction;
//- (void)saveDraftAction;
//- (void)disCardDraftAction;
//- (void)saveToDraftAction;
- (void)mydelegateAction;
- (void)doAddNote:(NSString *)text;
@end

//@protocol NoteAddDelegate <NSObject>
// recipe == nil on cancel
//- (void)noteAddViewController:(AddViewController *)addVc;

//@end
