//
//  NSObject+uSupport_LocationSegue.m
//  uSupport
//
//  Created by Joel on 12/2/17.
//  Copyright © 2017 jdesign. All rights reserved.
//

#import "uSupport_LocationSegue.h"

@implementation uSupport_LocationSegue

- (void)perform {
    UIViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    
    //Add destination view as subview temporarily
    [source.view addSubview:destination.view];
    
    //Tranformation start
    destination.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    
    
    //Store original centre point of destination view
    CGPoint ogCenter = source.view.center;
    //Set center to start point button
    destination.view.center = self.originatingPoint;
    
    
     [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        destination.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        destination.view.center = ogCenter;
    }completion:^(BOOL finished) {
        [destination.view removeFromSuperview];
        [source presentViewController:destination animated:NO completion:NULL];
    }];
}

@end
