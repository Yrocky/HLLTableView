//
//  HLLSortObject.h
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLSortObject : NSObject

/**
 *  对数组中对象按照其属性进行排列，默认为升序排列
 *
 *  @param collectioin 装有排列对象的数组
 *  @param keyPath     排列对象的属性
 *  @param ascending   是否升序
 *
 *  @return 排序完成之后的数组
 */
- (NSArray *) sortCollection:(NSArray *)collectioin forEachObjectWithKeyPath:(NSString *)keyPath ascending:(BOOL)ascending;

/**
 *  对给定的数组中的对象按照给定的属性进行A-Z归类
 *
 *  @param collection 装有归类对象的数组
 *  @param keyPath    该对象的属性
 *
 *  @return 排序结果：@{@"A":@[obj1A、obj2A...]...@"Z":@[obj1Z、obj2Z]}
 */
- (NSDictionary *) sortCollection:(NSArray *)collection forEachObjectFromAToZWithKeyPath:(NSString *)keyPath;

/**
 *  对给定的数组中的字符串进行A-Z归类
 *
 *  @param collection 装有要排序字符串的数组
 *
 *  @return 排序结果：@{@"A":@[string1A、string2A...]...@"Z":@[string1Z、string2Z]}
 */
- (NSDictionary *) sortCollectionForEachObjectFromAToZ:(NSArray <NSString *>*)collection;

/**
 *  给定数组对其进行字符串升序排列
 *
 *  @param collection 给定的数组
 *
 *  @return 排列过后的数组
 */
- (NSArray <NSString *>*) sortCollectioinAscendingOrder:(NSArray <NSString *>*)collection;
@end
