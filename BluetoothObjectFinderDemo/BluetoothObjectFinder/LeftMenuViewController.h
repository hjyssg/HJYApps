//
//  MenuViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Modified by Junyang Huang On 06/10/2014
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//
//  Modified by Junyang Huang for this project on 06/09/2014
//

#import <UIKit/UIKit.h>

/**
 *  the left-menu
 */
@interface LeftMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;

@end
