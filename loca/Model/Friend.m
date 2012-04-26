//
//  Friend.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Friend.h"

@implementation Friend

@synthesize facebookId;
@synthesize name;


- (void) dealloc
{
    self.facebookId = nil;
    self.name = nil;
    
    [super dealloc];
}


- (NSString *) getThumbnailUrl
{
    NSString *url = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square", self.facebookId];
    return url;
}

@end
