//
//  TransferMessageController.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TransferMessageController.h"


static TransferMessageController *sharedInstance = nil;


@implementation TransferMessageController



#pragma mark Singleton Methods
+ (TransferMessageController *) singleton {
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}


@synthesize fbFriend;
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
    self.textbox.text = @"";
    [self.textbox becomeFirstResponder];
}


- (IBAction) backClicked: (id) sender
{
    [self.navigationController popToViewController:[ViewController singleton] animated:YES];
}


- (IBAction) transferClicked: (id) sender
{
    [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"กำลังส่ง..."];
    
    [[Connector singleton] transferBadge:[ViewController singleton].promotion.badge
                            ToFacebookId: fbFriend.facebookId
                             WithMessage:self.textbox.text
                               AndOnDone: ^{
                                   [DSBezelActivityView removeViewAnimated:YES];
                                   [self.navigationController popToViewController:[ViewController singleton] animated:YES];
                                   
                                   [[MyLocaController singleton].table startLoading];
                               }
                               AndOnFail: ^(NSString *errorMessage) {
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

@end
