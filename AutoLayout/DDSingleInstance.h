//
//  DDSingleInstance.h
//  MyPlayground
//
//  Created by JohnConnor on 2020/3/15.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDSingleInstance : NSObject
+ (instancetype) share;
@end

NS_ASSUME_NONNULL_END
