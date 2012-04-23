//
//  LocationManager.m
//  gamlingv2
//
//  Created by Apirom Na Nakorn on 11/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"

static LocationManager *sharedInstance = nil;

@implementation LocationManager


@synthesize currentLocation;
@synthesize placeName;


+ (LocationManager *) singleton {
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance=[[LocationManager alloc] init];       
    }
    return sharedInstance;
}

+(id)alloc {
    @synchronized(self) {
        NSAssert(sharedInstance == nil, @"Attempted to allocate a second instance of a singleton LocationController.");
        sharedInstance = [super alloc];
    }
    return sharedInstance;
}

-(id) init {
    if (self = [super init]) {
        self.currentLocation = [[CLLocation alloc] init];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [self start];
    }
    return self;
}


-(void) start {
    [locationManager startUpdatingLocation];
}


-(void) stop {
    [locationManager stopUpdatingLocation];
}


-(BOOL) locationKnown { 
	if (-1.0 < currentLocation.coordinate.latitude &&  currentLocation.coordinate.latitude < 1.0
		&& -1.0 < currentLocation.coordinate.longitude &&  currentLocation.coordinate.longitude < 1.0) 
		return NO;
	else 
		return YES;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
	//if the time interval returned from core location is more than two minutes we ignore it because it might be from an old session
    if ([self locationKnown] == NO ||
		(abs([newLocation.timestamp timeIntervalSinceDate: [NSDate date]]) < 120
		 && (fabsf(self.currentLocation.coordinate.latitude - newLocation.coordinate.latitude) > 0.0001
			 || fabsf(self.currentLocation.coordinate.longitude - newLocation.coordinate.longitude) > 0.0001))) {
			 
			 self.currentLocation = newLocation;
			 NSLog(@"update %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
			 
			 [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationUpdated" 
																 object:self];
			 
		 }
	
}


-(BOOL) nearLat:(double)lat
			Lng:(double)lng
{
	
	return (fabs(lat - self.currentLocation.coordinate.latitude) < 0.0005
			&& fabs(lng - self.currentLocation.coordinate.longitude) < 0.0005);
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError: %@", error);
}

-(void) dealloc {
    self.placeName = nil;
    self.currentLocation = nil;
    [super dealloc];
}

@end

