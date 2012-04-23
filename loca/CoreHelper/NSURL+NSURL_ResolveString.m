//
//  NSURL+NSURL_ResolveString.m
//  foodling2
//
//  Created by Apirom Na Nakorn on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSURL+NSURL_ResolveString.h"

@implementation NSURL (NSURL_ResolveString)

+ (NSURL *) resolveString: (NSString *) urlOrPath
{
    if (urlOrPath == nil || [urlOrPath isKindOfClass:[NSNull class]]) return nil;
    
    
    if ([urlOrPath hasPrefix:@"http://"]
        || [urlOrPath hasPrefix:@"https://"]) {
        return [NSURL URLWithString:urlOrPath];
    } else {
        return [NSURL fileURLWithPath:urlOrPath];
    }
}

@end
