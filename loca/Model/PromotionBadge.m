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
@synthesize badgeNumber;


+ (PromotionBadge *) newElement
{
    return [self newElementWithHash:hash];
}


@end
