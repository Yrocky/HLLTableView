//
//  HLLTimeZoneManager.h
//  HLLDemo-00
//
//  Created by Youngrocky on 16/3/16.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLLTimeZone.h"
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
- (NSArray <HLLTimeZone *>*)allTimeZones;

@end
