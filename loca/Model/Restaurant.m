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


+ (Restaurant *) newElement
{
    return [self newElementWithHash:hash];
}

@end
