//
//  BadgeCell.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridViewCell.h"

@interface BadgeCell : UIGridViewCell


@property (nonatomic, retain) PromotionBadge *badge;
@property (nonatomic, retain) IBOutlet UIImageView *thumbnail;
@property (nonatomic, retain) IBOutlet UILabel *name;


- (void) updateUI;

@end
