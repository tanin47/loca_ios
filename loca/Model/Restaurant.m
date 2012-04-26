//
//  Restaurant.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Restaurant.h"


static NSMutableDictionary *hash = nil;


@implementation Restaurant


@synthesize name;
@synthesize description;

@synthesize latitude;
@synthesize longitude;


- (void) dealloc
{
    self.name = nil;
    self.description = nil;
    
    [super dealloc];
}


+ (Restaurant *) getObjectWithId: (NSString *) identity
{
    return (Restaurant *)[self getObjectWithId:identity
                                   AndWithHash:&hash];
}

+ (Restaurant *) getObjectWithId: (NSString *) identity
                 AndSetWithJson: (NSMutableDictionary *) json
{
    return (Restaurant *)[self getObjectWithId:identity 
                                AndSetWithJson:json
                                   AndWithHash:&hash];
}


+ (void) updateAllWithJsonArray: (NSMutableArray *) array
{
	//DLog(@"");
	for (NSMutableDictionary *row in array) {
		[self getObjectWithId:[row objectForKey:@"id"]
               AndSetWithJson:row
                  AndWithHash:&hash];
	}
}


+ (Restaurant *) newElement
{
    return (Restaurant *)[self newElementWithHash:&hash];
}

- (void) setPropertiesFromJson: (NSMutableDictionary *) json
{
	//DLog(@"");
	self.identity = [json objectForKey:@"id"];
	self.name = [json objectForKey:@"name"];
	self.description = [json objectForKey:@"description"];
	self.latitude = [(NSNumber *)[json objectForKey:@"latitude"] doubleValue];
	self.longitude = [(NSNumber *)[json objectForKey:@"longitude"] doubleValue];
}

@end
