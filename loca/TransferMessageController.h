//
//  TransferMessageController.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferMessageController : UIViewController

@property (nonatomic, retain) Friend *fbFriend;
@property (nonatomic, retain) IBOutlet UITextView *textbox;

- (void) releaseOutlets;

- (IBAction) backClicked: (id) sender;
- (IBAction) transferClicked: (id) sender;

+ (TransferMessageController *) singleton;

@end
