//
//  TBITItemMapAnnotation.m
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/20/14.

#import "TBITItemMapAnnotation.h"


@implementation TBITItemMapAnnotation

- (NSString *)title {
    if ([self.name isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return self.name;
}

@end
