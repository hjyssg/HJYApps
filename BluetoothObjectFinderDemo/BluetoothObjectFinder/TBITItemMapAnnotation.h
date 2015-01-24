//
//  TBITItemMapAnnotation.h
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/20/14.


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/**
 *  used to annote item on mapview
 */
@interface TBITItemMapAnnotation : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *uuid;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
