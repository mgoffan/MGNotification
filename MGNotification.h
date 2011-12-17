//
//  MultiplayerNotif.h
//  RPS
//
//  Created by Martin Goffan on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNoHide (-1)

@interface MGNotification : UIView

@property (nonatomic, retain) NSString *notif;
@property BOOL activity;

@property (nonatomic, retain) UILabel *lblNotif;
@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, retain) UIActivityIndicatorView *actInd;

+ (MGNotification *)aNotification;

- (void)title:(NSString *)title
     activity:(BOOL)indicator
   completion:(void (^)(BOOL finished))completion
         hide:(float)delay
hideCompletion:(void (^)(BOOL f))hCompletion
 animDuration:(float)duration;
- (void)hideWithCompletion:(void (^)(BOOL finished))completion;

@end
