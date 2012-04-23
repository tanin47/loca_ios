//
//  LocationManager.h
//  gamlingv2
//
//  Created by Apirom Na Nakorn on 11/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface  LocationManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

+ (LocationManager *) singleton;

-(void) start;
-(void) stop;
-(BOOL) locationKnown;
-(BOOL) nearLat:(double)lat
			Lng:(double)lng;

@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) NSString *placeName;

@end

