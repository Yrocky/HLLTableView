//
//  HLLRegion.m
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLRegion.h"
#import "HLLTimeZoneWrapper.h"


@interface HLLRegion ()

@property (nonatomic) NSMutableArray * mutableTimeZoneWrappers;

@end
@implementation HLLRegion

- (NSArray <HLLTimeZoneWrapper *>*)timeZoneWrappers{

    return self.mutableTimeZoneWrappers;
}

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        _mutableTimeZoneWrappers = [NSMutableArray array];
    }
    return self;
}

- (void) addTimeZoneWrapper:(HLLTimeZoneWrapper *)timeZoneWrapper{

    [self.mutableTimeZoneWrappers addObject:timeZoneWrapper];
}

- (void)sortTimeZoneForLocaleNameUsingDescriptors:(NSSortDescriptor *)sortDescriptors{

    [self.mutableTimeZoneWrappers sortUsingDescriptors:@[sortDescriptors]];
}

- (void)sortTimeZoneForLocaleNameUsingComparator:(NSComparator)cmptr{

    [self.mutableTimeZoneWrappers sortUsingComparator:cmptr];
}
@end
