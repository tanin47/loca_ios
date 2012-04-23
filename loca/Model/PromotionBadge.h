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
@property (nonatomic, retain) NSString *badgeNumber;

+ (PromotionBadge *) newElement;

@end
