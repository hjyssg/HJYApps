//
//  ItemPhoto.h
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/26/14.

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ItemPhoto : NSManagedObject

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSString * uuid;

@end
