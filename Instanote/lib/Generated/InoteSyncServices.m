/*
	InoteSyncServices.m
	Creates a list of the services available with the InoteSync prefix.
	Generated by SudzC.com
*/
#import "InoteSyncServices.h"

@implementation InoteSyncServices

@synthesize logging, server, defaultServer;

@synthesize instanoteSynchronyServiceService;


#pragma mark Initialization

-(id)initWithServer:(NSString*)serverName{
	if(self = [self init]) {
		self.server = serverName;
	}
	return self;
}

+(InoteSyncServices*)service{
	return (InoteSyncServices*)[[[InoteSyncServices alloc] init] autorelease];
}

+(InoteSyncServices*)serviceWithServer:(NSString*)serverName{
	return (InoteSyncServices*)[[[InoteSyncServices alloc] initWithServer:serverName] autorelease];
}

#pragma mark Methods

-(void)setLogging:(BOOL)value{
	logging = value;
	[self updateServices];
}

-(void)setServer:(NSString*)value{
	[server release];
	server = [value retain];
	[self updateServices];
}

-(void)updateServices{

	[self updateService: self.instanoteSynchronyServiceService];
}

-(void)updateService:(SoapService*)service{
	service.logging = self.logging;
	if(self.server == nil || self.server.length < 1) { return; }
	service.serviceUrl = [service.serviceUrl stringByReplacingOccurrencesOfString:defaultServer withString:self.server];
}

#pragma mark Getter Overrides


-(InoteSyncInstanoteSynchronyServiceService*)instanoteSynchronyServiceService{
	if(instanoteSynchronyServiceService == nil) {
		instanoteSynchronyServiceService = [[InoteSyncInstanoteSynchronyServiceService alloc] init];
	}
	return instanoteSynchronyServiceService;
}


@end
			