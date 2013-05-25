//
//  DetailViewController.h
//  Instanote
//
//  Created by Man Tung on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Note;

@protocol NoteAddDelegate;

@interface DetailViewController : UIViewController <UITextViewDelegate> {
    
    NSManagedObjectContext * managedObjectContext;
    
    UITextView * addInput;
    UILabel * countAddInputLabel;
    
    UIActionSheet * actionsheet;
    //NSString * draftString;
    
    UIBarButtonItem * saveButton;
    
    Note * note;
@private
    NSDateFormatter *dateFormatter;
}

@property (nonatomic, retain) Note *note;
@property (nonatomic, readonly, retain) NSDateFormatter *dateFormatter;
@property (nonatomic,assign) id finishTarget;
@property (nonatomic,assign) SEL finishAction; 
@property (nonatomic, retain) UITextView * addInput;
@property (nonatomic, retain) UILabel * countAddInputLabel;
@property (nonatomic, retain) UIBarButtonItem * saveButton;

@end
