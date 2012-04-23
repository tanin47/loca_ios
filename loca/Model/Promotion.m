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
@synthesize collect;

@synthesize badge;



+ (Promotion *) newElement
{
    return [self newElementWithHash:hash];
}



@end
