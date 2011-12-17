//
//  MultiplayerNotif.m
//  RPS
//
//  Created by Martin Goffan on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGNotification.h"
#import "Constants.h"

@implementation MGNotification

@synthesize notif;
@synthesize lblNotif;
@synthesize imgView;
@synthesize actInd;
@synthesize activity;

static MGNotification *me;

+ (MGNotification *)aNotification {
    if (!me) {
        me = [MGNotification new];
    }
    return me;
}

- (void)title:(NSString *)title
     activity:(BOOL)indicator
   completion:(void (^)(BOOL f))completion
         hide:(float)delay
hideCompletion:(void (^)(BOOL f))hCompletion
 animDuration:(float)duration
{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    self.lblNotif.text = title;
    
    CGSize size = [[UIApplication sharedApplication] keyWindow].frame.size;
    
    self.lblNotif.frame = (indicator) ? CGRectMake(10, 90, 140, 60) : CGRectMake(10, 50, 140, 60) ;
    
    if (indicator) [self addSubview:self.actInd];
    else [self.actInd removeFromSuperview];
    
    [UIView animateWithDuration:duration
                     animations:^(void) {
                         self.frame = (!iPad) ? CGRectMake(size.width / 2 - 90, size.height / 2 - 120, 0, 0) : CGRectMake(size.width / 2 - 80, size.height / 2 - 220, 0, 0);
                         self.alpha = 1.0f;
                         self.transform = CGAffineTransformMakeScale((iPad) ? 1.5 : 1.2, 1.2);
    } completion:^(BOOL finished) {
        completion(YES);
        
        if (delay != kNoHide) {
            [self performSelector:@selector(hideWithCompletion:) withObject:hCompletion afterDelay:delay];
        }
    }];
}

- (void)hideWithCompletion:(void (^)(BOOL f))completion
{    
    CGSize size = [[UIApplication sharedApplication] keyWindow].frame.size;
    [UIView animateWithDuration:0.3 delay:1.3 options:UIViewAnimationCurveEaseInOut animations:^(void) {
        self.frame = (!iPad) ? CGRectMake(size.width / 2, size.height / 2, 0, 0) : CGRectMake(size.width / 2, size.height / 2, 0, 0);
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        completion(YES);
        [self removeFromSuperview];
    }];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        CGSize size = [[UIApplication sharedApplication] keyWindow].frame.size;
        self.center = CGPointMake(size.width / 2, size.height / 2);
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        UIImage *hud = [UIImage imageNamed:@"hud.png"];
        
        self.imgView = [[UIImageView alloc] initWithImage:hud];
        self.imgView.contentMode = UIViewContentModeScaleToFill;
        
        
        self.lblNotif = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 140, 60)];
        
        self.lblNotif.text = @"Default Text";
        self.lblNotif.numberOfLines = 0;
        self.lblNotif.lineBreakMode = UILineBreakModeWordWrap;
        self.lblNotif.textColor = [UIColor whiteColor];
        self.lblNotif.backgroundColor = [UIColor clearColor];
        self.lblNotif.textAlignment = UITextAlignmentCenter;
        
        
        self.actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.actInd.frame = CGRectMake(self.center.x / 4, self.center.y / 4 - 40, 80, 80);
        [self.actInd startAnimating];
        
        [self addSubview:imgView];
        [self.imgView addSubview:self.lblNotif];
        
        self.alpha = 0.0f;
        self.transform = CGAffineTransformMakeScale(0.5, 0.5);
    }
    return self;
}

- (void)dealloc {
    [lblNotif release];
    [notif release];
    [imgView release];
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
