//
//  User.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : BaseModel

+ (User *) getObjectWithId: (NSString *) userId;

@property (retain) NSString *identity;
@property (retain) NSString *facebookId;  
@property (retain) NSString *name;
@property (retain) NSString* thumbnailUrl;

- (BOOL) isGuest;

@end
