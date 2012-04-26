//
//  MyLocaController.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyLocaController.h"
#import "BadgeCell.h"


static MyLocaController *sharedInstance = nil;



@implementation MyLocaController


@synthesize table;
@synthesize data;
@synthesize lastUpdate;



#pragma mark Singleton Methods
+ (MyLocaController *) singleton {
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self releaseOutlets];
}


- (void) releaseOutlets
{
    self.table = nil;
}


- (void) dealloc
{
    [self releaseOutlets];
    self.data = nil;
    self.lastUpdate = nil;
    
    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction) toggleMenu: (id) sender
{
    [[HomeController singleton] toggleMenu];
}





- (void)viewWillAppear:(BOOL)animated {
	DLog(@"");
	[super viewWillAppear:animated];
	
	self.table.emptyLabelText = @"คุณไม่ได้เก็บ Promotion ใด ๆ";
	
	if (self.lastUpdate == nil || 
		[[NSDate date] timeIntervalSinceDate:self.lastUpdate] > (60 * 10)) {
		[self.table startLoading];
	} else {
		[self.table reloadData];
		[self.table stopLoading];
	}
}



- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
	//DLog(@"");
	return 106.0;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
	//DLog(@"");
	return 130.0;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
	//DLog(@"");
	return 3;
}

- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
	//DLog(@"");
	return (self.data == nil) ? 0 : [self.data count];
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
	//DLog(@"");
	BadgeCell *cell = (BadgeCell *)[grid dequeueReusableCell];
	
	if (cell == nil) {
		cell = [[[BadgeCell alloc] init] autorelease];
	}
	
	cell.badge = (PromotionBadge *)[self.data objectAtIndex:(rowIndex * 3 + columnIndex)];
	
	return cell;
	
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
	//DLog(@"");
	[[HomeController singleton].navigationController pushViewController:[ViewController singleton] animated:YES];
	[ViewController singleton].promotion = ((PromotionBadge *)[self.data objectAtIndex:(rowIndex * 3 + columnIndex)]).promotion;
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void) egoRefreshTableHeaderDidTriggerRefresh: (EGORefreshTableHeaderView*) view
{
    DLog(@"");
	[[Connector singleton] getPromotionBadgeAndOnDone:^(NSMutableArray *badges) {
                                                        
                                                        DLog(@"");
                                                        self.lastUpdate = [NSDate date];
                                                        self.data = badges;
                                                        
                                                        if ([self isViewLoaded] == NO) return;
                                                        
                                                        [self.table reloadData];
                                                        [self.table stopLoading];
                                                        
                                                    }
                                            AndOnFail:^{
                                                        if ([self isViewLoaded] == NO) return;
                                                        [self.table stopLoading];
                                                    }];
}


- (NSDate*) egoRefreshTableHeaderDataSourceLastUpdated: (EGORefreshTableHeaderView*) view
{
	//DLog(@"");
	return self.lastUpdate;
}

@end
