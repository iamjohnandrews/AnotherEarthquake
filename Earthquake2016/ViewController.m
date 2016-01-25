//
//  ViewController.m
//  Earthquake2016
//
//  Created by John Andrews on 1/24/16.
//  Copyright © 2016 John Andrews. All rights reserved.
//

#import "ViewController.h"

static NSString *earthquakeAPIBaseURL = @"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson";

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *earthquakes;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveEathquakesJSON];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.title = @"Week of Earthquakes";
    if (!self.earthquakes) {
        [self displaySpinner];
    }
}

- (void)displaySpinner {
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = self.view.center;
    [self.tableView addSubview: self.spinner];
    [self.tableView bringSubviewToFront:self.spinner];
    self.spinner.hidesWhenStopped = YES;
    self.spinner.hidden = NO;
    [self.spinner startAnimating];
}

#pragma mark Networking Methods

- (void)retrieveEathquakesJSON {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:earthquakeAPIBaseURL]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    ViewController *__weak weakSelf = self;
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error && data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0
                                                                   error:nil];
            [self parseResponse:dict];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                [weakSelf.spinner stopAnimating];
            });
        }
    }] resume];
}

- (void)parseResponse:(NSDictionary *)jsonDict {
    NSArray *allEarthquakess = [jsonDict objectForKey:@"features"];
    self.earthquakes = [NSMutableArray array];
    
    for (NSDictionary *details in allEarthquakess) {
        NSDictionary *properties = [details objectForKey:@"properties"];
        NSDictionary *geometry = [details objectForKey:@"geometry"];
        
        Earthquake *earthquake = [[Earthquake alloc] init];
        earthquake.place = [properties objectForKey:@"place"];
        earthquake.time = [properties objectForKey:@"time"];
        earthquake.title = [properties objectForKey:@"title"];
        earthquake.magnitude = [properties objectForKey:@"mag"];
        earthquake.coordinates = [geometry objectForKey:@"coordinates"];
        
        [self.earthquakes addObject:earthquake];
    }
}

#pragma mark TableView Methods

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.earthquakes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EarthquakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"earthquakeCell" forIndexPath:indexPath];
    cell.earthquake = self.earthquakes[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(EarthquakeTableViewCell *)sender {
    if ([segue.identifier isEqualToString:@"toMapSegue"]) {
        MapViewController *mapViewController = segue.destinationViewController;
        NSUInteger selectedRow = [[self.tableView indexPathForCell:sender] row];
        sender.selected = NO;
        mapViewController.earthquake = self.earthquakes[selectedRow];
    }
}

@end
