//
//  Friend.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic, retain) NSString *facebookId;
@property (nonatomic, retain) NSString *name;


- (NSString *) getThumbnailUrl;


@end
