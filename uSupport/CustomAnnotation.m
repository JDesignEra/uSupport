//
//  aedAnnotation.m
//  uSupport
//
//  Created by Joel on 20/2/17.
//  Copyright © 2017 jdesign. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

@synthesize coordinate, image;

-(id) initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    
    if (self) {
        coordinate = coord;
    }
    return self;
}

@end
