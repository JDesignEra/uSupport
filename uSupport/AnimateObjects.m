//
//  AnimateObjects.m
//  uSupport
//
//  Created by Joel.
//  Copyright © 2017 J.Design. All rights reserved.
//

#import "AnimateObjects.h"

@implementation NSObject (AnimateObjects)

- (void)animateButton:(SpringButton*)name Animation:(NSString*)animation Delay:(float)delay Duration:(float)duration Damping:(float)damping Velocity:(float)velocity Force:(float)force Hide:(BOOL)hide {
    
    if (name.hidden == YES) {
        name.hidden = NO;
    }
    
    name.animation = animation;
    name.delay = delay;
    name.duration = duration;
    name.damping = damping;
    name.velocity = velocity;
    name.force = force;
    name.autohide = hide;
    [name animate];
}

- (void)animateView:(SpringView*)name Animation:(NSString*)animation Delay:(float)delay Duration:(float)duration Damping:(float)damping Velocity:(float)velocity Force:(float)force Hide:(BOOL)hide {
    
    if (name.hidden == YES) {
        name.hidden = NO;
    }
    
    name.animation = animation;
    name.delay = delay;
    name.duration = duration;
    name.damping = damping;
    name.velocity = velocity;
    name.force = force;
    name.autohide = hide;
    [name animate];
}

- (void)animateImageView:(SpringImageView*)name Animation:(NSString*)animation Delay:(float)delay Duration:(float)duration Damping:(float)damping Velocity:(float)velocity Force:(float)force Hide:(BOOL)hide {
    
    if (name.hidden == YES) {
        name.hidden = NO;
    }
    
    name.animation = animation;
    name.delay = delay;
    name.duration = duration;
    name.damping = damping;
    name.velocity = velocity;
    name.force = force;
    name.autohide = hide;
    [name animate];
}

@end
