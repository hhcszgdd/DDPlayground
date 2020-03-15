//
//  DDSingleInstance.m
//  MyPlayground
//
//  Created by JohnConnor on 2020/3/15.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

#import "DDSingleInstance.h"

@implementation DDSingleInstance
static DDSingleInstance *share;
+ (instancetype) share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [DDSingleInstance new];
    });
    return share;
}
@end
