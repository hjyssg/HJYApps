//
//  TBITAppDelegate.h
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/2/14.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>



@interface TBITAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;


/**
 *  this delegate will keep updating location, call this method to get the current location
 */
-(CLLocation *)getCurrentLocation;

@end
