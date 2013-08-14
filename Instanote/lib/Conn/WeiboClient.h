#import <UIKit/UIKit.h>
#import "URLConnection.h"


typedef enum {
    WEIBO_REQUEST_TIMELINE,
    WEIBO_REQUEST_REPLIES,
    WEIBO_REQUEST_MESSAGES,
    WEIBO_REQUEST_SENT,
    WEIBO_REQUEST_FAVORITE,
    WEIBO_REQUEST_DESTROY_FAVORITE,
    WEIBO_REQUEST_CREATE_FRIENDSHIP,
    WEIBO_REQUEST_DESTROY_FRIENDSHIP,
    WEIBO_REQUEST_FRIENDSHIP_EXISTS,
} RequestType;

@interface WeiboClient : URLConnection
{
    RequestType request;
    id          context;
    SEL         action;
    BOOL        hasError;
    NSString*   errorMessage;
    NSString*   errorDetail;
    BOOL _secureConnection;
}

@property(nonatomic, readonly) RequestType request;
@property(nonatomic, assign) id context;
@property(nonatomic, assign) BOOL hasError;
@property(nonatomic, copy) NSString* errorMessage;
@property(nonatomic, copy) NSString* errorDetail;

- (id)initWithTarget:(id)aDelegate action:(SEL)anAction;

- (void)addComment:(NSString *)topicid userId:(int)userid commentContent:(NSString *)content Source:(int)source;

- (void)addCommentGreat:(NSString *)commentId userId:(int)userid Great:(int)great;

- (void)topicCommnet:(NSString *)tid pageNum:(int)pn pageSize:(int)ps;

- (void)timeline:(int)ps pageNum:(int)pn pageType:(int)type userId:(int)uid;

- (void)login:(NSString *)email pwd:(NSString *)password;

- (void)forgot:(NSString *)email;

- (void)reguser:(NSString *)email pwd:(NSString *)password;

- (void)user:(int)userid;

- (void)updateUserInfo:(int)userId Nick:(NSString *)nick What:(NSString *)what;

- (void)updateUserCover:(int)userId Cover:(int)type;

- (void)updateuserAvatar:(int)userId userImage:(NSData *)userimage;

- (void)getCircles;

- (void)getCircleDetailInfos:(NSString *)CircleId pageNum:(int)pn pageSize:(int)ps;

- (void)getCircleDetailInfo:(NSString *)CircleId;

- (void)getCircleDetailCommentInfos:(NSString *)circleDetailId pageNum:(int)pn pageSize:(int)ps;

///////////end notices

- (void)alert;

- (void)alerterror:(NSString *)title;

@end
