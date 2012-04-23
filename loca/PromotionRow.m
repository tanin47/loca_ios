//
//  PromotionRow.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PromotionRow.h"

@implementation PromotionRow


@synthesize cell;
@synthesize name;
@synthesize restaurantName;
@synthesize quota;
@synthesize thumbnail;

@synthesize promotion;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.frame = CGRectMake(0, 0, 320, 88);
        
		[[NSBundle mainBundle] loadNibNamed:@"PromotionRow" owner:self options:nil];
		
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


- (void) setPromotion:(Promotion *) newPromotion
{
    [promotion release];
    promotion = [newPromotion retain];
    
    [self updateUI];
}


- (void) updateUI
{
    if (self.promotion == nil) return;
    
    self.name.text = self.promotion.name;
    self.restaurantName.text = self.promotion.restaurant.name;
    self.quota.text = [NSString stringWithFormat:@"เก็บไปแล้ว %d จากทั้งหมด %d", self.promotion.collect, self.promotion.total];
    
    [self.thumbnail setImageWithURL:[NSURL resolveString:self.promotion.thumbnailUrl]
                   placeholderImage:[UIImage imageNamed:@"default_promotion_thumbnail.png"]];
}


@end
