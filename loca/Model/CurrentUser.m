//
//  CurrentUser.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CurrentUser.h"

static User *sharedInstance = nil;

@implementation CurrentUser


#pragma mark Singleton Methods
+ (User *) singleton {
    @synchronized(self) {
        
        if (sharedInstance == nil) {
            sharedInstance = [[Guest alloc] init];
		}
		
		
    }
    return sharedInstance;
}


+ (User *) setSingleton: (User *) user {
    @synchronized(self) {
		User *previous = sharedInstance;
		sharedInstance = [user retain];
		if (previous == nil) [previous release];
    }
    return sharedInstance;
}


@end
