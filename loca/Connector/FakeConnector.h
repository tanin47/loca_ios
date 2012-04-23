//
//  FakeConnector.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeConnector : Connector

@property (nonatomic, retain) User *fakeCurrentUser;
@property (nonatomic, retain) NSMutableArray *restaurants;
@property (nonatomic, retain) NSMutableArray *promotions;
@property (nonatomic, retain) NSMutableArray *badges;

@end
