//
//  ShareMessageController.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareMessageController : UIViewController

@property (nonatomic, retain) Promotion *promotion;
@property (nonatomic, retain) IBOutlet UITextView *textbox;

- (IBAction) backClicked: (id) sender;
- (IBAction) shareClicked: (id) sender;

+ (ShareMessageController *) singleton;

@end
