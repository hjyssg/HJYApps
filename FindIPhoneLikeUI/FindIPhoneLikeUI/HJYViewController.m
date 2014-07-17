//
//  HJYViewController.m
//  FindIPhoneLikeUI
//
//  Created by Junyang Huang on 7/17/14.
//  Copyright (c) 2014 HJY. All rights reserved.
//

#import "HJYViewController.h"

@interface HJYViewController ()

@property (atomic) BOOL showTable;

@end

@implementation HJYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //show table and shrink maps
    self.showTable = YES;
    CGRect f = self.view.frame;
    self.mapView.frame = CGRectMake(0, 0, f.size.height/2, f.size.width);
    self.tableView.hidden = NO;
    self.tableView.frame = CGRectMake(0, f.size.height/2, f.size.height/2, f.size.width);
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handleGesture:)];
    tgr.numberOfTouchesRequired = 1;
    [self.mapView addGestureRecognizer:tgr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    CGRect f = self.view.frame;
    
    if (self.showTable)
    {
        //hide table and extend map
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.tableView.frame = CGRectMake(0, f.size.height, f.size.width, 0);
        self.mapView.frame = self.view.frame;
        [UIView commitAnimations];
        self.showTable = NO;
    }
    else
    {
        //show table and shrink map
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.mapView.frame = CGRectMake(0, 0, f.size.width, f.size.height/2);
        self.tableView.frame = CGRectMake(0, f.size.height/2, f.size.width, f.size.height/2);
        [UIView commitAnimations];
        self.showTable = YES;
    }
}


@end
