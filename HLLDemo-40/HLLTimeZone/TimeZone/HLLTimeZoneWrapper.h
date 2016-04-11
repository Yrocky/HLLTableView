//
//  HLLTimeZoneWrapper.h
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLTimeZoneWrapper : NSObject

@property (nonatomic ,copy) NSString * localeName;

@property (nonatomic) NSTimeZone * timeZone;

- (instancetype) initWithTimeZone:(NSTimeZone *)timeZone fullTimeZoneNames:(NSArray *)fullTimeZoneNames;

@end
