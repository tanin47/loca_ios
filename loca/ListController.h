//
//  ListController.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromotionRow.h"

@interface ListController : UIViewController


@property (nonatomic, retain) IBOutlet UIPullToRefreshTableView *table;
@property (nonatomic, retain) NSDate *lastUpdate;
@property (retain) NSMutableArray* data;


- (void) locationInitialized:(NSNotification *) notification;
- (IBAction) toggleMenu: (id) sender;


+ (ListController *) singleton;

@end
