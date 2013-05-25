//
//  CellWithTextField.m
//  Instanote
//
//  Created by Man Tung on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CellWithTextField.h"

@implementation CellWithTextField

@synthesize inputTextField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        inputTextField = [[UITextField alloc] init];
        inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        inputTextField.font = [UIFont fontWithName:FONT_NAME size:15];
        inputTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:self.inputTextField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect innerFrame = CGRectMake(5, 5, bounds.size.width, bounds.size.height);
    [inputTextField setFrame:innerFrame];
}

- (void)dealloc
{
    [super dealloc];
    [inputTextField release];
}

@end
