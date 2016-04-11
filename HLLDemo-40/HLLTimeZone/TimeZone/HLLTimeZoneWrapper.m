//
//  HLLTimeZoneWrapper.m
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLTimeZoneWrapper.h"

#define TestOtherSituation

@implementation HLLTimeZoneWrapper

- (instancetype)initWithTimeZone:(NSTimeZone *)timeZone fullTimeZoneNames:(NSArray *)fullTimeZoneNames{

    self = [super init];
    if (self) {
        _timeZone = timeZone;
        // fullTimeZoneNames中有特殊的，只有一个元素，比如GMT
        NSString * name = nil;
        if (fullTimeZoneNames.count == 1) {
            name = @"*GMT*";
        }
        if (fullTimeZoneNames.count == 2) {
            name = fullTimeZoneNames[1];
        }
        // 还有比较特殊的，有三个元素，比如America/North_Dakota/Beulah
        if (fullTimeZoneNames.count == 3) {
            name = [NSString stringWithFormat:@"%@ (%@)",fullTimeZoneNames[1],fullTimeZoneNames[2]];
        }
#ifdef TestOtherSituation
        if ([name  isEqual: @"Abidjan"]) {
            name = @"100";
        }
        if ([name isEqualToString:@"Aden"]) {
            name = @"安阳";
        }
        if ([name isEqualToString:@"Adak"]) {
            name = @"😂";
        }
        if ([name isEqualToString:@"Accra"]) {
            name = @"北京";
        }
        if ([name isEqualToString:@"GMT"]) {
            name = @"GMT";
        }
#endif
        _localeName = [name stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    }
    return self;
}

@end
