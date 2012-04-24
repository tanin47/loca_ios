//
//  Connector.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Connector.h"

static Connector *sharedInstance = nil;

@implementation Connector


#pragma mark Singleton Methods
+ (Connector *) singleton {
	
	if (sharedInstance == nil) {
		Connector *tmp = [[HttpConnector alloc] init];
		[Connector setSingleton:tmp];
		[tmp release];
	}
	
    return sharedInstance;
}


+ (void) setSingleton: (Connector *) connector {
    @synchronized(self) {
		Connector *previous = sharedInstance;
		sharedInstance = [connector retain];
		if (previous == nil) [previous release];
    }
}

@end
