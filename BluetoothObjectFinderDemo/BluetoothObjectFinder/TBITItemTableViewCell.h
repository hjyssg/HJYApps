//
//  TBITItemTableViewCell.h
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/9/14.
//  Copyright (c) 2014 http://schneiderlab.lrdc.pitt.edu/. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "snfsdk.h"

@interface TBITItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



-(id)initWIthItem:(Item *)item;
-(void)updateUIWithItem:(Item *)item;

@end
