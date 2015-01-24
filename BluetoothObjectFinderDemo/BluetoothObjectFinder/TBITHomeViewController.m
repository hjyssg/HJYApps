//
//  TBITHomeViewController.m
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/9/14.
//

#import "TBITHomeViewController.h"
#import "TBITItemTableViewCell.h"
#import "TBITAppDelegate.h"
#import "TBITSingleItemViewController.h"
#import "TBITItemMapAnnotation.h"

@interface TBITHomeViewController ()


@property (strong, nonatomic) UIButton * toggleButton;

//the keys of all items
// nsstring
//include the ones in core data and the one in bluetoorh communicator
@property (strong, atomic) NSMutableArray * allItemKeys;

@end

@implementation TBITHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


-(NSArray *)getKeysOfNotInRangeItems
{
    NSArray * items = [Item MR_findAll];
    return items;
}

-(NSArray *)getAllItemKeys
{
    
    [self.allItemKeys  removeAllObjects];
    
    
    NSArray * items = [Item MR_findAll];
    
    //add item not in range but in DB
    for (Item *item in items) {
        
        NSString *key = item.uuid;
        if (![self.allItemKeys containsObject:key])
        {
            [self.allItemKeys addObject:key];
        }
    }
    
    return self.allItemKeys;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TBITAppDelegate *delegate = (TBITAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.allItemKeys = [[NSMutableArray alloc]init];
    
    //zoom the map
    static float latitude_range = 300; //in meters
    static float longitude_range = 300; //in meters
    MKCoordinateRegion mapRegion = MKCoordinateRegionMakeWithDistance([delegate getCurrentLocation].coordinate, latitude_range, longitude_range);
    [self.mapView setRegion:mapRegion animated: YES];
    
 
    //show table and shrink maps
    CGRect f = self.view.frame;
    CGSize ss = f.size;
    CGPoint oo = f.origin;
    
    
    
    //add gesture to map
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handleGestureOnMap:)];
    tgr.numberOfTouchesRequired = 1;
    [self.mapView addGestureRecognizer:tgr];
    
    
    //create toggle button
    self.toggleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.toggleButton.frame = CGRectMake(oo.x, ss.height/10*9, ss.width, 0);
    [self.toggleButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.toggleButton addTarget:self action:@selector(displayTableAndShrinkMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.toggleButton];
    
    [self displayTableAndShrinkMap];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.itemTableView reloadData];
}

#pragma mark go to other view controllers

-(void)goToSingleItemPageWithItemId:(NSString *)itemUUID
{
    UIStoryboard *mainStoryboard = self.storyboard;
	TBITSingleItemViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"TBITSingleItemViewController"];
    

    [[SlideNavigationController sharedInstance]pushViewController:vc animated:YES];
    vc.itemUUID = itemUUID;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}


#pragma mark - UITableView Delegate & Datasrouce -

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Connected";
            break;
        case 1:
            return @"Out-of-Range";
            break;
        default:
            return @"";
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [[self getAllItemKeys]count];
    
    if (section == 0)
    {
        return 0;
    }else if (section == 1)
    {
        count = [[self getKeysOfNotInRangeItems]count];
    }else
    {
        count = 0;
    }
    

    
	return count;
}

/**
 *  Creates a display cell for one of the user's items. Cell includes the item's name, photo and
 *  if it is in range of the user.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    Item * item ;
    if ([indexPath section] == 0)
    {  //in-range item
        return  [[TBITItemTableViewCell alloc]initWIthItem:nil];
    }
    else if ([indexPath section] == 1)
    {
        //out-range item
        NSArray * disconnectedItemKeys = [self getKeysOfNotInRangeItems];
        item = [disconnectedItemKeys objectAtIndex:[indexPath row]];
      
        TBITItemTableViewCell *cell = (TBITItemTableViewCell *)[tableView  dequeueReusableCellWithIdentifier:@"ItemTableCell"];
        if(cell == NULL)
        {
            cell = [[TBITItemTableViewCell alloc]initWIthItem:item];
        }
        else
        {
            [cell updateUIWithItem:item];
        }
        return cell;
    }
    else
    {
        NSLog(@"in homepage, more than 3 secions");
        //not choice but crush
        return nil;
    }
   
}

/**
 *  sends the user to a new view where they can edit their item.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0)
    {
        //in range device
//        dev = [self.bc.connectedDevices  objectAtIndex:[indexPath row]];
//        [self goToSingleItemPageWithItemId:[dev getUUIDString]];
        
    }else if ([indexPath section] == 1)
    {
        //out range device
        NSArray * disconnectedItemKeys = [self getKeysOfNotInRangeItems];
        Item *item = [disconnectedItemKeys objectAtIndex:[indexPath row]];
        [self goToSingleItemPageWithItemId:item.uuid];
        
    }else
    {
        return;
    }
}

#pragma mark - MapView Delegate-
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    static float latitude_range = 300; //in meters
    static float longitude_range = 300; //in meters
    
    MKCoordinateRegion mapRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, latitude_range, longitude_range);
    
    [mapView setRegion:mapRegion animated: YES];
}


-(void)putPinForItems
{
    const float latitude_range = 100; //in meters
    const float longitude_range = 100; //in meters
    
    //remove old annotation
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        [self.mapView removeAnnotation:annotation];
    }
    
    
    //add annotation for user
    TBITAppDelegate *delegate = (TBITAppDelegate *)[[UIApplication sharedApplication]delegate];
    TBITItemMapAnnotation *currentLocationAnnote = [[TBITItemMapAnnotation alloc]init];
    CLLocationCoordinate2D currentLoc = [[delegate getCurrentLocation] coordinate ];
    currentLocationAnnote.coordinate = currentLoc;
    
    //put pin on the current locaton
    int num = 0;
    if (num == 0)
    {
        currentLocationAnnote.name = @"No Device Nearby";
    }else if(num == 1)
    {
        currentLocationAnnote.name = @"1 Device Nearby"; //I do follow English grammar,hahah
    }else
    {
        NSString *temp = [NSString stringWithFormat:@"%d Devices Nearby", num];
        currentLocationAnnote.name = temp;
    }
    [self.mapView addAnnotation:currentLocationAnnote];
    
    MKCoordinateRegion mapRegion = MKCoordinateRegionMakeWithDistance(currentLoc, latitude_range, longitude_range);
    
    //put pins on traked item that is out-range
    for (Item *item in [Item MR_findAll]) {
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
        }
    }
}

/**
 *  called when receive BEACON_INFO_UPDATE_NOTICATION
 */
-(void)handleBeaconInfoUpdate:(NSNotification *)notification
{
    
        [self.itemTableView reloadData];
        [self putPinForItems];
    
}


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
 * display the normal UI
 */
-(void)displayTableAndShrinkMap
{
    CGRect f = self.view.frame;
    CGSize ss = f.size;
    CGPoint oo = f.origin;
    
    //show table and shrink map
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    {
        self.mapView.frame = CGRectMake(0, 0, ss.width, ss.height/2);
        self.itemTableView.frame = CGRectMake(0, ss.height/2, ss.width, ss.height/2);
        self.toggleButton.frame = CGRectMake(oo.x, ss.height*0.9, ss.width, 0);
        [self.toggleButton setTitle:@"" forState:UIControlStateNormal];
    }
    [UIView commitAnimations];
}

/**
 * hide the table and extend the map
 */
-(void)hideTableAndExtendMap
{
    CGRect f = self.view.frame;
    CGSize ss = f.size;
    CGPoint oo = f.origin;
    
    //hide table and extend map
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    {
        self.itemTableView.frame = CGRectMake(0, ss.height, ss.width, 0);
        self.mapView.frame = CGRectMake(0, oo.y, ss.width, ss.height*0.9);
        self.toggleButton.frame = CGRectMake(0, ss.height*0.9,
                                             ss.width, ss.height);
        [self.toggleButton setTitle:@"UP" forState:UIControlStateNormal];
    }
    
    [UIView commitAnimations];
}


/**
 *  when user tap the map view,
 * extend it and hide the table
 */
- (void)handleGestureOnMap:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
    {
        return;
    }
    
    if (self.mapView.frame.size.height < self.view.frame.size.height * 0.7)
    {
        [self hideTableAndExtendMap];
    }
}

-(void)dealloc
{
    //should alway remove self from notification when dealloc
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
