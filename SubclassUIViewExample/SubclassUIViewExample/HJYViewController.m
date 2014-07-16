//
//  HJYViewController.m
//  SubclassUIViewExample
//
//  Created by junyang_huang on 7/2/13.
//  Copyright (c) 2013 hjyssg.com. All rights reserved.
//

#import "HJYViewController.h"
#import "HJYView.h"

@interface HJYViewController ()

@end

@implementation HJYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HJYView *hjyview = [[HJYView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:hjyview];
}


@end
