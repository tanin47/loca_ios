//
//  MenuController.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuController.h"
#import <objc/runtime.h>

static MenuController *sharedInstance = nil;

@implementation MenuController


#pragma mark Singleton Methods
+ (MenuController *) singleton {
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}


@synthesize nameLabel;
@synthesize myLocaButton;
@synthesize loginButton;
@synthesize logoutButton;
@synthesize switchConnectorButton;


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
    self.nameLabel = nil;
    self.myLocaButton = nil;
    self.loginButton = nil;
    self.logoutButton = nil;
    self.switchConnectorButton = nil;
}

- (void) dealloc
{
    [self releaseOutlets];
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


- (IBAction) loginClicked: (id) sender
{
    [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"กำลังเข้าระบบ..."];
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        [NSThread sleepForTimeInterval:0.5];
    
        [[Connector singleton] loginOnDone:^{
                                                [self updateUI];
                                                [DSBezelActivityView removeViewAnimated:YES];
                                            }
                                 AndOnFail:^{
                                                [self updateUI];
                                                [DSBezelActivityView removeViewAnimated:YES];
                                 
                                                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"ล้มเหลว"
                                                                                   message:@"ไม่สามารถติดต่อกับ Facebook ได้ กรุณาลองใหม่ในอีก 2-3 นาที ถ้ายังไม่ได้กรุณาติดต่อเรา"
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"ปิด"
                                                                         otherButtonTitles:nil];
                                                [message show];
                                                [message release];
                                            }];
    });
    
}


- (IBAction) logoutClicked: (id) sender
{
    [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"ออกจากระบบ..."];
    [[Connector singleton] logoutOnDone:^{
                                    [self updateUI];
                                    [DSBezelActivityView removeViewAnimated:YES];
                                }
                              AndOnFail:^{
                                  
                                  [self updateUI];
                                  [DSBezelActivityView removeViewAnimated:YES];
                                  
                                  UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"ล้มเหลว"
                                                                                    message:@"ไม่สามารถออกจากระบบได้"
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"ปิด"
                                                                          otherButtonTitles:nil];
                                  [message show];
                                  [message release];
                              }];
}


- (IBAction) listClicked: (id) sender
{
    [[HomeController singleton] switchPage:[ListController singleton]];
}


- (IBAction) myLocaClicked: (id) sender
{
    [[HomeController singleton] switchPage:[MyLocaController singleton]];
}


- (IBAction) switchConnectorClicked: (id) sender
{
    if ([[Connector singleton] isKindOfClass:[FakeConnector class]]) {
		[Connector setSingleton:[[HttpConnector alloc] init]];
	} else {
        [Connector setSingleton:[[FakeConnector alloc] init]];
    }
    
    [self updateUI];
}


- (void) updateUI
{
    if ([[CurrentUser singleton] isGuest] == YES) {
        
        self.logoutButton.hidden = YES;
        self.loginButton.hidden = NO;
        self.nameLabel.text = @"Menu";
        
        self.myLocaButton.hidden = YES;
        
    } else {
        
        self.logoutButton.hidden = NO;
        self.loginButton.hidden = YES;
        self.nameLabel.text = [NSString stringWithFormat:@"%@ [%d]", [CurrentUser singleton].name, [CurrentUser singleton].point];
        
        self.myLocaButton.hidden = NO;
        
    }
    
    [self.switchConnectorButton setTitle:[NSString stringWithFormat:@"%s", class_getName([[Connector singleton] class])] forState:UIControlStateNormal];
}

@end
