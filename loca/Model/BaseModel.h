//
//  BaseModel.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject



@property (nonatomic, retain) NSString *identity;



+ (BaseModel *) newElementWithHash:(NSMutableDictionary **) hash;
+ (BaseModel *) getObjectWithId: (NSString *) identity
                    AndWithHash: (NSMutableDictionary **) hash;
+ (BaseModel *) getObjectWithId: (NSString *) identity
                    AndWithHash: (NSMutableDictionary **) hash;
+ (BaseModel *) getObjectWithId: (NSString *) identity
                 AndSetWithJson: (NSMutableDictionary *) json
                    AndWithHash: (NSMutableDictionary **) hash;
+ (void) updateAllWithJsonArray: (NSMutableArray *) array
                    AndWithHash: (NSMutableDictionary **) hash;
- (void) setPropertiesFromJson: (NSMutableDictionary *) json;

@end
