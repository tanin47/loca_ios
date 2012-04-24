//
//  HttpConnector.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface HttpConnector : Connector

@property (nonatomic, retain) NSMutableArray *restaurants;
@property (nonatomic, retain) NSMutableArray *promotions;
@property (nonatomic, retain) NSMutableArray *badges;

@property (nonatomic, retain) NSString *serverDomain;

- (void) attachSignature: (ASIFormDataRequest *) request;
- (NSURL *) createUrlToPath: (NSString *) path;
@end
