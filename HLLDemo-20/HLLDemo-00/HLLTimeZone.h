//
//  HLLTimeZone.h
//  HLLDemo-00
//
//  Created by Youngrocky on 16/3/16.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLTimeZone : NSObject

@property (nonatomic ,copy) NSString * localeName;

@property (nonatomic) NSTimeZone * timeZone;

- (instancetype) initWithTimeZone:(NSTimeZone *)timeZone fullTimeZoneNames:(NSArray *)fullTimeZoneNames;
@end
