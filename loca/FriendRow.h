//
//  FriendRow.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendRow : UITableViewCell

@property (nonatomic, retain) IBOutlet UIView *cell;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UIImageView *thumbnail;

@property (nonatomic, retain) Friend *friend;


- (void) updateUI;

@end
