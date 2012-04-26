//
//  RestaurantViewController.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantViewController : UIViewController


@property (nonatomic, retain) Restaurant *restaurant;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *description;

- (void) releaseOutlets;

- (IBAction) backClicked: (id) sender;
- (void) updateUI;

@end
