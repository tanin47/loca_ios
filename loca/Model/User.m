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
    return (User *)[self getObjectWithId:userId 
                             AndWithHash:&hash];
}

+ (User *) getObjectWithId: (NSString *) identity
                 AndSetWithJson: (NSMutableDictionary *) json
{
    return (User *) [self getObjectWithId:identity 
                           AndSetWithJson:json
                              AndWithHash:&hash];
}


@synthesize facebookId;  
@synthesize name;
@synthesize thumbnailUrl;
@synthesize point;

- (void) dealloc
{
    self.facebookId = nil;
    self.name = nil;
    self.thumbnailUrl = nil;
    
    [super dealloc];
}


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
    self.point = [(NSNumber *)[json objectForKey:@"point"] intValue];
}

@end
