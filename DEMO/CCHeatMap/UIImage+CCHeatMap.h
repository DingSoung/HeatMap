//
//  CCHeatImage.h
//  MCompass
//
//  Created by Songwen Ding on 6/3/16.
//  Copyright © 2016 Songwen Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface UIImage( CCHeatMap )

/**
 Generates a heat map image for the specified rectangle.
 
 There should be a one-to-one correspondence between the location and weight
 elements.
 A nil weight parameter implies an even weight distribution.
 
 @params
 @rect: region frame
 boost: heat boost value
 points: array of NSValue CGPoint objects representing the data points
 weights: array of NSNumber integer objects representing the weight of each
 point
 weightsAdjustmentEnabled: set YES for weight balancing and normalization
 groupingEnabled: set YES for tighter visual grouping of dense areas
 
 @returns
 UIImage object representing the heatmap for the specified region.
 */
+ (UIImage *)heatMapWithRect:(CGRect)rect
                       boost:(float)boost
                      points:(NSArray *)points
                     weights:(NSArray *)weights
    weightsAdjustmentEnabled:(BOOL)weightsAdjustmentEnabled
             groupingEnabled:(BOOL)groupingEnabled;



@end
