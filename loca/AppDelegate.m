//
//  AppDelegate.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize facebook;
@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MainController alloc] init];
    [self.window makeKeyAndVisible];
    
    
    [[LocationManager singleton] start];
    
    DLog(@"hi");
	self.facebook = [[Facebook alloc] initWithAppId:FACEBOOK_APP_ID andDelegate:self];
      DLog(@"hi");
    
	if (![[Connector singleton] isKindOfClass:[FakeConnector class]]) {
        
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
            
			self.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
			self.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
            
			NSString *locaId = [defaults objectForKey:@"LocaId"];
			
			if (locaId != nil) {
				User *user = [User getObjectWithId:locaId];
                
				user.identity = [defaults objectForKey:@"LocaId"];
				user.name = [defaults objectForKey:@"FBName"];
				user.facebookId = [defaults objectForKey:@"FBId"];
				user.thumbnailUrl = [defaults objectForKey:@"FBThumbnailUrl"];
                
				[CurrentUser setSingleton:user];
			}
            
			[defaults synchronize];
		}
	}
    
    
    return YES;
}


// Pre 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	//DLog(@"");
    return [self.facebook handleOpenURL:url]; 
}

// For 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	//DLog(@"");
    return [self.facebook handleOpenURL:url]; 
}


- (void)fbDidLogin {
	//DLog(@"");
	[[Connector singleton] processFacebookLogin];
}


- (void) fbDidLogout {
	//DLog(@"");
	
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
		
		[defaults removeObjectForKey:@"FBName"];
		[defaults removeObjectForKey:@"FBId"];
		[defaults removeObjectForKey:@"FBThumbnailUrl"];
		
        [defaults synchronize];
    }
}



- (void)fbDidNotLogin:(BOOL)cancelled
{
    
}

- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt
{
    
}

- (void)fbSessionInvalidated
{
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
