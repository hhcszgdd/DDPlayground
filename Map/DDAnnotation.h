//
//  DDAnnotation.h
//  DrawEclipse
//
//  Created by JohnConnor on 2020/3/16.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDAnnotation : NSObject  < MKAnnotation >
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
