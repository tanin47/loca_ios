//
//  TransferFriendController.m
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TransferFriendController.h"
#import "FriendRow.h"

static TransferFriendController *sharedInstance = nil;


@implementation TransferFriendController



#pragma mark Singleton Methods
+ (TransferFriendController *) singleton {
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}



@synthesize searchTextbox;

@synthesize table;
@synthesize lastUpdate;
@synthesize data;

@synthesize filteredData;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.filteredData = [NSMutableArray arrayWithCapacity:100];
        self.data = [NSMutableArray arrayWithCapacity:10];
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
    self.searchTextbox = nil;
    self.table = nil;
}

- (void) dealloc
{
    [self releaseOutlets];
    
    self.lastUpdate = nil;
    self.data = nil;
    
    self.filteredData = nil;
    
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




- (void) viewWillAppear:(BOOL)animated
{
	//DLog(@"");
	[super viewWillAppear:animated];
    
    self.searchTextbox.text = @"";
	self.table.emptyLabelText = @"คุณไม่มีเพื่อน";
    
	if (self.lastUpdate == nil || 
		[[NSDate date] timeIntervalSinceDate:self.lastUpdate] > (60 * 60)) {
		[self.table startLoading];
	
	} else {
		[self filterData];
		[self.table stopLoading];
	}
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
	if (self.filteredData == NULL) return 0;
    return [self.filteredData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendRow";
	
    FriendRow *cell = (FriendRow *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[FriendRow alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	Friend* friend = [self.filteredData objectAtIndex:indexPath.row];
	cell.friend = friend;
	
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{	
    [self.navigationController pushViewController:[TransferMessageController singleton] animated:YES];
    
    [TransferMessageController singleton].fbFriend = (Friend *) [self.filteredData objectAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark UISearchBarDelegate Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    DLog(@"%@", self.searchTextbox.text);
    [self filterData]; 
    
    if ([searchText isEqualToString:@""]) {
        [self.searchTextbox resignFirstResponder];
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    DLog(@"%@", self.searchTextbox.text);
    [self filterData]; 
    
    [self.searchTextbox resignFirstResponder];
}


- (void) filterData
{
    NSString *keyword = self.searchTextbox.text;
    
    [self.filteredData removeAllObjects];
    
    for (Friend *f in self.data) {
        
        NSRange range = [f.name rangeOfString:keyword options:NSCaseInsensitiveSearch];

        if ([keyword isEqualToString:@""] || range.location != NSNotFound) {
            [self.filteredData addObject:f];
        }
    }
    
    
    [self.table reloadData];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    //DLog(@"");
    [[Connector singleton] getFriendsAndOnDone:^(NSMutableArray *friends) {
        self.lastUpdate = [NSDate date];
        self.data = friends;
        
        if ([self isViewLoaded] == NO) return;
        
        [self filterData];
        [self.table stopLoading];
    } AndOnFail:^{
        if ([self isViewLoaded] == NO) return;
        [self.table stopLoading];
    }];
}


- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return self.lastUpdate;
}


@end
