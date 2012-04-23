//
//  NewRestaurantPin.m
//  foodling2
//
//  Created by Apirom Na Nakorn on 2/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RestaurantPin.h"


@implementation RestaurantPin

@synthesize coordinate;

- (NSString *)subtitle
{  
	return @"";  
}  

- (NSString *)title
{  
	return @"";  
}  

-(id)initWithCoordinate:(CLLocationCoordinate2D) newCoordinate
{  
	self.coordinate = newCoordinate;
	return self;  
}  

@end
