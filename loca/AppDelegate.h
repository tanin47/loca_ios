//
//  AppDelegate.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate>

@property (nonatomic, retain) Facebook *facebook;
@property (strong, nonatomic) UIWindow *window;

@end
