//
//  HLLRegion.m
//  HLLDemo-00
//
//  Created by Youngrocky on 16/3/16.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLRegion.h"
#import "HLLTimeZone.h"

@interface HLLRegion ()

@property (nonatomic) NSMutableArray * mutableTimeZones;

@end

@implementation HLLRegion

- (NSArray <HLLTimeZone *>*)timeZones{
    
    return self.mutableTimeZones;
}

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        _mutableTimeZones = [NSMutableArray array];
    }
    return self;
}

- (void) addTimeZone:(HLLTimeZone *)timeZone{
    
    [self.mutableTimeZones addObject:timeZone];
}

- (void)sortTimeZoneForLocaleNameUsingDescriptors:(NSSortDescriptor *)sortDescriptors{
    
    [self.mutableTimeZones sortUsingDescriptors:@[sortDescriptors]];
}

- (void)sortTimeZoneForLocaleNameUsingComparator:(NSComparator)cmptr{
    
    [self.mutableTimeZones sortUsingComparator:cmptr];
}

@end
