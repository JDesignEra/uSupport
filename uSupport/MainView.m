//
//  MainView.m
//  uSupport
//
//  Created by Joel.
//  Copyright © 2017 J.Design. All rights reserved.
//

#import "MainView.h"
#import "AnimateObjects.h"
#import "MainView.h"
#import "LocationView.h"

@interface MainView ()

@end

@implementation MainView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //mainView_SwipeUp
    UISwipeGestureRecognizer *mainView_SwipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(mainView_Swipe:)];
    mainView_SwipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [_mainView addGestureRecognizer:mainView_SwipeUp];
    
    //mainView_SwipeDown
    UISwipeGestureRecognizer *mainView_SwipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(mainView_Swipe:)];
    mainView_SwipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [_mainView addGestureRecognizer:mainView_SwipeDown];
    
    //mainView_SwipeLeft
    UISwipeGestureRecognizer *mainView_SwipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(mainView_Swipe:)];
    mainView_SwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_mainView addGestureRecognizer:mainView_SwipeLeft];
    
    //mainView_SwipeRight
    UISwipeGestureRecognizer *mainView_SwipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(mainView_Swipe:)];
    mainView_SwipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_mainView addGestureRecognizer:mainView_SwipeRight];
    
    [self animateButton:_btnAED Animation:@"slideLeft" Delay:0.7 Duration:1 Damping:0.9 Velocity:0.7 Force:1 Hide:NO];
    [self animateButton:_btnFE Animation:@"slideRight" Delay:0.7 Duration:1 Damping:0.9 Velocity:0.7 Force:1 Hide:NO];
    [self animateButton:_btnEall Animation:@"zoomIn" Delay:0.5 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
    [self animateButton:_btnECall Animation:@"slideUp" Delay:0.9 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
    [self animateImageView:_logo Animation:@"zoomIn" Delay:0.3 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAED_Tap:(UIButton *)sender {
    [self animateButton:_btnAED Animation:@"pop" Delay:0 Duration:0.5 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
}

- (IBAction)btnEall_Tap:(UIButton *)sender {
    [self animateButton:_btnEall Animation:@"pop" Delay:0 Duration:0.5 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
}

- (IBAction)btnFE_Tap:(UIButton *)sender {
    [self animateButton:_btnFE Animation:@"pop" Delay:0 Duration:0.5 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
}

- (IBAction)btnECall_Tap:(UIButton *)sender {
    if (_btmView.autohide == YES || _btnECall.autohide == NO) {
        //Hide & Animate btnECall
        [self animateButton:_btnECall Animation:@"fall" Delay:0 Duration:0.8 Damping:1 Velocity:0.7 Force:1 Hide:YES];
        
        //Unhide & Animate btmView
        [self animateView:_btmView Animation:@"slideUp" Delay:0 Duration:0.5 Damping:1 Velocity:0.7 Force:1 Hide:NO];
        
        //Animate buttons in btmView
        [self animateButton:_btnFF Animation:@"slideRight" Delay:0 Duration:0.8 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
        [self animateButton:_btnPolice Animation:@"slideUp" Delay:0.3 Duration:0.8 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
        [self animateButton:_btnAB Animation:@"slideLeft" Delay:0.6 Duration:0.8 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
    }
}

- (IBAction)btnFF_Tap:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://995"] options:@{} completionHandler:nil];
}

- (IBAction)btnPolice_Tap:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://999"] options:@{} completionHandler:nil];
}

- (IBAction)btnAB_Tap:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://995"] options:@{} completionHandler:nil];
}

- (IBAction)mainView_Tap:(UITapGestureRecognizer *)sender {
    //Handles btmView
    if (_btmView.autohide == NO || _btnECall.autohide == YES) {
        //Hide & Animate btmView
        [self animateView:_btmView Animation:@"fall" Delay:0 Duration:1 Damping:1 Velocity:0.7 Force:1 Hide:YES];
        
        //Unhide & Animate btnCall
        [self animateButton:_btnECall Animation:@"slideUp" Delay:0 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
    }
}

- (IBAction)mainView_Swipe:(UISwipeGestureRecognizer *)sender {
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionUp:
            if (_btnECall.autohide == NO || _btmView.autohide == YES) {
                //Hide & Animate btnECall
                [self animateButton:_btnECall Animation:@"fall" Delay:0 Duration:0.8 Damping:1 Velocity:0.7 Force:1 Hide:YES];
                
                //Unhide & Animate btmView
                [self animateView:_btmView Animation:@"slideUp" Delay:0 Duration:0.5 Damping:1 Velocity:0.7 Force:1 Hide:NO];
                
                //Animate buttons in btmView
                [self animateButton:_btnFF Animation:@"slideRight" Delay:0 Duration:0.8 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
                [self animateButton:_btnPolice Animation:@"slideUp" Delay:0.3 Duration:0.8 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
                [self animateButton:_btnAB Animation:@"slideLeft" Delay:0.6 Duration:0.8 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
            }
            break;
            
        case UISwipeGestureRecognizerDirectionLeft:
            [self performSegueWithIdentifier: @"feKit-Segue" sender: self];
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            [self performSegueWithIdentifier: @"aedKit-Segue" sender: self];
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            if (_btmView.autohide == NO || _btnECall.autohide == YES) {
                //Hide & Animate btmView
                [self animateView:_btmView Animation:@"fall" Delay:0 Duration:1 Damping:1 Velocity:0.7 Force:1 Hide:YES];
                
                //Unhide & Animate btnCall
                [self animateButton:_btnECall Animation:@"slideUp" Delay:0 Duration:1 Damping:0.7 Velocity:0.7 Force:1 Hide:NO];
            }
            break;
            
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"aedKit-Segue"]) {
        LocationView *locationView = [segue destinationViewController];
        locationView.segueID = 1;
    }
    
    if ([[segue identifier] isEqualToString:@"feKit-Segue"]) {
        LocationView *locationView = [segue destinationViewController];
        locationView.segueID = 2;
    }
    
    if ([[segue identifier] isEqualToString:@"allKit-Segue"]) {
        LocationView *locationView = [segue destinationViewController];
        locationView.segueID = 3;
    }
}

@end
