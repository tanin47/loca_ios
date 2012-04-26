//
//  TransferFriendController.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferFriendController : UIViewController<UISearchBarDelegate>


@property (nonatomic, retain) IBOutlet UISearchBar *searchTextbox;

@property (nonatomic, retain) IBOutlet UIPullToRefreshTableView *table;
@property (nonatomic, retain) NSDate *lastUpdate;
@property (nonatomic, retain) NSMutableArray* data;

@property (nonatomic, retain) NSMutableArray* filteredData;

- (void) releaseOutlets;

- (IBAction) backClicked: (id) sender;
- (void) filterData;

+ (TransferFriendController *) singleton;

@end
