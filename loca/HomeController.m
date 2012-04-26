//
//  HomeController.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeController.h"

static HomeController *sharedInstance = nil;


@implementation HomeController


@synthesize menuController;
@synthesize mainController;
@synthesize frameController;


#pragma mark Singleton Methods
+ (HomeController *) singleton {
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
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

	self.menuController = [MenuController singleton];
    self.frameController = [HomeFrameController singleton];
	
	
	[self.view addSubview:self.menuController.view];
	[self.view addSubview:[HomeFrameController singleton].view];
    
    self.frameController.view.frame = CGRectMake(0, 0, 320, 460);
    
	self.menuController.view.frame = CGRectMake(-menuController.view.frame.size.width, 
                                                  menuController.view.frame.origin.y, 
                                                  menuController.view.frame.size.width, 
                                                  menuController.view.frame.size.height);
    
	self.mainController = [ListController singleton];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    [self releaseOutlets];
}


- (void) releaseOutlets
{
    self.menuController = nil;
    self.mainController = nil;
    self.frameController = nil;
}

- (void) dealloc
{
    [self releaseOutlets];
    [super dealloc];
}



- (void)viewWillAppear:(BOOL)animated {
	//DLog(@"");
	[super viewWillAppear:animated];
	[self.mainController viewWillAppear:animated];
	[self.frameController viewWillAppear:animated];
	[self.menuController viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	//DLog(@"");
	[super viewWillDisappear:animated];
	[self.mainController viewWillDisappear:animated];
    [self.frameController viewWillDisappear:animated];
	[self.menuController viewWillDisappear:animated];
}


- (void) toggleMenu {
	//DLog(@"");
	if(self.menuController.view.frame.origin.x == -320) {
		[self.menuController viewWillAppear:YES];
	} else {
		[self.menuController viewWillDisappear:YES];
	}
	
	[UIView animateWithDuration: 0.2
						  delay: 0.0
						options: UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 
						 CGRect filterFrame = self.menuController.view.frame;
						 CGRect mainFrame = [HomeFrameController singleton].view.frame;
						 
						 if(filterFrame.origin.x != -320) {
							 mainFrame.origin.x = 0;
							 filterFrame.origin.x = -320;
						 }
						 else
						 {
							 mainFrame.origin.x = 320 - 75;
							 filterFrame.origin.x = -75;
						 }
						 
						 self.menuController.view.frame = filterFrame;
						 [HomeFrameController singleton].view.frame = mainFrame;
					 }
					 completion:^(BOOL finished){
						 if(self.menuController.view.frame.origin.x != -320) {
							 [self.menuController viewDidDisappear:YES];
						 } else {
							 [self.menuController viewDidAppear:YES];
						 }
                         
					 }];
	
}




- (void) setMainController:(UIViewController *) controller
{
	DLog(@"");
	if (mainController != nil) {
		[mainController.view removeFromSuperview];
		[mainController release];
	}
	
	mainController = [controller retain];
	
	//if (mainController != nil) {
    [frameController.view addSubview:mainController.view];
    [frameController.view sendSubviewToBack:mainController.view];
	//}
	
	mainController.view.frame = CGRectMake(0, 0, 320, 460);
}



- (void) switchPage:(UIViewController *) controller
{
	//DLog(@"");
	if (controller == mainController) {
		[self toggleMenu];
		return;
	}
	
	[UIView animateWithDuration: 0.2
						  delay: 0.0
						options: UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 
						 CGRect filterFrame = self.menuController.view.frame;
						 CGRect mainFrame = [HomeFrameController singleton].view.frame;
						 
						 mainFrame.origin.x = 320;
						 filterFrame.origin.x = 0;
						 
						 self.menuController.view.frame = filterFrame;
						 [HomeFrameController singleton].view.frame = mainFrame;
					 }
					 completion:^(BOOL finished){
						 
						 dispatch_async( dispatch_get_main_queue(), ^{
							 UIViewController *previousController = self.mainController;
                             
							 [previousController viewWillDisappear:YES];
                             
							 self.mainController = controller;
                             
							 [self.mainController viewWillAppear:YES];
							 [HomeFrameController singleton].view.frame = CGRectMake(320, 0, [HomeFrameController singleton].view.frame.size.width, [HomeFrameController singleton].view.frame.size.height);
                             
							 [UIView animateWithDuration: 0.25
												   delay: 0.05
												 options: UIViewAnimationOptionCurveEaseIn
											  animations:^{
                                                  
												  CGRect filterFrame = self.menuController.view.frame;
												  CGRect mainFrame = [HomeFrameController singleton].view.frame;
                                                  
												  mainFrame.origin.x = 0;
												  filterFrame.origin.x = -320;
                                                  
												  self.menuController.view.frame = filterFrame;
												  [HomeFrameController singleton].view.frame = mainFrame;
											  }
											  completion:^(BOOL finished){
												  dispatch_async( dispatch_get_main_queue(), ^{
													  [previousController viewDidDisappear:YES];
													  [self.mainController viewDidAppear:YES];
												  });
											  }];
						 });
					 }];		
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
