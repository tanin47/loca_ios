//
//  FriendRow.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendRow.h"

@implementation FriendRow


@synthesize cell;
@synthesize name;
@synthesize thumbnail;

@synthesize friend;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = CGRectMake(0, 0, 320, 88);
        
		[[NSBundle mainBundle] loadNibNamed:@"FriendRow" owner:self options:nil];
		
        [self.contentView addSubview:self.cell];
        self.frame = self.cell.frame;
		
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
		
        //		self.backgroundColor = [UIColor clearColor];
        //		self.opaque = NO;
        //		self.backgroundView = nil;
        //		
        //		UIView *blank = [[UIView alloc] init];
        //		self.selectedBackgroundView = blank;
        //		[blank release];
    }
    return self;
}


- (void) setFriend: (Friend *) newFriend
{
    [friend release];
    friend = [newFriend retain];
    
    [self updateUI];
}


- (void) updateUI
{
    if (self.friend == nil) return;
    
    self.name.text = self.friend.name;
    
    [self.thumbnail setImageWithURL:[NSURL resolveString:[self.friend getThumbnailUrl]]
                   placeholderImage:[UIImage imageNamed:@"default_promotion_thumbnail.png"]];
}


@end
