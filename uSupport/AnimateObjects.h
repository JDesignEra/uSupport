//
//  AnimateObjects.h
//  uSupport
//
//  Created by Joel.
//  Copyright © 2017 J.Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <uSupport-Swift.h>

@interface NSObject (AnimateObjects)

- (void)animateButton:(SpringButton*)name Animation:(NSString*)animation Delay:(float)delay Duration:(float)duration Damping:(float)damping Velocity:(float)velocity Force:(float)force Hide:(BOOL)hide;

- (void)animateView:(SpringView*)name Animation:(NSString*)animation Delay:(float)delay Duration:(float)duration Damping:(float)damping Velocity:(float)velocity Force:(float)force Hide:(BOOL)hide;

- (void)animateImageView:(SpringImageView*)name Animation:(NSString*)animation Delay:(float)delay Duration:(float)duration Damping:(float)damping Velocity:(float)velocity Force:(float)force Hide:(BOOL)hide;

@end
