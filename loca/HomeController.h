//
//  HomeController.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeController : UIViewController


@property (nonatomic, retain) MenuController *menuController;
@property (nonatomic, retain) HomeFrameController *frameController;
@property (nonatomic, retain) UIViewController *mainController;

- (void) toggleMenu;
- (void) switchPage:(UIViewController *) controller;
- (void) releaseOutlets;

+ (HomeController *) singleton;

@end
