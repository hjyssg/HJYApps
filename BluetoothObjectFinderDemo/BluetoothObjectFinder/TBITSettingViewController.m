//
//  TBITSettingViewController.m
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/9/14.

#import "TBITSettingViewController.h"
#import "TBITAppDelegate.h"



@interface TBITSettingViewController ()

@end


@implementation TBITSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.ConnectButton.layer.cornerRadius = 10;
    
    NSUserDefaults *dd = [NSUserDefaults standardUserDefaults];
    bool metricOn = [dd boolForKey:UNIT_CHOICE_PROPRTY_KEY];
    [self.metricUnitSwitch setOn:metricOn];
    [self.debugButton setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}
- (IBAction)reconnectBtnClicked:(id)sender {

}




- (IBAction)debugButtonClicked:(id)sender
{
//    TBITAppDelegate *delegate = (TBITAppDelegate *)[[UIApplication sharedApplication]delegate];
//    //[delegate.beaconCommunicator debug_print];
}

- (IBAction)metricSwitchChange:(id)sender {
    NSUserDefaults *dd = [NSUserDefaults standardUserDefaults];
    [dd setBool:self.metricUnitSwitch.isOn forKey:UNIT_CHOICE_PROPRTY_KEY];
    [dd synchronize];
}


@end
