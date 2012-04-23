//
//  UIGridView.h
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPullToRefreshTableView.h"

@protocol UIGridViewDelegate;
@class UIGridViewCell;

@interface UIGridView : UIPullToRefreshTableView<UITableViewDelegate, UITableViewDataSource> {
	UIGridViewCell *tempCell;
}

@property (nonatomic, retain) IBOutlet id<UIGridViewDelegate> uiGridViewDelegate;

- (void) setUp;
- (UIGridViewCell *) dequeueReusableCell;

- (IBAction) cellPressed:(id) sender;

@end
