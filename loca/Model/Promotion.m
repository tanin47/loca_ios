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

@synthesize startDate;
@synthesize endDate;

@synthesize badge;


+ (Promotion *) getObjectWithId: (NSString *) identity
{
    return (Promotion *)[self getObjectWithId:identity
                                  AndWithHash:&hash];
}


+ (Promotion *) getObjectWithId: (NSString *) identity
                 AndSetWithJson: (NSMutableDictionary *) json
{
    return (Promotion *) [self getObjectWithId:identity 
                                AndSetWithJson:json
                                   AndWithHash:&hash];
}


+ (Promotion *) newElement
{
    return (Promotion *) [self newElementWithHash:&hash];
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
    
    // 2012-03-10T11:44:24+07:00 = ISO 8601 style
	ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
	self.startDate = [formatter dateFromString:[json objectForKey:@"start_date"]];
	self.endDate = [formatter dateFromString:[json objectForKey:@"end_date"]];
	[formatter release];
    
    DLog(@"%@", self.identity);
}


@end
