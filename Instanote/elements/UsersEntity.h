//
//  UsersEntity.h
//  Instanote
//
//  Created by Man Tung on 12/25/12.
//
//

#import <Foundation/Foundation.h>
#import "BaseEnity.h"

@interface UsersEntity : BaseEnity
{
    NSString *declaration;
    NSString *email;
    NSString *image;
    NSString *nick;
    int otheraccount;
    NSString *otheraccountflag;
    NSString *otheraccountuserimage;
    int otheraccountypeid;
    NSString *password;
    time_t registertime;
    int sex;
    NSString *what;
    NSString *userid;
    int userlevel;
    NSString *hobby;
    NSString *address;
    NSString *website;
    
}

@property (nonatomic, retain) NSString *declaration;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *nick;
@property (nonatomic, assign) int otheraccount;
@property (nonatomic, retain) NSString *otheraccountflag;
@property (nonatomic, retain) NSString *otheraccountuserimage;
@property (nonatomic, assign) int otheraccountypeid;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, assign) time_t registertime;
@property (nonatomic, assign) int sex;
@property (nonatomic, retain) NSString *what;
@property (nonatomic, assign) NSString *userid;
@property (nonatomic, assign) int userlevel;
@property (nonatomic, retain) NSString *hobby;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *website;

- (UsersEntity *)initWithJsonDictionary:(NSDictionary *)dic;

+ (UsersEntity *)entityWithJsonDictionary:(NSDictionary *)dic;

@end
