//
//  UIPullToRefreshTableView.m
//  foodling2
//
//  Created by Apirom Na Nakorn on 3/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIPullToRefreshTableView.h"


@implementation UIPullToRefreshTableView


@synthesize newDelegate;
@synthesize emptyLabelText;
@synthesize emptyLabel;

- (id)initWithCoder:(NSCoder *)decoder
{
	//DLog(@"");
	if (self = [super initWithCoder:decoder]) {
		[self setup];
	}
	
	return self;
}


- (id) initWithFrame:(CGRect)aRect
{
	//DLog(@"");
	if (self = [super initWithFrame:aRect]) {
		[self setup];
	}
	
	return self;
}


- (void) setup
{
	EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
	view.delegate = self;
	[self addSubview:view];
	_refreshHeaderView = view;
	[view release];
	
	self.delegate = self;
	
}

- (void) dealloc
{
	//DLog(@"");
	
	
	self.newDelegate = nil;
	self.emptyLabelText = nil;
	self.emptyLabel = nil;
	
	self.delegate = nil;
	
	_refreshHeaderView = nil;
	
	[super dealloc];
	
	NSLog(@"%@",[NSThread callStackSymbols]);
	
	//DLog(@"end");
}


- (void) startLoading
{
	//DLog(@"");
	[self setContentOffset:CGPointMake(0, -66) animated:NO];
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:self];
	[self updateEmptyLabel];
}


- (void) stopLoading
{
	//DLog(@"");
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
	isLoading = NO;
	[self updateEmptyLabel];
}


- (void) reloadData
{
	//DLog(@"");
	[super reloadData];
	[self updateEmptyLabel];
}

- (void) updateEmptyLabel
{
	//DLog(@"");
	if (self.emptyLabel == nil) {
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.4 * (self.frame.size.height - 30), self.frame.size.width, 30)];
		self.emptyLabel = label;
		[label release];
		
		self.emptyLabel.textAlignment = UITextAlignmentCenter;
		self.emptyLabel.text = (self.emptyLabelText == nil) ? @"No Data" : self.emptyLabelText;
		self.emptyLabel.backgroundColor = [UIColor clearColor];
		
		[self addSubview:self.emptyLabel];
	}
	
	
	if ([self numberOfSections] == 1 && [self numberOfRowsInSection:0] == 0 && !isLoading) {
		self.emptyLabel.hidden = NO;
	} else {
		self.emptyLabel.hidden = YES;
	}	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void) egoRefreshTableHeaderDidTriggerRefresh: (EGORefreshTableHeaderView*) view
{
	//DLog(@"");
	isLoading = YES;
	return [newDelegate egoRefreshTableHeaderDidTriggerRefresh:view];
}


- (BOOL) egoRefreshTableHeaderDataSourceIsLoading: (EGORefreshTableHeaderView*) view
{
	//DLog(@"");
	return isLoading;
}


- (NSDate*) egoRefreshTableHeaderDataSourceLastUpdated: (EGORefreshTableHeaderView*) view
{
	//DLog(@"");
	return [newDelegate egoRefreshTableHeaderDataSourceLastUpdated:view];
}



#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	//DLog(@"");
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	//DLog(@"");
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark UITableViewDelegate Methods


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{	
	//DLog(@"");
	return [newDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//DLog(@"");
	return [newDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
}

// UITableViewController specifics
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	//DLog(@"");
    if ([newDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [newDelegate tableView:tableView heightForHeaderInSection:section];
    } else {
        return 0;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //DLog(@"");
    if ([newDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [newDelegate tableView:tableView viewForHeaderInSection:section];
    } else {
        return nil;
    }
}

@end
