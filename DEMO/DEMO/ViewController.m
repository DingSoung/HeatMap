//
//  ViewController.m
//  DEMO
//
//  Created by Songwen Ding on 6/6/16.
//  Copyright © 2016 Songwen Ding. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+CCHeatMap.h"

@interface ViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *heatImageView;
@property (nonatomic) NSMutableArray *locations;
@property (nonatomic) NSMutableArray *weights;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"quake" ofType:@"plist"];
    NSArray *quakeData = [[NSArray alloc] initWithContentsOfFile:dataFile];
    
    self.locations = [[NSMutableArray alloc] initWithCapacity:[quakeData count]];
    self.weights = [[NSMutableArray alloc] initWithCapacity:[quakeData count]];
    for (NSDictionary *reading in quakeData) {
        CLLocationDegrees latitude = [[reading objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude = [[reading objectForKey:@"longitude"] doubleValue];
        double magnitude = [[reading objectForKey:@"magnitude"] doubleValue];
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        [self.locations addObject:location];
        
        [self.weights addObject:[NSNumber numberWithInteger:(magnitude * 10)]];
    }
    

    // set map region
    self.mapView.delegate = self;
    self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(39.0, -77.0), MKCoordinateSpanMake(10.0, 13.0));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - map delegate
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSMutableArray *points = [[NSMutableArray alloc] initWithCapacity:[self.locations count]];
    for (int i = 0; i < self.locations.count; i++) {
        CLLocation *location = [self.locations objectAtIndex:i];
        CGPoint point = [self.mapView convertCoordinate:location.coordinate toPointToView:self.mapView];
        [points addObject:[NSValue valueWithCGPoint:point]];
    }
    self.heatImageView.image = [UIImage heatMapWithRect:self.mapView.bounds boost:0.5 points:points weights:self.weights weightsAdjustmentEnabled:NO groupingEnabled:YES];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    return [[MKOverlayRenderer alloc] initWithOverlay:overlay];
}

@end





