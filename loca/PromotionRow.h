//
//  PromotionRow.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromotionRow : UITableViewCell


@property (nonatomic, retain) IBOutlet UIView *cell;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *restaurantName;
@property (nonatomic, retain) IBOutlet UILabel *quota;
@property (nonatomic, retain) IBOutlet UIImageView *thumbnail;

@property (nonatomic, retain) Promotion *promotion;


- (void) updateUI;


@end
