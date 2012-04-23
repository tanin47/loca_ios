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


- (IBAction) backClicked: (id) sender;
- (void) updateUI;

@end
