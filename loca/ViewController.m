//
//  ViewController.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


static ViewController *sharedInstance = nil;



@implementation ViewController



#pragma mark Singleton Methods
+ (ViewController *) singleton {
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}





@synthesize promotion;

@synthesize thumbnail;
@synthesize name;
@synthesize restaurantName;
@synthesize description;

@synthesize pin;
@synthesize map;

@synthesize collectButton;
@synthesize showBadgeButton;


- (void) setPromotion: (Promotion *) newPro
{
    [promotion release];
    promotion = [newPro retain];
    
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


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}


- (IBAction) backClicked: (id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction) collectClicked: (id) sender
{

    if ([[CurrentUser singleton] isGuest] == YES) {
        
        [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"กำลังเข้าระบบ..."];
        
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            [NSThread sleepForTimeInterval:0.5];
    
            [[Connector singleton] loginOnDone:^{
                                                    [self collectPromotion];
                                                }
                                     AndOnFail:^{
                                                    [self updateUI];
                                                    [DSBezelActivityView removeViewAnimated:YES];
                                     
                                                    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"ล้มเหลว"
                                                                                       message:@"ไม่สามารถเข้าระบบได้"
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"ปิด"
                                                                             otherButtonTitles:nil];
                                                    [message show];
                                                    [message release];
                                                }];
        });
        
    } else {
        [self collectPromotion];                
    }
}


- (IBAction) showBadgeClicked: (id) sender
{
    [self.navigationController pushViewController:[BadgeController singleton] animated:YES];
    [BadgeController singleton].badge = self.promotion.badge;
}

         
- (void) collectPromotion
{
    [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"กำลังบันทึกโปรโมชั่น..."];
    
    [[Connector singleton] collectPromotion:self.promotion
                                  AndOnDone:^{
                                      [self updateUI];
                                      [DSBezelActivityView removeViewAnimated:YES];
                                  }
                                  AndOnFail:^{
                                      [self updateUI];
                                      [DSBezelActivityView removeViewAnimated:YES];
                                      
                                      UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"ล้มเหลว"
                                                                                        message:@"ไม่สามารถบันทึกได้"
                                                                                       delegate:nil
                                                                              cancelButtonTitle:@"ปิด"
                                                                              otherButtonTitles:nil];
                                      [message show];
                                      [message release];
                                  }];
}


- (IBAction) shareClicked: (id) sender
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   FACEBOOK_APP_ID, @"app_id",
                                   @"http://www.google.com",  @"link",
                                   self.promotion.thumbnailUrl, @"picture",
                                   self.promotion.name, @"name",
                                   @"Loca", @"caption",
                                   self.promotion.description, @"description",
                                   nil];
    
    [delegate.facebook dialog:@"feed"
                    andParams:params
                  andDelegate:self];
}


- (IBAction) transferClicked: (id) sender
{
    
}
         

- (void) updateUI
{
    if (self.promotion == nil) return;
    
    self.name.text = self.promotion.name;
    self.description.text = self.promotion.description;
    self.restaurantName.text = self.promotion.restaurant.name;
    [self.thumbnail setImageWithURL:[NSURL resolveString:self.promotion.thumbnailUrl]
                   placeholderImage:[UIImage imageNamed:@"default_promotion_thumbnail.png"]];
    
    
    if ([[CurrentUser singleton] isGuest] == YES || self.promotion.badge == nil) {
        self.collectButton.hidden = NO;
        self.showBadgeButton.hidden = YES;
    } else {
        self.collectButton.hidden = YES;
        self.showBadgeButton.hidden = NO;
    }
    
    
	if (self.pin == nil) {
		
		RestaurantPin *tmpPin = [[RestaurantPin alloc] initWithCoordinate:CLLocationCoordinate2DMake(self.promotion.restaurant.latitude, self.promotion.restaurant.longitude)];
		self.pin = tmpPin;
		[tmpPin release];
		
		[self.map addAnnotation:self.pin];
	}
	
	self.pin.coordinate = CLLocationCoordinate2DMake(self.promotion.restaurant.latitude, self.promotion.restaurant.longitude);
	
	MKCoordinateRegion region;
	region.center = self.pin.coordinate;
	
	MKCoordinateSpan span; 
    span.latitudeDelta  = 0.004;
    span.longitudeDelta = 0.004; 
    region.span = span;
	
	self.map.showsUserLocation = YES;
	
    [self.map setRegion:region animated:YES];
}

@end
