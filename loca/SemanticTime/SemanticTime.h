//
//  SemanticTime.h
//  foodling2
//
//  Created by Apirom Na Nakorn on 3/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSDate (SemanticTime)

- (NSString *) semanticIntervalToDate: (NSDate *) date;
- (NSString *) semanticIntervalToNow;

- (NSString *) thaiDate;

@end
