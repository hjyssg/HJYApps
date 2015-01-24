//
//  TBITSingleItemViewController.m
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/9/14.
//

#import "TBITSingleItemViewController.h"
#import "SlideNavigationController.h"
#import "TBITAppDelegate.h"
#import "TBITSingleItemViewController.h"
#import "TBITAddAndEditItemViewController.h"
#import "TBITItemMapAnnotation.h"
#import <QuartzCore/QuartzCore.h>

@interface TBITSingleItemViewController ()


@end

@implementation TBITSingleItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)updateUI
{
    Item * item = [Item MR_findFirstByAttribute:@"uuid" withValue:self.itemUUID];
    if (item == NULL)
    {
        //show error when null
        for (UIView * view in self.view.subviews) {
            if ([view isKindOfClass:[UILabel class]])
            {
                UILabel * lbl = (UILabel *)view;
                [lbl  setText:@"ERROR!!"];
                [lbl setTextColor:[UIColor redColor]];
                lbl.adjustsFontSizeToFitWidth = YES;
            }
        }
        [self.navigationItem setTitle:@"ERROR"];
        return;
    }
    
    NSUserDefaults *dd = [NSUserDefaults standardUserDefaults];
    bool metricOn = [dd boolForKey:UNIT_CHOICE_PROPRTY_KEY];
    TBITAppDelegate *delegate = (TBITAppDelegate *) [[UIApplication sharedApplication]delegate];
    CLLocation *currentLocation = [delegate getCurrentLocation];
    
    NSString *ts = @"";
    //set name button and navigation item
    
    [self.navigationItem setTitle:item.name];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yy/MM/dd HH:mm"];
    NSString *temp = [dateFormat stringFromDate:item.lastDateSeen];
    ts = [NSString stringWithFormat:@"Last Seen %@", temp];
    [self.temperatureLabel setText:ts];
    
    
    
    CLLocation *lcl = [[CLLocation alloc]initWithLatitude:[item.lastLatitude doubleValue] longitude:[item.lastLongitude doubleValue]];
    float distance = [lcl distanceFromLocation:currentLocation];
    distance = distance + [item.lastDistance floatValue]/1.5;
    if (metricOn){
        ts = [NSString stringWithFormat:@"Within %.2f M", distance];
    }else{
        ts = [NSString stringWithFormat:@"Within %.2f Feet", METER_TO_FEET(distance)];
    }
    [self.distanceLabel setText:ts];
    
    
    [self.pairButton setTitle:@" Untrack " forState:UIControlStateNormal];
    [self.editButton setHidden:NO];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.pairButton.layer.cornerRadius = 10;
    self.pairButton.layer.borderWidth = 0.5;
    self.pairButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    self.editButton.layer.cornerRadius = 10;
    self.editButton.layer.borderWidth = 0.5;
    self.editButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    
    [self updateUI];
    [self zoomIntoItemLocation];
    
    //make all label adjust to width
    for (UIView * view in self.view.subviews) {
        if ([view isKindOfClass:[UILabel class]])
        {
            UILabel * lbl = (UILabel *)view;
            lbl.adjustsFontSizeToFitWidth = YES;
        }else if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)view;
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        }
    }
}




-(void)goToAddAndEditItemPage
{
    
    UIStoryboard *mainStoryboard = self.storyboard;
    TBITSingleItemViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"TBITAddItemViewController"];
    [[SlideNavigationController sharedInstance]pushViewController:vc animated:YES];
    vc.itemUUID = self.itemUUID;
}

/**
 *  called when receive BEACON_INFO_UPDATE_NOTICATION
 */
-(void)handleBeaconInfoUpdate:(NSNotification *)notification
{
        [self updateUI];
}

#pragma mark UI action handler
- (IBAction)editButtonClicked:(id)sender {
    [self goToAddAndEditItemPage];
}


- (IBAction)lightButtonClicked:(id)sender
{
    
}

- (IBAction)beepButtonClicked:(id)sender {
    
}

/**
 *  This method is for adding or deleting a sticker from the database. If the id is new,
 *  then the program goes to addItemPage to create a new entry. If it is an existing
 *  item in the database then the item is deleted.
 */
- (IBAction)pairButtonClicked:(id)sender {
    
    Item * item = [Item MR_findFirstByAttribute:@"uuid" withValue:self.itemUUID];
    if (item)
    {
        UIActionSheet *menu = [[UIActionSheet alloc]initWithTitle:@"So you don't want to track this item anymore?" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:nil otherButtonTitles:@"Yes",  nil];
        [menu showInView:self.view];
        
    }else
    {
        [self goToAddAndEditItemPage];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        Item * item = [Item MR_findFirstByAttribute:@"uuid" withValue:self.itemUUID];
        if (item)
        {
            //delete the item and photo
            [item MR_deleteEntity];
            ItemPhoto *photo = [ItemPhoto MR_findFirstByAttribute:@"uuid" withValue:self.itemUUID];
            if (photo){[photo MR_deleteEntity];}
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

#pragma mark - MapView Delegate-
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"itemLocationIdentfier";
    if ([annotation isKindOfClass:[TBITItemMapAnnotation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        
        return annotationView;
    }
    
    return nil;
}


/**
 *  annotation for user and items
 */

-(void)zoomIntoItemLocation
{
    const float latitude_range = 100; //in meters
    const float longitude_range = 100; //in meters
    
    //remove old annotation
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        [self.mapView removeAnnotation:annotation];
    }
    
    //add annotation for user
    TBITAppDelegate *delegate = (TBITAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    CLLocationCoordinate2D currentLoc = [[delegate getCurrentLocation] coordinate ];
    
    
    
    MKCoordinateRegion mapRegion = MKCoordinateRegionMakeWithDistance(currentLoc, latitude_range, longitude_range);
    
    Item * item = [Item MR_findFirstByAttribute:@"uuid" withValue:self.itemUUID];
    if (item)
    {
        CLLocationCoordinate2D lcr = CLLocationCoordinate2DMake([item.lastLatitude doubleValue], [item.lastLongitude doubleValue]);
        
        //0.0 0.0 is somewhere on west afican ocean
        if (lcr.longitude != 0.0 && lcr.latitude != 0.0)
        {
            mapRegion = MKCoordinateRegionMakeWithDistance(lcr, latitude_range, longitude_range);
            
            //annotation for item
            TBITItemMapAnnotation *annote = [[TBITItemMapAnnotation alloc]init];
            annote.coordinate = lcr;
            annote.name = item.name;
            annote.uuid = item.uuid;
            
            //DLog(@"%f %f", lcr.latitude, lcr.longitude);
            [self.mapView addAnnotation:annote];
        }
    }else
    {
        
    }
    
    //zoom
    [self.mapView setRegion:mapRegion animated: YES];
}

-(void)dealloc
{
    //should alway remove self from notification when dealloc
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
