//
//  Earthquake.h
//  Earthquake2016
//
//  Created by John Andrews on 1/24/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Earthquake : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, strong) NSArray *coordinates;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, strong) NSNumber *magnitude;

@end
