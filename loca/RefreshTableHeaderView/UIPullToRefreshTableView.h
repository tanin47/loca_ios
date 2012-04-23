//
//  UIPullToRefreshTableView.h
//  foodling2
//
//  Created by Apirom Na Nakorn on 3/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface UIPullToRefreshTableView : UITableView<UITableViewDelegate, EGORefreshTableHeaderDelegate> {
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL isLoading;
}

@property (nonatomic, retain) IBOutlet id<UITableViewDelegate, EGORefreshTableHeaderDelegate> newDelegate;
@property (nonatomic, retain) NSString *emptyLabelText;
@property (nonatomic, retain) UILabel *emptyLabel;

- (void) setup;
- (void) startLoading;
- (void) stopLoading;
- (void) updateEmptyLabel;

@end
