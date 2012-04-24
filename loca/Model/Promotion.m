//
//  Promotion.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Promotion.h"


static NSMutableDictionary *hash = nil;



@implementation Promotion


@synthesize name;
@synthesize description;

@synthesize restaurant;
@synthesize thumbnailUrl;

@synthesize total;
@synthesize collected_count;

@synthesize badge;



+ (Promotion *) getObjectWithId: (NSString *) identity
                 AndSetWithJson: (NSMutableDictionary *) json
{
    return [self getObjectWithId:identity 
                  AndSetWithJson:json
                     AndWithHash: (NSMutableDictionary *) hash];
}


+ (Promotion *) newElement
{
    return [self newElementWithHash:hash];
}


- (void) setPropertiesFromJson: (NSMutableDictionary *) json
{
	//DLog(@"");
	self.identity = [json objectForKey:@"id"];
	self.name = [json objectForKey:@"name"];
	self.description = [json objectForKey:@"description"];
    self.restaurant = [Restaurant getObjectWithId:[json objectForKey:@"restaurant_id"]];
    self.thumbnailUrl = [json objectForKey:@"thumbnail_url"];
    
	self.collected_count = [(NSNumber *)[json objectForKey:@"collected_count"] intValue];
	self.total = [(NSNumber *)[json objectForKey:@"total"] intValue];
}


@end
