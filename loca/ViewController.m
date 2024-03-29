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
@synthesize date;

@synthesize pin;
@synthesize map;

@synthesize collectButton;
@synthesize showBadgeButton;
@synthesize transferButton;


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
    [self releaseOutlets];
}


- (void) releaseOutlets
{
    self.thumbnail = nil;
    self.name = nil;
    self.restaurantName = nil;
    self.description = nil;
    self.date = nil;
    
    self.pin = nil;
    self.map = nil;
    
    self.collectButton = nil;
    self.showBadgeButton = nil;
    self.transferButton = nil;
}

- (void) dealloc
{
    [self releaseOutlets];
    self.promotion = nil;
    
    [super dealloc];
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
                                  AndOnFail:^(NSString *errorMessage){
                                      [self updateUI];
                                      [DSBezelActivityView removeViewAnimated:YES];
                                      
                                      UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"ล้มเหลว"
                                                                                        message:errorMessage
                                                                                       delegate:nil
                                                                              cancelButtonTitle:@"ปิด"
                                                                              otherButtonTitles:nil];
                                      [message show];
                                      [message release];
                                  }];
}


- (IBAction) shareClicked: (id) sender
{
    if ([[CurrentUser singleton] isGuest] == YES) {
        
        [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"กำลังเข้าระบบ..."];
        
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            [NSThread sleepForTimeInterval:0.5];
            
            [[Connector singleton] loginOnDone:^{
                [self shareClicked:nil];
                [DSBezelActivityView removeViewAnimated:YES];
            }  AndOnFail:^{
                
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
        [self.navigationController pushViewController:[ShareMessageController singleton] animated:YES];
        
        [ShareMessageController singleton].promotion = self.promotion;
    }
}


- (IBAction) transferClicked: (id) sender
{
    if ([[CurrentUser singleton] isGuest] == YES) {
        
        [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"กำลังเข้าระบบ..."];
        
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            [NSThread sleepForTimeInterval:0.5];
            
            [[Connector singleton] loginOnDone:^{
                [self transferClicked:nil];
                [DSBezelActivityView removeViewAnimated:YES];
            }  AndOnFail:^{
                
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
        [self.navigationController pushViewController:[TransferFriendController singleton] animated:YES];
    }
}
         

- (void) updateUI
{
    if (self.promotion == nil) return;
    
    self.name.text = self.promotion.name;
    self.description.text = self.promotion.description;
    self.restaurantName.text = self.promotion.restaurant.name;
    [self.thumbnail setImageWithURL:[NSURL resolveString:self.promotion.thumbnailUrl]
                   placeholderImage:[UIImage imageNamed:@"default_promotion_thumbnail.png"]];

    self.date.text = [NSString stringWithFormat:@"%@ - %@", 
                        [self.promotion.startDate thaiDate], 
                        [self.promotion.endDate thaiDate]];
    
    DLog(@"%@", self.promotion.badge);
    if ([[CurrentUser singleton] isGuest] == YES || self.promotion.badge == nil) {
        self.collectButton.hidden = NO;
        self.showBadgeButton.hidden = YES;
    } else {
        self.collectButton.hidden = YES;
        self.showBadgeButton.hidden = NO;
    }
    
    if ([[CurrentUser singleton] isGuest] == YES 
        || self.promotion.badge == nil
        || self.promotion.badge.isUsed == YES) {
        self.transferButton.hidden = YES;
    } else {
        self.transferButton.hidden = NO;
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
