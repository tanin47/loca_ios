//
//  FakeConnector.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FakeConnector.h"

@implementation FakeConnector


@synthesize fakeCurrentUser;
@synthesize restaurants;
@synthesize promotions;
@synthesize badges;



- (id) init {
	//DLog(@"");
	if (self = [super init]) {
        
        
        self.fakeCurrentUser = [User getObjectWithId:[UniqueIdGenerator generate]];
        self.fakeCurrentUser.facebookId = @"12345";
        self.fakeCurrentUser.name = @"Tubtim Mallika";
        self.fakeCurrentUser.thumbnailUrl = @"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc4/49077_716666864_2126527931_q.jpg";
        
        
        
        
        self.restaurants = [NSMutableArray arrayWithCapacity:5];
        
        Restaurant *bacco = [Restaurant newElement];
        bacco.name = @"Bacco";
        bacco.description = @"ขายอาหารอิตาเลี่ยน";
        bacco.latitude = [LocationManager singleton].currentLocation.coordinate.latitude + ((double) (arc4random() % 100) / 70000.0);
		bacco.longitude = [LocationManager singleton].currentLocation.coordinate.longitude + ((double) (arc4random() % 100) / 70000.0);
        [self.restaurants addObject:bacco];

        
        Restaurant *ramen = [Restaurant newElement];
        ramen.name = @"Grand Ramen";
        ramen.description = @"ขายราเมน";
        ramen.latitude = [LocationManager singleton].currentLocation.coordinate.latitude + ((double) (arc4random() % 100) / 70000.0);
		ramen.longitude = [LocationManager singleton].currentLocation.coordinate.longitude + ((double) (arc4random() % 100) / 70000.0);
        [self.restaurants addObject:ramen];
        
        
        
        
        self.promotions = [NSMutableArray arrayWithCapacity:5];
        
        {
            Promotion *pro = [Promotion newElement];
            pro.name = @"Salad 50%";
            pro.description = @"เติมเต็มความอร่อยไม่อั้นในมื้อพิเศษของคุณ กับอาหารบุฟเฟต์นานาชาติรสเลิศ ที่ 92 café โรงแรม Golden Tulip Sovereign - พระราม 9";
            pro.restaurant = bacco;
            pro.thumbnailUrl = @"http://seafoodbar.files.wordpress.com/2011/11/sushi-promotion-thumbnail1.jpg?w=300";
            [self.promotions addObject:pro];
        }
        
        {
            Promotion *pro = [Promotion newElement];
            pro.name = @"Ramen 50%";
            pro.description = @"พบคำตอบสำหรับนักเดินทางเช่นคุณ กับ 1 คืน ในห้องดีลักซ์สแตนดาร์ด สำหรับ 2 ท่าน ท่ามกลางแสงสีและชีวิตชีวาของเมืองพัทยา (มูลค่า 3,600 บาท)";
            pro.restaurant = ramen;
            pro.thumbnailUrl = @"http://i2.ytimg.com/vi/yfEUwNQTXwU/hqdefault.jpg";
            [self.promotions addObject:pro];
        }
        
        
        
        
        self.badges = [NSMutableArray arrayWithCapacity:5];
        
    }
    return self;
}



- (void) dealloc
{
    self.fakeCurrentUser = nil;
    self.promotions = nil;
    self.restaurants = nil;
    
    [super dealloc];
}



- (void) processFacebookLogin
{
	//DLog(@"");
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[delegate.facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[delegate.facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
	
	
	
	
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, name, pic_square FROM user WHERE uid=me()", @"query",
                                   nil];
    
    
    facebookRequestDidLoad = [[^(FBRequest *request, id result) {
        //DLog(@"");
        if (![result isKindOfClass:[NSArray class]] || ![[result objectAtIndex:0] objectForKey:@"name"]) {
            [self request:request didFailWithError:nil];
            return;
        }
        
        result = [result objectAtIndex:0];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        
        
        [self authorizeUserWithFacebookId:[result objectForKey:@"uid"] 
                          AndFacebookName:[result objectForKey:@"name"] 
                          AndThumbnailUrl:[result objectForKey:@"pic_square"] 
                           AndAccessToken:accessToken
                                AndOnDone:^(User *user) {
                                    
                                    //DLog(@"");
                                    [CurrentUser setSingleton:user];
                                    
                                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                    [defaults setObject:[CurrentUser singleton].name forKey:@"FBName"];
                                    [defaults setObject:[CurrentUser singleton].facebookId forKey:@"FBId"];
                                    [defaults setObject:[CurrentUser singleton].thumbnailUrl forKey:@"FBThumbnailUrl"];
                                    [defaults synchronize];
                                    
                                    
                                    dispatch_async( dispatch_get_main_queue(), ^{
                                        loginCallback();
                                        [self releaseLoginCallbackBlocks];
                                    });
                                    
                                } 
                                AndOnFail:^{
                                    //DLog(@"");
                                    dispatch_async( dispatch_get_main_queue(), ^{
                                        loginFailCallback();
                                        [self releaseLoginCallbackBlocks];
                                    });
                                }]; 
    } copy] retain];
    
    facebookRequestDidFail = [[^(FBRequest *request, NSError *error) {
        dispatch_async( dispatch_get_main_queue(), ^{
            loginFailCallback();
            [self releaseLoginCallbackBlocks];
        });
    } copy] retain];
	
    [delegate.facebook requestWithMethodName:@"fql.query"
								   andParams:params
							   andHttpMethod:@"POST"
								 andDelegate:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
	facebookRequestDidLoad(request, result);
    [self releaseFacebookCallbackBlocks];
}



- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
	facebookRequestDidFail(request, error);
    [self releaseFacebookCallbackBlocks];
}


- (void) releaseFacebookCallbackBlocks
{
    [facebookRequestDidLoad release]; 
    [facebookRequestDidFail release];
}

- (void) releaseLoginCallbackBlocks
{
    [loginCallback release];
    [loginFailCallback release];
}




- (void) loginOnDone:(void(^)()) callback
           AndOnFail:(void(^)()) failCallback
{
    loginCallback = [[callback copy] retain];
    loginFailCallback = [[failCallback copy] retain];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
	NSArray *permissions = [[NSArray alloc] initWithObjects:
							@"offline_access",
                            @"email",
                            @"publish_stream",
                            @"user_birthday",
							nil];
	[delegate.facebook authorize:permissions];
	[permissions release];
}



- (void) logoutOnDone:(void(^)()) callback
            AndOnFail:(void(^)()) failCallback
{
    //DLog(@"");
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate.facebook logout];
	
	[CurrentUser setSingleton:[Guest singleton]];
    
    //DLog(@"");
	dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		//DLog(@"");
		[NSThread sleepForTimeInterval:0.5];
		
        dispatch_async( dispatch_get_main_queue(), ^{
            callback();
        });
	});
}



- (void) authorizeUserWithFacebookId:(NSString *) facebookId
					 AndFacebookName:(NSString *) facebookName
					 AndThumbnailUrl:(NSString *) thumbnailUrl
					  AndAccessToken:(NSString *) accessToken
						   AndOnDone:(void(^)(User *)) callback
						   AndOnFail:(void(^)()) failCallback
{
    self.fakeCurrentUser.facebookId = facebookId;
    self.fakeCurrentUser.name = facebookName;
    self.fakeCurrentUser.thumbnailUrl = thumbnailUrl;
    
	//DLog(@"");
	dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		//DLog(@"");
		[NSThread sleepForTimeInterval:0.5];
        
		dispatch_async( dispatch_get_main_queue(), ^{
            callback(self.fakeCurrentUser);
        });
        
	});
}






- (void) getNearPromotionAndOnDone:(void(^)(NSMutableArray *)) callback
                         AndOnFail:(void(^)()) failCallback
{
    DLog(@"");
	dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		
        DLog(@"");
		[NSThread sleepForTimeInterval:1.5];
        
        for (Promotion *pro in self.promotions) {
            pro.restaurant.latitude = [LocationManager singleton].currentLocation.coordinate.latitude + ((double) (arc4random() % 100) / 70000.0);
            pro.restaurant.longitude = [LocationManager singleton].currentLocation.coordinate.longitude + ((double) (arc4random() % 100) / 70000.0);
        }
        
        dispatch_async( dispatch_get_main_queue(), ^{
            callback(self.promotions);
        });
    });
}


- (void) collectPromotion: (Promotion *) promotion
                AndOnDone:(void(^)()) callback
                AndOnFail:(void(^)(NSString *errorMessage)) failCallback
{
    DLog(@"");
	dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		
        DLog(@"");
		[NSThread sleepForTimeInterval:1.5];
        
        PromotionBadge *badge = [PromotionBadge newElement];
        badge.promotion = promotion;
        promotion.badge = badge;
        badge.number = [NSString stringWithFormat:@"%04d-%04d-%04d", (arc4random() % 1000), (arc4random() % 1000), [self.badges count]];
        
        [self.badges insertObject:badge atIndex:0];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            callback();
        });
    });
}


- (void) getPromotionBadgeAndOnDone:(void(^)(NSMutableArray *badges)) callback
                          AndOnFail:(void(^)()) failCallback
{
    DLog(@"");
	dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		
        DLog(@"");
		[NSThread sleepForTimeInterval:1.5];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            callback(self.badges);
        });
    }); 
}


- (void) getFriendsAndOnDone:(void(^)(NSMutableArray *friends)) callback
                   AndOnFail:(void(^)()) failCallback
{
    DLog(@"");
    facebookRequestDidLoad = [[^(FBRequest *request, id result) {
        DLog(@"%@", result);
        NSDictionary *response = (NSDictionary *) result;
        NSArray *data = [response objectForKey:@"data"];
        
        NSMutableArray *friends = [NSMutableArray arrayWithCapacity:[data count]];
        
        for (NSDictionary *dict in data) {
            Friend *f = [[Friend alloc] init];
            f.name = [dict objectForKey:@"name"];
            f.facebookId = [NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]];
            [friends addObject:f];
            [f release];
        }
        
        callback(friends);
        
    } copy] retain];
    
    
    facebookRequestDidFail = [[^(FBRequest *request, NSError *error) {
        DLog(@"");
        dispatch_async( dispatch_get_main_queue(), ^{
            failCallback();
        });
    } copy] retain];
    
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //[delegate.facebook requestWithGraphPath:@"search?q=mark&type=user" andDelegate:self];
    [delegate.facebook requestWithGraphPath:@"me/friends" andDelegate:self];
}


- (void) transferBadge: (PromotionBadge *) badge
          ToFacebookId: (NSString *) facebookId
           WithMessage: (NSString *) message
             AndOnDone: (void(^)()) callback
             AndOnFail: (void(^)(NSString *errorMessage)) failCallback
{
    DLog(@"");
	dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		
        DLog(@"");
		[NSThread sleepForTimeInterval:1.5];
        
        [self.badges removeObject:badge];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            callback();
        });
    }); 
}


- (void) sharePromotion: (Promotion *) promotion
            WithMessage: (NSString *) message
              AndOnDone: (void(^)()) callback
              AndOnFail: (void(^)()) failCallback
{
    DLog(@"");
	dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		
        DLog(@"");
		[NSThread sleepForTimeInterval:1.5];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            callback();
        });
    }); 
}

@end
