//
//  BaseCell.m
//  Instanote
//
//  Created by Man Tung on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseCell.h"

#define contentLabel_WIDTH 310
#define contentLabel_HEIGHT 30
#define timelabel_WIDTH 100
#define timeLabel_HEIGHT 20
#define Edit_Float_WIDTH 40


#pragma mark -
#pragma mark SubviewFrames category

@interface BaseCell (SubviewFrames)
- (CGRect)_contentlabelFrame;
- (CGRect)_timelabelFrame;
- (CGFloat)_cellHeight;
@end

@implementation BaseCell

@synthesize contentlabel;
@synthesize timelabel;
@synthesize cellheight;
@synthesize note;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        contentlabel = [[UILabel alloc] init];
        [contentlabel setBackgroundColor:[UIColor clearColor]];
        [contentlabel setFrame:CGRectZero];
        [contentlabel setFont:[UIFont fontWithName:FONT_NAME size:16]];
        [self addSubview:contentlabel];
        
        timelabel = [[UILabel alloc] init];
        [timelabel setBackgroundColor:[UIColor clearColor]];
        [timelabel setTextAlignment:UITextAlignmentRight];
        [timelabel setFont:[UIFont fontWithName:FONT_NAME size:12]];
        [timelabel setTextColor:[UIColor grayColor]];
        [timelabel setFrame:CGRectZero];
        //[self addSubview:timelabel];
    }
    return self;
}

- (void)layoutIfNeeded
{
    [self setCellheight:contentlabel.frame.size.height + 20.f];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [contentlabel setFrame:[self _contentlabelFrame]];
    [timelabel setFrame:[self _timelabelFrame]];
    [contentlabel sizeToFitFixedWidth:contentLabel_WIDTH];
    [self setCellheight:contentlabel.frame.size.height + 20.f];
    if (self.editing) {
        [timelabel setAlpha:0.0f];
    } else {
        [timelabel setAlpha:1.0f];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGRect)_contentlabelFrame
{
    if (self.editing) {
        return CGRectMake(40, 11, contentLabel_WIDTH, contentLabel_HEIGHT);
        //return CGRectMake(5 + Edit_Float_WIDTH, 5, contentLabel_WIDTH - Edit_Float_WIDTH, contentLabel_HEIGHT);
    } else {
        return CGRectMake(5, 11, contentLabel_WIDTH, contentLabel_HEIGHT);
    }
}

- (CGRect)_timelabelFrame
{
    if (self.editing) {
        return CGRectMake(320 - 10 - timelabel_WIDTH, 5, timelabel_WIDTH, timeLabel_HEIGHT);
    } else {
        return CGRectMake(320 - 5 - timelabel_WIDTH, 5, timelabel_WIDTH, timeLabel_HEIGHT);
    }
}

- (CGFloat)_cellHeight
{
    return [self _cellHeight];
}

- (void)setNote:(Note *)newNote
{
    if (newNote != note) {
        [note release];
        note = [newNote retain];
    }
    if (note.note_info) {
        contentlabel.text = note.note_info;
    } else {
        contentlabel.text = @"something here";
    }
    if (note.note_date) {
        timelabel.text = [self.dateFormatter stringFromDate:note.note_date];
    } else {
        timelabel.text = @"Now";
    }
    [contentlabel sizeToFitFixedWidth:contentLabel_WIDTH];
    [self setCellheight:contentlabel.frame.size.height];
    
}

- (NSDateFormatter *)dateFormatter {
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
    return dateFormatter;
}

- (void)dealloc
{
    [super dealloc];
    [contentlabel release];
    [timelabel release];
}

@end
