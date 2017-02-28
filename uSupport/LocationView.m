//
//  UIViewController+LocationView.m
//  uSupport
//
//  Created by Joel.
//  Copyright © 2017 J.Design. All rights reserved.
//

#import "LocationView.h"
#import "AnimateObjects.h"
#import "CustomAnnotation.h"

@interface LocationView () {
    NSString *type;
    float latitude;
    float longtitude;
    
    int selNearAllVal;
}

@end

@implementation LocationView

@synthesize segueID;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_map setDelegate:self];
    
    //Database Related
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"uSupport.db"];
    
    //Location Related
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = 10; //Invoke didUpdateLocation every 10 meters
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    _map.showsScale = NO;
    
    [locationManager requestAlwaysAuthorization];
    [locationManager requestWhenInUseAuthorization];
    
    //Add border to topViewNear
    self.topViewNear.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:66.0/255.0 blue:72.0/255.0 alpha:0.8].CGColor;
    self.topViewNear.layer.borderWidth = 2;
    
    //Add border to topViewAll
    self.topViewAll.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:66.0/255.0 blue:72.0/255.0 alpha:0.8].CGColor;
    self.topViewAll.layer.borderWidth = 2;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    //Animate objects
    [self animateButton:_btnCurrentLocation Animation:@"pop" Delay:1 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
    [self animateButton:_btnBack Animation:@"pop" Delay:1 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
        
    if (segueID == 3) {
        self.segNearAll.selectedSegmentIndex = 1;
        [self.segNearAll setEnabled:NO forSegmentAtIndex:0];
        _topViewNear.hidden = YES;
        [self animateView:_topViewAll Animation:@"fadeInDown" Delay:0.7 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
    }
    
    else {
        [self animateView:_topViewNear Animation:@"fadeInDown" Delay:0.7 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
    }
    
    //Start updating location and set tracking mode to Follow With Heading
    [self.map setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:NO];
    [locationManager startUpdatingLocation];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    switch (selNearAllVal) {
        case 0: //Near
            [self nearestObj];
            break;
            
        case 1: //All
            [self allObj];
            break;
            
        default:
            break;
    }
}

- (IBAction)btnCurrentLocation_Tap:(UIButton *)sender {
    [self animateButton:_btnCurrentLocation Animation:@"pop" Delay:0 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
    [self.map setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:NO];
}

- (IBAction)btnBack_Tap:(UIButton *)sender {
    [self animateButton:_btnBack Animation:@"pop" Delay:0 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
}

- (IBAction)selNearAll:(UISegmentedControl *)sender {
    selNearAllVal = (int)sender.selectedSegmentIndex;
    
    switch (selNearAllVal) {
        case 0: //Near
            [self animateView:_topViewAll Animation:@"zoomOut" Delay:0 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
            [self animateView:_topViewNear Animation:@"fadeInDown" Delay:0.5 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
            [self nearestObj];
            break;
            
        case 1: //All
            [self animateView:_topViewNear Animation:@"zoomOut" Delay:0 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:YES];
            [self animateView:_topViewAll Animation:@"fadeInDown" Delay:0.5 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:YES];
            [self allObj];
            break;
            
        default:
            break;
    }
}

- (void)allObj {
    NSString *query;
    CustomAnnotation *annotation;
    
    switch (segueID) {
        case 1:
            query = @"SELECT * FROM Ekit WHERE type = 'aed'";
            [self removeAllMapObj];
            
            //Clear array if it's not empty
            if (self.arrEkitInfo != nil) {
                self.arrEkitInfo = nil;
            }
            
            self.arrEkitInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
            
            for (int i = 0; i < [_arrEkitInfo count]; i++) {
                latitude = [[[_arrEkitInfo objectAtIndex:i] objectAtIndex:2] floatValue];
                longtitude = [[[_arrEkitInfo objectAtIndex:i] objectAtIndex:3] floatValue];
                
                annotation = [[CustomAnnotation alloc] initWithLocation:CLLocationCoordinate2DMake(latitude, longtitude)];
                annotation.image = [UIImage imageNamed:@"Pin-AED"];
                [self.map addAnnotation:annotation];
                
                _lblTotalPin.text = @(i + 1).stringValue;
                _lblTotalPinTxt.text = @"AEDs";
            }
            break;
            
        case 2:
            query = @"SELECT * FROM Ekit WHERE type = 'fe'";
            [self removeAllMapObj];
            
            //Clear array if it's not empty
            if (self.arrEkitInfo != nil) {
                self.arrEkitInfo = nil;
            }
            
            self.arrEkitInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
            
            for (int i = 0; i < [_arrEkitInfo count]; i++) {
                //Store Database array into indivdual variables
                latitude = [[[_arrEkitInfo objectAtIndex:i] objectAtIndex:2] floatValue];
                longtitude = [[[_arrEkitInfo objectAtIndex:i] objectAtIndex:3] floatValue];
                
                annotation = [[CustomAnnotation alloc] initWithLocation:CLLocationCoordinate2DMake(latitude, longtitude)];
                annotation.image = [UIImage imageNamed:@"Pin-FE"];
                [self.map addAnnotation:annotation];
                
                _lblTotalPin.text = @(i + 1).stringValue;
                _lblTotalPinTxt.text = @"Fire Extinguishers";
            }
            break;
            
        case 3:
            query = @"SELECT * FROM Ekit";
            [self removeAllMapObj];
            
            //Clear array if it's not empty
            if (self.arrEkitInfo != nil) {
                self.arrEkitInfo = nil;
            }
            
            self.arrEkitInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
            
            for (int i = 0; i < [_arrEkitInfo count]; i++) {
                type = [[_arrEkitInfo objectAtIndex:i] objectAtIndex:1];
                latitude = [[[_arrEkitInfo objectAtIndex:i] objectAtIndex:2] floatValue];
                longtitude = [[[_arrEkitInfo objectAtIndex:i] objectAtIndex:3] floatValue];
                
                annotation = [[CustomAnnotation alloc] initWithLocation:CLLocationCoordinate2DMake(latitude, longtitude)];
                
                if ([type  isEqual: @"aed"]) {
                    annotation.image = [UIImage imageNamed:@"Pin-AED"];
                }
                
                if ([type  isEqual: @"fe"]) {
                    annotation.image = [UIImage imageNamed:@"Pin-FE"];
                }
                
                [self.map addAnnotation:annotation];
                
                _lblTotalPin.text = @(i + 1).stringValue;
                _lblTotalPinTxt.text = @"AED & Fire Extinguishers";
            }
            break;
            
        default:
            break;
    }
}

- (void)nearestObj {
    NSString *query;
    CustomAnnotation *annotation;
    
    //segueID 1 = AED, 2 = Fire Extinguisher, 3 = All
    switch (segueID) {
        case 1: {
            query = @"SELECT * FROM Ekit WHERE type = 'aed'";
            [self removeAllMapObj];
            
            //Clear array if it's not empty
            if (self.arrEkitInfo != nil) {
                self.arrEkitInfo = nil;
            }
            
            self.arrEkitInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
            
            CLLocation *userLocation = self.map.userLocation.location;
            int closest = -1;
            CLLocationDistance closestDistance = FLT_MAX;
            for (int i = 0; i < [self.arrEkitInfo count]; i++)
            {
                CLLocation *location = [[CLLocation alloc] initWithLatitude:[[[_arrEkitInfo objectAtIndex:i] objectAtIndex:2] floatValue] longitude:[[[_arrEkitInfo objectAtIndex:i] objectAtIndex:3] floatValue]];
                CLLocationDistance distance = [location distanceFromLocation:userLocation];
                
                if (distance < closestDistance)
                {
                    closest = i;
                    closestDistance = distance;
                }
            }
            
            latitude = [[[_arrEkitInfo objectAtIndex:closest] objectAtIndex:2] floatValue];
            longtitude = [[[_arrEkitInfo objectAtIndex:closest] objectAtIndex:3] floatValue];
            
            //Set Custom Annotation
            annotation = [[CustomAnnotation alloc] initWithLocation:CLLocationCoordinate2DMake(latitude, longtitude)];
            annotation.image = [UIImage imageNamed:@"Pin-AED"];
            [self.map addAnnotation:annotation];
            
            [self drawRoute];
        }
        break;
            
        case 2: {
            query = @"SELECT * FROM Ekit WHERE type = 'fe'";
            [self removeAllMapObj];
            
            //Clear array if it's not empty
            if (self.arrEkitInfo != nil) {
                self.arrEkitInfo = nil;
            }
            
            self.arrEkitInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
            
            CLLocation *userLocation = self.map.userLocation.location;
            int closest = -1;
            CLLocationDistance closestDistance = FLT_MAX;
            for (int i = 0; i < [self.arrEkitInfo count]; i++)
            {
                CLLocation *location = [[CLLocation alloc] initWithLatitude:[[[_arrEkitInfo objectAtIndex:i] objectAtIndex:2] floatValue] longitude:[[[_arrEkitInfo objectAtIndex:i] objectAtIndex:3] floatValue]];
                CLLocationDistance distance = [location distanceFromLocation:userLocation];
                
                if (distance < closestDistance)
                {
                    closest = i;
                    closestDistance = distance;
                }
            }
            
            latitude = [[[_arrEkitInfo objectAtIndex:closest] objectAtIndex:2] floatValue];
            longtitude = [[[_arrEkitInfo objectAtIndex:closest] objectAtIndex:3] floatValue];
            
            //Set Custom Annotation
            annotation = [[CustomAnnotation alloc] initWithLocation:CLLocationCoordinate2DMake(latitude, longtitude)];
            annotation.image = [UIImage imageNamed:@"Pin-FE"];
            [self.map addAnnotation:annotation];
            
            [self drawRoute];
        }
        break;
            
        case 3:
            [self allObj];
            break;
            
        default:
            break;
    }
}

- (void)drawRoute {
    MKMapItem *srcMapItem = [MKMapItem mapItemForCurrentLocation];
    [srcMapItem setName:@"source"];
    
    MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(latitude, longtitude) addressDictionary:nil ];
    MKMapItem *destMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
    [destMapItem setName:@"dest"];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:srcMapItem];
    [request setDestination:destMapItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    
    MKDirections *direction = [[MKDirections alloc]initWithRequest:request];
    
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"response = %@ \n eror %@",response, error);
        }
        
        NSArray *arrRoutes = [response routes];
        [arrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MKRoute *route = obj;
            
                MKPolyline *line = [route polyline];
                [self.map removeOverlays:_map.overlays];
                [self.map addOverlay:line];
            
                _lblTotalDist.text = [NSString stringWithFormat:@"%.0fM", route.distance];
            
                NSArray *steps = [route steps];
                [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if (idx == 1 || idx == 0) {
                        _lblDist.text = [NSString stringWithFormat:@"%.0fM", [obj distance]];
                        
                        if ([[obj instructions] containsString:@"left"]) {
                            _imgDirect.image = [UIImage imageNamed:@"turn-Left"];
                        }
                        
                        if ([[obj instructions] containsString:@"right"]) {
                            _imgDirect.image = [UIImage imageNamed:@"turn-Right"];
                        }
                    }
                }];
        }];
    }];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor colorWithRed:191.0/255.0 green:58.0/255.0 blue:69.0/255.0 alpha:1];
    renderer.lineWidth = 4.0;
    return renderer;
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKAnnotationView *annView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CA"];
    
    if(annView == nil) {
        annView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CA"];
    }
    
    annView.image = ((CustomAnnotation *) annotation).image;
    annView.centerOffset = CGPointMake(0, (-32 / 2));
    
    return annView;
}

- (void)removeAllMapObj {
    [self.map removeAnnotations:_map.annotations];
    [self.map removeOverlays:_map.overlays];
}

@end
