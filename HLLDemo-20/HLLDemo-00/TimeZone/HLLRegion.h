//
//  HLLRegion.h
//  HLLDemo-00
//
//  Created by Youngrocky on 16/3/16.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HLLTimeZone;

@interface HLLRegion : NSObject

@property (nonatomic ,strong) NSString * name;

/**
 *  使用Region的name进行便利初始化
 *
 *  @param name region的name
 *
 *  @return Region实例对象
 */
- (instancetype)initWithName:(NSString *)name;

/**
 *  获得对应区域下的所有具体时区列表
 *
 *  @return 具体时区列表
 */
- (NSArray <HLLTimeZone *>*) timeZones;

/**
 *  为当前Region下添加时区
 *
 *  @param timeZoneWrapper 具体时区对象
 */
- (void) addTimeZone:(HLLTimeZone *)timeZone;

/**
 *  为当前Region下的时区根据localeName按照排列规则进行排列
 *
 *  @param sortDescriptors 排列规则
 */
- (void) sortTimeZoneForLocaleNameUsingDescriptors:(NSSortDescriptor *)sortDescriptors;

/**
 *  为当前Region下的时区根据localeName按照比较规则进行排列
 *
 *  @param cmptr 相邻两个对象的比较规则
 */
- (void) sortTimeZoneForLocaleNameUsingComparator:(NSComparator)cmptr;
@end
