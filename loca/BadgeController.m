//
//  BadgeController.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BadgeController.h"



static BadgeController *sharedInstance = nil;



@implementation BadgeController



#pragma mark Singleton Methods
+ (BadgeController *) singleton {
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}



@synthesize badge;

@synthesize name;
@synthesize restaurantName;
@synthesize badgeNumber;
@synthesize isUsed;


- (void) setBadge:(PromotionBadge *) newBadge
{
    [badge release];
    badge = [newBadge retain];
    
    [self updateUI];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [self releaseOutlets];
}

- (void) releaseOutlets
{
    self.name = nil;
    self.restaurantName = nil;
    self.badgeNumber = nil;
}


- (void) dealloc
{
    [self releaseOutlets];
    self.badge = nil;
    
    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction) backClicked: (id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) updateUI
{
    if (self.badge == nil) return;
    
    self.name.text = self.badge.promotion.name;
    self.restaurantName.text = self.badge.promotion.restaurant.name;
    self.badgeNumber.text = self.badge.number;
    
    DLog(@"%d", self.badge.isUsed);
    
    if (self.badge.isUsed) {
        self.isUsed.text = @"ใช้ไปแล้ว";
    } else {
        self.isUsed.text = @"";
    }
}

@end
