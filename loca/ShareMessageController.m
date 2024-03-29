//
//  ShareMessageController.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShareMessageController.h"

static ShareMessageController *sharedInstance = nil;


@implementation ShareMessageController



#pragma mark Singleton Methods
+ (ShareMessageController *) singleton {
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}


@synthesize promotion;
@synthesize textbox;




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
    self.textbox = nil;
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
    self.textbox.text = @"";
    [self.textbox becomeFirstResponder];
}


- (IBAction) backClicked: (id) sender
{
    [self.navigationController popToViewController:[ViewController singleton] animated:YES];
}


- (IBAction) shareClicked: (id) sender
{
    [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"กำลังส่ง..."];
    
    [[Connector singleton] sharePromotion:self.promotion
                              WithMessage:self.textbox.text
                                AndOnDone: ^{
                                   [DSBezelActivityView removeViewAnimated:YES];
                                   [self.navigationController popToViewController:[ViewController singleton] animated:YES];
                               }
                                AndOnFail: ^{
                                   [DSBezelActivityView removeViewAnimated:YES];
                                   
                                   UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"ล้มเหลว"
                                                                                     message:@"ไม่สามารถส่งได้"
                                                                                    delegate:nil
                                                                           cancelButtonTitle:@"ปิด"
                                                                           otherButtonTitles:nil];
                                   [message show];
                                   [message release];
                               }];
}


@end
