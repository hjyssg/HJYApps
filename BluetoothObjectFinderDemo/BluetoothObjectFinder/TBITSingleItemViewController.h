//
//  TBITSingleItemViewController.h
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/9/14.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

/**
 *  the view controller to see the detail of the connected item or lost item
 *  if connected, show distance and operation button
 *  if lost, show history(e.g location, last date seen) to help user find it
 */
@interface TBITSingleItemViewController : UIViewController <MKMapViewDelegate, UIActionSheetDelegate>

//the uuid assoicated with the item
@property (strong, nonatomic) NSString *itemUUID;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@property (weak, nonatomic) IBOutlet UIButton *pairButton;

@property (weak, nonatomic) IBOutlet UIButton *beepButton;

@property (weak, nonatomic) IBOutlet UIButton *lightButton;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)lightButtonClicked:(id)sender;

- (IBAction)beepButtonClicked:(id)sender;

- (IBAction)pairButtonClicked:(id)sender;


@end
