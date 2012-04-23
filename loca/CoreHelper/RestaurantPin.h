//
//  NewRestaurantPin.h
//  foodling2
//
//  Created by Apirom Na Nakorn on 2/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>  

@interface RestaurantPin : NSObject<MKAnnotation> {

}

@property CLLocationCoordinate2D coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;  

- (NSString *)subtitle;  
- (NSString *)title;  

@end
