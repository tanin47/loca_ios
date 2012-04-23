//
//  Guest.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Guest.h"


static Guest *sharedInstance = nil;


@implementation Guest


#pragma mark Singleton Methods
+ (Guest *) singleton {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
		}
    }
    return sharedInstance;
}


- (BOOL) isGuest
{
    return YES;
}

@end
