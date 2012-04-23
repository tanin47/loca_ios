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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    self.badgeNumber.text = self.badge.badgeNumber;
}

@end
