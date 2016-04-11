//
//  HLLSortObject.m
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLSortObject.h"
#import <objc/runtime.h>
#import "Tool.h"

@implementation HLLSortObject

#pragma mark - 汉字的排列方法

char pinyinFirstLeter(unsigned short hanzi)
{
    int index = hanzi - HANZI_START;
    if (index >= 0 && index <= HANZI_COUNT)
    {
        return firstLetterArray[index];
    }
    else
    {
        return '#';
    }
}


#pragma mark - Publice

- (NSArray *) sortCollection:(NSArray *)collectioin forEachObjectWithKeyPath:(NSString *)keyPath ascending:(BOOL)ascending{

    if (collectioin == nil || collectioin.count < 1) {
        return nil;
    }
    return nil;
}

- (NSDictionary *) sortCollection:(NSArray *)collection forEachObjectFromAToZWithKeyPath:(NSString *)keyPath{
    
    if (collection == nil || collection.count < 1) {
        return nil;
    }
    
    Class cls = [collection.firstObject class];

    unsigned int outCount;

    objc_property_t * propertys = class_copyPropertyList(cls, &outCount);
    
    BOOL hasKeyPath = NO;
    
    for (int index = 0; index < outCount; index ++) {
        
        objc_property_t property = propertys[index];
        
        NSString * propertyKey = [NSString stringWithUTF8String:property_getName(property)];
        
        if ([keyPath isEqualToString:propertyKey]) {
            hasKeyPath = YES;
        }
    }
    free(propertys);
    
    NSAssert2(hasKeyPath != NO, @"Object from '%@' didnt has this '%@' keyPath.", collection, keyPath);
    
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    [collection enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        id value = [obj valueForKeyPath:keyPath];
        
        if (value != nil) {
            
            NSString * strFirLetter = [self firstLetterOrderWithSortString:value];
            
            NSAssert(strFirLetter != nil, @"'strFirLetter' Cant be nil");
            if ([[dictionary allKeys] containsObject:strFirLetter]) {
                [[dictionary objectForKey:strFirLetter] addObject:obj];
            }else{
                NSMutableArray * tempArray = [NSMutableArray array];
                [tempArray addObject:obj];
                [dictionary setObject:tempArray forKey:strFirLetter];
            }
        }
    }];
    
    return dictionary;
}

- (NSDictionary *) sortCollectionForEachObjectFromAToZ:(NSArray <NSString *>*)collection{
    
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    [collection enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj != nil) {
            
            NSString * strFirLetter = [self firstLetterOrderWithSortString:obj];
            
            NSAssert(strFirLetter != nil, @"'strFirLetter' Cant be nil");
            if ([[dictionary allKeys] containsObject:strFirLetter]) {
                [[dictionary objectForKey:strFirLetter] addObject:obj];
            }else{
                NSMutableArray * tempArray = [NSMutableArray array];
                [tempArray addObject:obj];
                [dictionary setObject:tempArray forKey:strFirLetter];
            }
        }
    }];
    
    return dictionary;
}

- (NSArray <NSString *>*) sortCollectioinAscendingOrder:(NSArray <NSString *>*)collection{

    NSArray * ascendingOrderArray = [collection sortedArrayUsingComparator:^NSComparisonResult(NSString * key1 ,NSString * key2) {
        
        return [key1 localizedStandardCompare:key2];
    }];
    
    return ascendingOrderArray;
}

#pragma mark - Private

/**
 *  根据英文单词获得其首字母
 *
 *  @param sortString 要进行排列的字符串
 *
 *  @return sortString的首字母
 */
- (NSString *) firstLetterOrderWithSortString:(NSString *)sortString{
    
    //判断首字符是否为字母
    NSString * regex = @"[A-Za-z]+";
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    NSString * initialStr = [sortString length]?[sortString  substringToIndex:1]:@"";
    
    NSString * strFirLetter;
    
    if ([predicate evaluateWithObject:initialStr])
    {
        //首字母大写
        strFirLetter = [initialStr capitalizedString];
    }
    else
    {
        if(![sortString isEqualToString:@""])
        {
            strFirLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLeter(([sortString characterAtIndex:0]))]uppercaseString];
        }else{
            strFirLetter = @"#";
        }
    }
    return strFirLetter;
}
@end
