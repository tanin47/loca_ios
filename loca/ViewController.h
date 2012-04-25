//
//  ViewController.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<FBDialogDelegate>


@property (nonatomic, retain) Promotion *promotion;

@property (nonatomic, retain) IBOutlet UIImageView *thumbnail;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *restaurantName;
@property (nonatomic, retain) IBOutlet UILabel *description;
@property (nonatomic, retain) IBOutlet UILabel *date;

@property (nonatomic, retain) RestaurantPin *pin;
@property (nonatomic, retain) IBOutlet MKMapView *map;

@property (nonatomic, retain) IBOutlet UIButton *collectButton;
@property (nonatomic, retain) IBOutlet UIButton *showBadgeButton;
@property (nonatomic, retain) IBOutlet UIButton *transferButton;

- (IBAction) backClicked: (id) sender;
- (IBAction) collectClicked: (id) sender;
- (IBAction) showBadgeClicked: (id) sender;
- (IBAction) shareClicked: (id) sender;
- (IBAction) transferClicked: (id) sender;

- (void) collectPromotion;
- (void) updateUI;


+ (ViewController *) singleton;

@end
