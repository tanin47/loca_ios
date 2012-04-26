//
//  BadgeCell.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BadgeCell.h"

@implementation BadgeCell


@synthesize badge;
@synthesize thumbnail;
@synthesize name;



- (id)init {
	//DLog(@"");
    if (self = [super init]) {
		
        self.frame = CGRectMake(0, 0, 80, 80);
		
		[[NSBundle mainBundle] loadNibNamed:@"BadgeCell" owner:self options:nil];
		
        [self addSubview:self.view];
		
        self.frame = self.view.frame;
	}
	
    return self;
	
}


- (void) dealloc
{
    self.badge = nil;
    self.thumbnail = nil;
    self.name = nil;
    
    [super dealloc];
}


- (void) setBadge:(PromotionBadge *)newBadge
{
    [badge release];
    badge = [newBadge retain];
    
    [self updateUI];
}


- (void) updateUI
{
    if (self.badge == nil) return;
    
    self.name.text = self.badge.promotion.name;

    [self.thumbnail setImageWithURL:[NSURL resolveString:self.badge.promotion.thumbnailUrl]
                   placeholderImage:[UIImage imageNamed:@"default_promotion_thumbnail.png"]];
}


@end
