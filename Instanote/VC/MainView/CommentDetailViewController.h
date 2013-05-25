//
//  CommentDetailViewController.h
//  Instanote
//
//  Created by Man Tung on 3/28/13.
//
//

#import <UIKit/UIKit.h>
#import "CircleCommentInfosEntity.h"

@interface CommentDetailViewController : UIViewController
{
    CircleCommentInfosEntity * mycomment;
    UIButton * btn_back;
}

@property (nonatomic, retain)CircleCommentInfosEntity * mycomment;

@end
