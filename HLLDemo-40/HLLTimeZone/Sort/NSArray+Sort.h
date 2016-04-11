//
//  NSArray+Sort.h
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Sort)


/**
 *  对数组中对象按照其属性进行排列，默认为升序排列
 *
 *  @param keyPath     排列对象的属性
 *  @param ascending   是否升序
 *
 *  @return 排序完成之后的数组
 */
- (NSArray *) sortCollectionForEachObjectWithKeyPath:(NSString *)keyPath ascending:(BOOL)ascending;

/**
 *  对数组中的对象按照给定的属性进行A-Z归类
 *
 *  @param keyPath    该对象的属性
 *
 *  @return 排序结果：@{@"A":@[obj1A、obj2A...]...@"Z":@[obj1Z、obj2Z]}
 */
- (NSDictionary *) sortCollectionForEachObjectFromAToZWithKeyPath:(NSString *)keyPath;

/**
 *  对数组中的字符串进行A-Z归类
 *
 *  @return 排序结果：@{@"A":@[string1A、string2A...]...@"Z":@[string1Z、string2Z]}
 */
- (NSDictionary *) sortCollectionForEachObjectFromAToZ;

/**
 *  对数组对其进行字符串升序排列
 *
 *  @return 排列过后的数组
 */
- (NSArray <NSString *>*) sortCollectioinAscendingOrder;
@end
