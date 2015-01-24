//
//  TBITHomeViewController.h
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/9/14.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SlideNavigationController.h"

@interface TBITHomeViewController : UIViewController  <SlideNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UITableView *itemTableView;

@end
