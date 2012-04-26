//
//  BaseModel.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


@synthesize identity;

- (void) dealloc
{
    self.identity = nil;
    
    [super dealloc];
}



+ (BaseModel *) newElementWithHash:(NSMutableDictionary **) hash
{
    return [self getObjectWithId:[UniqueIdGenerator generate]
                     AndWithHash:hash];
}


+ (BaseModel *) getObjectWithId: (NSString *) identity
                    AndWithHash: (NSMutableDictionary **) hash;
{
	//DLog(@"");
	if ((*hash) == nil) 
        (*hash) = [[NSMutableDictionary alloc] init];
	
	BaseModel *m = [(*hash) objectForKey:identity];
	
	if (m == nil) {
		m = [[self alloc] init] ;
        m.identity = identity;
		[(*hash) setObject:m forKey:identity];
		[m release];
	}
	
	return m;
}


+ (BaseModel *)getObjectWithId: (NSString *) identity
                AndSetWithJson:(NSMutableDictionary *) json
                   AndWithHash: (NSMutableDictionary **) hash
{
	//DLog(@"");
	BaseModel *m = [self getObjectWithId:identity
                             AndWithHash:hash];
	[m setPropertiesFromJson:json];
	return m;
}

+ (void) updateAllWithJsonArray: (NSMutableArray *) array
                    AndWithHash: (NSMutableDictionary **) hash
{
	//DLog(@"");
	for (NSMutableDictionary *row in array) {
		[self getObjectWithId:[row objectForKey:@"id"]
               AndSetWithJson:row
                  AndWithHash:hash];
	}
	
}

@end
