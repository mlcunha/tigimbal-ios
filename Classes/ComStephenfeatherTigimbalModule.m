/**
 * tiGimbal Project
 * Copyright (c) 2014 by Stephen Feather. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "ComStephenfeatherTigimbalModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import <FYX/FYX.h>
#import <FYX/FYXLogging.h>
#import <FYX/FYXSightingManager.h>
#import <FYX/FYXVisitManager.h>


@implementation ComStephenfeatherTigimbalModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"cc55a178-b122-49fd-a6c0-e6da91fdd6f2";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.stephenfeather.tigimbal";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

//***********************
// These represent the functions and handlers for the INITIALIZATION portion of the Gimbal IOS SDK
// https://gimbal.com/doc/proximity/ios.html#initialization
//

// init takes setAppId, appSecret, callbackUrl.
// must be called before service can be started.
-(void)init:(id)args
{
	ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);
	NSString * setAppId = [TiUtils stringValue:@"setAppId" properties:args def:@""];
	NSString * appSecret = [TiUtils stringValue:@"appSecret" properties:args def:@""];
	NSString * callbackUrl = [TiUtils stringValue:@"callbackUrl" properties:args def:@""];
    NSLog(@"FYX Init Called");
	[FYX setAppId:setAppId appSecret:appSecret callbackUrl:callbackUrl];
    [FYXLogging setLogLevel:FYX_LOG_LEVEL_VERBOSE];
}

// startService registers the application with the server and starts bluetooth scanning
-(void)startService:(id)args
{
    NSLog(@"FYX startService Called");
    [FYX startService:self];
}

// startServiceAndAuthorize registers the application with the server, starts a user session and starts bluetooth scanning
-(void)startServiceAndAuthorize:(id)args
{
    NSLog(@"FYX startServiceAndAuthorize Called");
    [FYX startServiceAndAuthorize:self];
}

// handleOpenUrl - the url used to reopen the app during the OAuth is handed to this function to complete the OAuth token retrieval
-(void)handleOpenURL:(id)args
{
    NSString* jsurl = [TiUtils stringValue:args];
    NSURL* url = [[NSURL alloc]initWithString:jsurl];
    [FYX handleOpenURL:url];
}

// stopService will stop bluetooth scanning.
-(void)stopService:(id)args
{
    NSLog(@"FYX stopService Called");
    [FYX stopService];
}

// disableLocationUpdates
-(void)disableLocationUpdates:(id)args
{
    NSLog(@"FYX disableLocationUpdates Called");
    [FYX disableLocationUpdates];
}

// enableLocationUpdates
-(void)enableLocationUpdates:(id)args
{
    NSLog(@"FYX enableLocationUpdates Called");
    [FYX enableLocationUpdates];
}

// stopServiceAndDeauthorize
-(void)stopServiceAndDeauthorize:(id)args
{
    NSLog(@"FYX stopServiceAndDeauthorize Called");
    [FYX stopServiceAndDeauthorize];
}

// deleteVisitsAndSightings
-(void)deleteVisitsAndSightings:(id)args
{
    NSLog(@"FYX deleteVisitsAndSightings Called");
    [FYX deleteVisitsAndSightings];
}

// Message Handlers

-(void)startServiceFailed:(NSError *)error
{
    // this will be called if the service has failed to start
    NSLog(@"%@", error);
}

-(void)serviceStarted
{
    // this will be invoked if the service has successfully started
    // bluetooth scanning will be started at this point.
    NSLog(@"FYX Service Successfully Started");
}

-(void)sessionCreateFailed:(NSError *)error
{
    // this will be called if the session has failed to start
    // further calls into the SDK will be rejected by the server as Unauthorized
    NSLog(@"%@", error);
}

-(void)sessionStarted
{
    // this will be invoked if the session has successfully started
    // further calls into the SDK should be allowed at this point
    NSLog(@"FYX Session Successfully Started");
}

-(void)sessionEndFailed:(NSError *)error
{
    // this will be called if the session has failed to end
    NSLog(@"%@", error);
}

-(void)sessionEnded
{
    // this will be invoked if the session has successfully ended and the user is deauthorized
    NSLog(@"FYX Service Successfully ended and user is deauthorized");
}

-(void)sessionDataDeleteFailed:(NSError *)error
{
    // this will be invoked if the visits and sighting data has not been successfully deleted
    NSLog(@"%@", error);
}

-(void)sessionDataDeleted
{
    // this will be invoked if the visits and sighting data has been successfully deleted
    NSLog(@"FYX Session Data Successfully deleted");
}

//***********************
// These represent the functions and handlers for the LOGGING portion of the Gimbal IOS SDK
// https://gimbal.com/doc/proximity/ios.html#set_log_level
//

// TODO: setLogLevel

-(void)enableFileLogging:(id)args
{
    NSLog(@"FYX Enabling File Logging");
    [FYXLogging enableFileLogging];
}

-(void)disableFileLogging:(id)args
{
    NSLog(@"FYX Disabling File Logging");
    [FYXLogging disableFileLogging];
}

@end

