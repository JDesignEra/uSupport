//
//  aedAnnotation.h
//  uSupport
//
//  Created by Joel.
//  Copyright © 2017 J.Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic) UIImage *image;
-(id) initWithLocation:(CLLocationCoordinate2D) coord;

@end
