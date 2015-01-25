//
//  TBITAppDelegate.m
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/2/14.
//

#import "TBITAppDelegate.h"
#import "SlideNavigationController.h"
#import "LeftMenuViewController.h"

@interface TBITAppDelegate()

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, atomic) CLLocation *currentLocation;

@end

@implementation TBITAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *mainStoryboard;
    mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                               bundle: nil];
    
    //set up Slide Navigation Controller
    LeftMenuViewController *leftMenu = (LeftMenuViewController*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].enableShadow = YES;
    [SlideNavigationController sharedInstance].enableSwipeGesture = NO;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    [SlideNavigationController sharedInstance].portraitSlideOffset = screenWidth * 0.6;
    
    //init core data
    [MagicalRecord setupCoreDataStack];
    
    
   
    //set up location update
    self.currentLocation = NULL;
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    //http://nevan.net/2014/09/core-location-manager-changes-in-ios-8/
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }

    
    //make some pseudo items for demos
     [Item MR_truncateAll];
    for (int ii = 0; ii < 2; ii++) {
        NSString *temp = [NSString stringWithFormat:@"%d", ii];
        Item *item = [Item MR_findFirstByAttribute:@"uuid" withValue:temp];
        
        if (!item)
        {
            item = [Item MR_createEntity];
            item.uuid = temp;
            
        }
        
        if (ii == 0){
                item.name = @"Key";
                item.lastDateSeen = [NSDate date];
                item.lastLatitude = [NSNumber numberWithDouble:40.440625];
                item.lastLongitude = [NSNumber numberWithDouble:-79.995886];
            item.lastDistance = [NSNumber numberWithDouble:10.0];
        }
        else if (ii == 1){
                item.name = @"Wallet";
                item.lastDateSeen = [NSDate date];
                item.lastLatitude = [NSNumber numberWithDouble:39.440625];
                item.lastLongitude = [NSNumber numberWithDouble:-78.995886];
             item.lastDistance = [NSNumber numberWithDouble:5.0];
        }
        else{
                item.name = @"Pseudo";
                break;
        }
    }
    
    
//    [NSTimer scheduledTimerWithTimeInterval:1
//                                     target:self
//                                   selector:@selector(handleTimer:)
//                                   userInfo:nil
//                                    repeats:YES];
    
    return YES;
}


//-(void)handleTimer:(NSTimer *)timer
//{
//    CLLocation *loc = [self getCurrentLocation];
//    NSLog(@"%@", [loc description]);
//}

/**
 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
 */
- (void)applicationWillResignActive:(UIApplication *)application
{

}

/**
 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
 For any entities to actually be saved / updated / deleted on disk call following method
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [MagicalRecord cleanUp];
}

/**
 *  getter method
 */
-(CLLocation *)getCurrentLocation
{
    return self.currentLocation;
}

/**
 *  update current location
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *lct = [locations lastObject];
    if (lct)
    {
        self.currentLocation = lct;
    }
}

@end
