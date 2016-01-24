//
//  EarthquakeTableViewCell.h
//  Earthquake2016
//
//  Created by John Andrews on 1/24/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Earthquake.h"

@interface EarthquakeTableViewCell : UITableViewCell
@property (nonatomic, strong) Earthquake *earthquake;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
