//
//  HLLTimeZoneConfigure.m
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLTimeZoneManager.h"

#define SortNameUseThisSimpleAPI

@implementation HLLTimeZoneManager

static HLLTimeZoneManager *_instance;
static NSMutableArray * knownRegions = nil;
static NSMutableArray * allTimeZones = nil;

#pragma mark -

+ (id)allocWithZone:(NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype) shareTimeZoneManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - publice

- (NSArray <HLLRegion *>*)knownRegions{
    
    if (knownRegions == nil) {
        [self configureWithKnownRegions];
    }
    return knownRegions;
}

- (NSArray<HLLTimeZoneWrapper *> *)allTimeZones{
    
    if (allTimeZones == nil) {
        [self configureWithAllTimeZones];
    }
    return allTimeZones;
}

/**
 *  进行所有已知的Region的获取
 */
- (void) configureWithKnownRegions{
    
    NSArray * knownTimeZoneNames = [NSTimeZone knownTimeZoneNames];
    NSMutableArray * regions = [NSMutableArray arrayWithCapacity:knownTimeZoneNames.count];
    
    for (NSString * timeZoneName in knownTimeZoneNames) {
        
        NSArray * fullTimeZoneNames = [timeZoneName componentsSeparatedByString:@"/"];
        NSString * regionName = fullTimeZoneNames[0];
        HLLRegion * region = nil;
        
        //防止重复添加Region
        for (HLLRegion * tempRegion in regions) {
            if ([tempRegion.name isEqualToString:regionName]) {
                region = tempRegion;
                break;
            }
        }
        if (region == nil) {
            region = [[HLLRegion alloc] initWithName:regionName];
            [regions addObject:region];
        }
        
        NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:timeZoneName];
        
        // fix bug，如果region的name是GMT的时候由于其没有timeZone，导致添加了一个空白的timeZone
        if (fullTimeZoneNames.count > 1) {
            
            HLLTimeZoneWrapper * timeZoneWrapper = [[HLLTimeZoneWrapper alloc] initWithTimeZone:timeZone fullTimeZoneNames:fullTimeZoneNames];
            
            [region addTimeZoneWrapper:timeZoneWrapper];
        }
    }
    
    // 使用排序对regions和相应的HLLRegion对象下的timeZone也进行排序
    
    // 1.regions ,按照name升序排列
#ifdef SortNameUseThisSimpleAPI
    
    [regions sortUsingComparator:^NSComparisonResult(HLLRegion * region1,HLLRegion * region2) {
        return [region1.name localizedStandardCompare:region2.name];
    }];
    
#else
    
    NSSortDescriptor * nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES comparator:^NSComparisonResult(NSString * name1,NSString * name2) {
        return [name1 localizedStandardCompare:name2];
    }];
    
    [regions sortUsingDescriptors:@[nameSortDescriptor]];
    
#endif
    
    // 2.HLLRegion对象下的timeZone，按照localeName排序
#ifndef SortNameUseThisSimpleAPI
    
    NSSortDescriptor * localeNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"localeName" ascending:YES comparator:^NSComparisonResult(NSString * localeName1,NSString * localeName2) {
        return [localeName1 localizedStandardCompare:localeName2];
    }];
    
#endif
    
    for (HLLRegion * region in regions) {
        
#ifdef SortNameUseThisSimpleAPI
        
        [region sortTimeZoneForLocaleNameUsingComparator:^NSComparisonResult(HLLTimeZoneWrapper * timeZone1,HLLTimeZoneWrapper * timeZone2) {
            return [timeZone1.localeName localizedStandardCompare:timeZone2.localeName];
        }];
#else
        
        [region sortTimeZoneForLocaleNameUsingDescriptors:localeNameSortDescriptor];
        
#endif
    }
    
    knownRegions = regions;
}


/**
 *  进行所有的时区的获取
 */
- (void) configureWithAllTimeZones{
    
    NSArray * knowTimeZoneNames = [NSTimeZone knownTimeZoneNames];
    
    NSMutableArray * timeZones = [NSMutableArray arrayWithCapacity:knowTimeZoneNames.count];
    
    for (NSString * timeZoneName in knowTimeZoneNames) {
        
        NSArray * fullTimeZoneNames = [timeZoneName componentsSeparatedByString:@"/"];
        
        NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:timeZoneName];
        
        HLLTimeZoneWrapper * timeZoneWrapper = [[HLLTimeZoneWrapper alloc] initWithTimeZone:timeZone fullTimeZoneNames:fullTimeZoneNames];
        [timeZones addObject:timeZoneWrapper];
    }
    
#ifdef SortNameUseThisSimpleAPI
    
    [timeZones sortUsingComparator:^NSComparisonResult(HLLTimeZoneWrapper * timeZone1,HLLTimeZoneWrapper * timeZone2) {
        return [timeZone1.localeName localizedStandardCompare:timeZone2.localeName];
    }];
    
#else
    
    NSSortDescriptor * localeNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"localeName" ascending:YES comparator:^NSComparisonResult(NSString * localeName1,NSString * localeName2) {
        return [localeName1 localizedStandardCompare:localeName2];
    }];
    
    [timeZones sortUsingDescriptors:@[localeNameSortDescriptor]];
    
#endif
    
    allTimeZones = timeZones;
}
@end
