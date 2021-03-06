/*
	InoteSyncServices.h
	Creates a list of the services available with the InoteSync prefix.
	Generated by SudzC.com
*/
#import "InoteSyncInstanoteSynchronyServiceService.h"

@interface InoteSyncServices : NSObject {
	BOOL logging;
	NSString* server;
	NSString* defaultServer;
InoteSyncInstanoteSynchronyServiceService* instanoteSynchronyServiceService;

}

-(id)initWithServer:(NSString*)serverName;
-(void)updateService:(SoapService*)service;
-(void)updateServices;
+(InoteSyncServices*)service;
+(InoteSyncServices*)serviceWithServer:(NSString*)serverName;

@property (nonatomic) BOOL logging;
@property (nonatomic, retain) NSString* server;
@property (nonatomic, retain) NSString* defaultServer;

@property (nonatomic, retain, readonly) InoteSyncInstanoteSynchronyServiceService* instanoteSynchronyServiceService;

@end
			