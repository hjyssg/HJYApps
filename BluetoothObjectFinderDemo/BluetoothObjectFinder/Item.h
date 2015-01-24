//
//  Item.h
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/26/14.


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSNumber * inRangeNotification;
@property (nonatomic, retain) NSDate * lastDateSeen;
@property (nonatomic, retain) NSNumber * lastDistance;
@property (nonatomic, retain) NSNumber * lastLatitude;
@property (nonatomic, retain) NSNumber * lastLongitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * outOfRangeNotification;
@property (nonatomic, retain) NSString * uuid;

@end
