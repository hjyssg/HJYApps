//
//  HJYViewController.h
//  FindIPhoneLikeUI
//
//  Created by Junyang Huang on 7/17/14.
//  Copyright (c) 2014 HJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HJYViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
