//
//  TransferFriendController.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferFriendController : UIViewController


@property (nonatomic, retain) IBOutlet UIPullToRefreshTableView *table;
@property (nonatomic, retain) NSDate *lastUpdate;
@property (retain) NSMutableArray* data;

- (IBAction) backClicked: (id) sender;

+ (TransferFriendController *) singleton;

@end
