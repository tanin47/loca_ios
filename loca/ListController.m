//
//  ListController.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListController.h"


static ListController *sharedInstance = nil;



@implementation ListController



#pragma mark Singleton Methods
+ (ListController *) singleton {
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}



@synthesize table;
@synthesize lastUpdate;
@synthesize data;


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



- (void)dealloc {
	//DLog(@"");
	
	self.table = nil;
	self.lastUpdate = nil;
	self.data = nil;
	
    [super dealloc];
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


- (IBAction) toggleMenu: (id) sender
{
    [[HomeController singleton] toggleMenu];
}


- (void) viewWillAppear:(BOOL)animated
{
	//DLog(@"");
	[super viewWillAppear:animated];
	
	self.table.emptyLabelText = @"ไม่มีโปรโมชั่นใกล้คุณ";
	if (self.lastUpdate == nil || 
		[[NSDate date] timeIntervalSinceDate:self.lastUpdate] > (60 * 10)) {
		
		if ([[LocationManager singleton] locationKnown]) {
			[self.table startLoading];
		} else {
			[[NSNotificationCenter defaultCenter] addObserver:self
													 selector:@selector(locationInitialized:) 
														 name:@"LocationUpdated"
													   object:nil];
			
		}
	} else {
		[self.table reloadData];
		[self.table stopLoading];
	}
}


- (void) locationInitialized:(NSNotification *) notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.table startLoading];
}



// UITableViewController specifics
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	//DLog(@"");
	return 0.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	//DLog(@"");
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//DLog(@"");
	if (self.data == NULL) return 0;
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PromotionRow";
	
    PromotionRow *cell = (PromotionRow *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[PromotionRow alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	Promotion* promotion = [self.data objectAtIndex:indexPath.row];
	cell.promotion = promotion;
	
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{	
	[[HomeController singleton].navigationController pushViewController:[ViewController singleton] animated:YES];
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
	
	[ViewController singleton].promotion = ((Promotion *)[self.data objectAtIndex:indexPath.row]);
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    DLog(@"");
	[[Connector singleton] getNearPromotionAndOnDone:^(NSMutableArray* newData) {
                                                        
                                                        DLog(@"");
                                                        self.lastUpdate = [NSDate date];
                                                        self.data = newData;
                                                        
                                                        if ([self isViewLoaded] == NO) return;
                                                            
                                                        [self.table reloadData];
                                                        [self.table stopLoading];

                                                    }
                                                    AndOnFail:^{
                                                        if ([self isViewLoaded] == NO) return;
                                                        [self.table stopLoading];
                                                    }];
}


- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return self.lastUpdate;
}


@end
