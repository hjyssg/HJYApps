//
//  TBITSettingViewController.h
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/9/14.


#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface TBITSettingViewController : UIViewController  <SlideNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *ConnectButton;
@property (weak, nonatomic) IBOutlet UISwitch *metricUnitSwitch;
@property (weak, nonatomic) IBOutlet UIButton *debugButton;
- (IBAction)metricSwitchChange:(id)sender;

@end
