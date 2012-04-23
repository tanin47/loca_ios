//
//  UniqueIdGenerator.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UniqueIdGenerator.h"

static int runId = 0;

@implementation UniqueIdGenerator


+ (NSString *) generate
{
    NSString *uid = [NSString stringWithFormat:@"id-%@-%ld-%d",
                     [[UIDevice currentDevice] uniqueIdentifier],
                     (long)[[NSDate date] timeIntervalSince1970],
                     runId++];
    return uid;
}

@end
