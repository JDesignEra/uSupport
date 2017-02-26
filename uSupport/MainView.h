//
//  MainView.h
//  uSupport
//
//  Created by Joel.
//  Copyright © 2017 J.Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <uSupport-Swift.h>

@interface MainView : UIViewController

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet SpringImageView *logo;

@property (weak, nonatomic) IBOutlet SpringButton *btnAED;
@property (weak, nonatomic) IBOutlet SpringButton *btnEall;
@property (weak, nonatomic) IBOutlet SpringButton *btnFE;

@property (weak, nonatomic) IBOutlet SpringButton *btnECall;
@property (weak, nonatomic) IBOutlet SpringView *btmView;
@property (weak, nonatomic) IBOutlet SpringButton *btnFF;
@property (weak, nonatomic) IBOutlet SpringButton *btnPolice;
@property (weak, nonatomic) IBOutlet SpringButton *btnAB;

- (IBAction)btnAED_Tap:(UIButton *)sender;
- (IBAction)btnECall_Tap:(UIButton *)sender;
- (IBAction)btnFF_Tap:(UIButton *)sender;
- (IBAction)btnPolice_Tap:(UIButton *)sender;
- (IBAction)btnAB_Tap:(UIButton *)sender;
- (IBAction)btnEall_Tap:(UIButton *)sender;
- (IBAction)btnFE_Tap:(UIButton *)sender;

- (IBAction)mainView_Tap:(UITapGestureRecognizer *)sender;
- (IBAction)mainView_Swipe:(UISwipeGestureRecognizer *)sender;

@end

