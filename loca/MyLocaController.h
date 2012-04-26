//
//  MyLocaController.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"

@interface MyLocaController : UIViewController


@property (nonatomic, retain) IBOutlet UIGridView *table;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSDate *lastUpdate;


- (void) releaseOutlets;

- (IBAction) toggleMenu: (id) sender;
+ (MyLocaController *) singleton;

@end
