//
//  ViewController.h
//  Earthquake2016
//
//  Created by John Andrews on 1/24/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Earthquake.h"
#import "EarthquakeTableViewCell.h"
#import "MapViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

