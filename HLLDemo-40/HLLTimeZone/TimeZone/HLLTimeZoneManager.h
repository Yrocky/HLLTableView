//
//  HLLTimeZoneConfigure.h
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLLTimeZoneWrapper.h"
#import "HLLRegion.h"

@interface HLLTimeZoneManager : NSObject

+ (instancetype) shareTimeZoneManager;

/**
 *  使用HLLRegion的类方法获取已知时区列表
 *
 *  @return 已知时区列表
 */
- (NSArray <HLLRegion *>*)knownRegions;

/**
 *  获取所有的时区
 *
 *  @return 时区列表
 */
- (NSArray <HLLTimeZoneWrapper *>*)allTimeZones;
@end
