//
//  EarthquakeTableViewCell.m
//  Earthquake2016
//
//  Created by John Andrews on 1/24/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import "EarthquakeTableViewCell.h"

@implementation EarthquakeTableViewCell

- (void)setEarthquake:(Earthquake *)earthquake {
    [self populateText:earthquake];
}

- (void)populateText:(Earthquake *)earthquake {
    self.textLabel.text = [self convertTimeToText:earthquake.time];
    self.detailTextLabel.text = earthquake.magnitude.stringValue;
}

- (NSString *)convertTimeToText:(NSNumber *)time {
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time.doubleValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    return [dateFormatter stringFromDate:date];
}

@end
