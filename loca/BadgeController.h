//
//  BadgeController.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeController : UIViewController

@property (nonatomic, retain) PromotionBadge *badge;

@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *restaurantName;
@property (nonatomic, retain) IBOutlet UILabel *badgeNumber;
@property (nonatomic, retain) IBOutlet UILabel *isUsed;


- (void) releaseOutlets;

- (IBAction) backClicked: (id) sender;
- (void) updateUI;


+ (BadgeController *) singleton;

@end
