//
//  PromotionBadge.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PromotionBadge.h"


static NSMutableDictionary *hash = nil;



@implementation PromotionBadge

@synthesize promotion;
@synthesize number;
@synthesize isUsed;

- (void) dealloc
{
    self.promotion = nil;
    self.badgeNumber = nil;
    
    [super dealloc];
}


+ (void) updateAllWithJsonArray: (NSMutableArray *) array
{
	//DLog(@"");
	for (NSMutableDictionary *row in array) {
		[self getObjectWithId:[row objectForKey:@"id"]
               AndSetWithJson:row
                  AndWithHash:hash];
	}
}



+ (PromotionBadge *) newElement
{
    return [self newElementWithHash:hash];
}

- (void) setPropertiesFromJson: (NSMutableDictionary *) json
{
	//DLog(@"");
	self.identity = [json objectForKey:@"id"];
	self.number = [json objectForKey:@"number"];
	self.promotion = [Promotion getObjectWithId:[json objectForKey:@"promotion_id"]];
    self.isUsed = [(NSNumber *)[json objectForKey:@"collected_count"] boolValue];
    
    self.promotion.badge = self;
}


@end
