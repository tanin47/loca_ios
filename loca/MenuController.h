//
//  MenuController.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIButton *myLocaButton;
@property (nonatomic, retain) IBOutlet UIButton *loginButton;
@property (nonatomic, retain) IBOutlet UIButton *logoutButton;

- (IBAction) loginClicked: (id) sender;
- (IBAction) logoutClicked: (id) sender;

- (IBAction) listClicked: (id) sender;
- (IBAction) myLocaClicked: (id) sender;

- (void) updateUI;

+ (MenuController *) singleton;

@end
