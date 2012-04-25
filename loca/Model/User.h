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

+ (User *) getObjectWithId: (NSString *) identity
                 AndSetWithJson: (NSMutableDictionary *) json;

@property (nonatomic, retain) NSString *facebookId;  
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString* thumbnailUrl;
@property (nonatomic) int point;

- (BOOL) isGuest;
- (void) setPropertiesFromJson: (NSMutableDictionary *) json;

@end
