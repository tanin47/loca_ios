//
//  User.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

static NSMutableDictionary *hash = nil;


@implementation User


+ (User *) getObjectWithId: (NSString *) userId
{
	if (hash == nil) hash = [[NSMutableDictionary alloc] init];
	
    return [self getObjectWithId:userId 
                     AndWithHash:hash];
}


@synthesize identity;
@synthesize facebookId;  
@synthesize name;
@synthesize thumbnailUrl;


- (BOOL) isGuest
{
    return NO;
}

- (void) setPropertiesFromJson: (NSMutableDictionary *) json
{
	//DLog(@"");
	self.identity = [json objectForKey:@"id"];
	self.facebookId = [json objectForKey:@"facebook_id"];
	self.name = [json objectForKey:@"name"];
}

@end
