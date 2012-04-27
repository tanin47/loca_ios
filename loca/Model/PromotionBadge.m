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
    self.number = nil;
    
    [super dealloc];
}


+ (PromotionBadge *) getObjectWithId: (NSString *) identity
{
    return (PromotionBadge *)[self getObjectWithId:identity
                                       AndWithHash:&hash];
}

+ (PromotionBadge *) getObjectWithId: (NSString *) identity
                  AndSetWithJson: (NSMutableDictionary *) json
{
    return (PromotionBadge *)[self getObjectWithId:identity 
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



+ (PromotionBadge *) newElement
{
    return (PromotionBadge *)[self newElementWithHash:&hash];
}

- (void) setPropertiesFromJson: (NSMutableDictionary *) json
{
	//DLog(@"");
	self.identity = [json objectForKey:@"id"];
	self.number = [json objectForKey:@"number"];
	self.promotion = [Promotion getObjectWithId:[json objectForKey:@"promotion_id"]];
    self.isUsed = [(NSNumber *)[json objectForKey:@"is_used"] boolValue];
    
    self.promotion.badge = self;
    
    DLog(@"%@ %@ %@", [json objectForKey:@"promotion_id"], [Promotion getObjectWithId:[json objectForKey:@"promotion_id"]], self.promotion);
}


@end
