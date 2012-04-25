//
//  Promotion.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PromotionBadge;


@interface Promotion : BaseModel


@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;

@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) NSString *thumbnailUrl;

@property (nonatomic) int total;
@property (nonatomic) int collected_count;

@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;

@property (nonatomic, retain) PromotionBadge *badge;

+ (Promotion *) getObjectWithId: (NSString *) identity;
+ (Promotion *) getObjectWithId: (NSString *) identity
                 AndSetWithJson: (NSMutableDictionary *) json;
+ (Promotion *) newElement;
+ (void) updateAllWithJsonArray: (NSMutableArray *) array;
- (void) setPropertiesFromJson: (NSMutableDictionary *) json;


@end
