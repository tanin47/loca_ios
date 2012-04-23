//
//  Restaurant.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : BaseModel




@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;


+ (Restaurant *) newElement;


@end
