//
//  PromotionBadge.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PromotionBadge : BaseModel


@property (nonatomic, retain) Promotion *promotion;
@property (nonatomic, retain) NSString *number;
@property (nonatomic) BOOL isUsed;

+ (void) updateAllWithJsonArray: (NSMutableArray *) array
+ (PromotionBadge *) newElement;
- (void) setPropertiesFromJson: (NSMutableDictionary *) json

@end
