//
//  Connector.h
//  loca
//
//  Created by Apirom Na Nakorn on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connector : NSObject<FBRequestDelegate> {
    void (^loginCallback)(void);
    void (^loginFailCallback)(void);
    
    void (^facebookRequestDidLoad)(FBRequest *request, id result);
    void (^facebookRequestDidFail)(FBRequest *request, NSError *error);
}

+ (Connector *) singleton;
+ (void) setSingleton: (Connector *) connector;

- (void) loginOnDone:(void(^)()) callback
           AndOnFail:(void(^)()) failCallback;
- (void) processFacebookLogin;
- (void) logoutOnDone:(void(^)()) callback
            AndOnFail:(void(^)()) failCallback;

- (void) releaseFacebookCallbackBlocks;
- (void) releaseLoginCallbackBlocks;

- (void) authorizeUserWithFacebookId:(NSString *) facebookId
					 AndFacebookName:(NSString *) facebookName
					 AndThumbnailUrl:(NSString *) thumbnailUrl
					  AndAccessToken:(NSString *) accessToken
						   AndOnDone:(void(^)(User *)) callback
						   AndOnFail:(void(^)()) failCallback;

- (void) getNearPromotionAndOnDone:(void(^)(NSMutableArray *)) callback
                         AndOnFail:(void(^)()) failCallback;

- (void) collectPromotion: (Promotion *) promotion
                AndOnDone:(void(^)()) callback
                AndOnFail:(void(^)(NSString *errorMessage)) failCallback;

- (void) getPromotionBadgeAndOnDone:(void(^)(NSMutableArray *badges)) callback
                          AndOnFail:(void(^)()) failCallback;

- (void) getFriendsAndOnDone:(void(^)(NSMutableArray *friends)) callback
                   AndOnFail:(void(^)()) failCallback;

- (void) transferBadge: (PromotionBadge *) badge
          ToFacebookId: (NSString *) facebookId
           WithMessage: (NSString *) message
             AndOnDone: (void(^)()) callback
             AndOnFail: (void(^)(NSString *errorMessage)) failCallback;

- (void) sharePromotion: (Promotion *) promotion
            WithMessage: (NSString *) message
              AndOnDone: (void(^)()) callback
              AndOnFail: (void(^)()) failCallback;


@end
