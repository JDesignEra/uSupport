//
//  UIViewController+LocationView.h
//  uSupport
//
//  Created by Joel.
//  Copyright © 2017 J.Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <uSupport-Swift.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "DBManager.h"

@interface LocationView : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

//Instance of DBManager
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrEkitInfo;

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet SpringButton *btnCurrentLocation;
@property (weak, nonatomic) IBOutlet SpringButton *btnBack;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segNearAll;

@property (weak, nonatomic) IBOutlet SpringView *topViewNear;
@property (weak, nonatomic) IBOutlet UILabel *lblDist;
@property (weak, nonatomic) IBOutlet UIImageView *imgDirect;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalDist;

@property (weak, nonatomic) IBOutlet SpringView *topViewAll;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPin;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPinTxt;

@property (nonatomic) int segueID;

- (IBAction)selNearAll:(UISegmentedControl *)sender;
- (IBAction)btnCurrentLocation_Tap:(UIButton *)sender;
- (IBAction)btnBack_Tap:(UIButton *)sender;

@end
