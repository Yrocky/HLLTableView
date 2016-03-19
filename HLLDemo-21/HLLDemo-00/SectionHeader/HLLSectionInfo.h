//
//  HLLSectionInfo.h
//  HLLSectionHeaderDemo
//
//  Created by Youngrocky on 16/3/9.
//  Copyright © 2016年 HLL. All rights reserved.
//

/*
 他的作用就是管理section的一些信息：
 
 * 这个section是否处于打开状态
 * 这个section的headerView
 * 这个section的模型
 * 这个section下每一个row的高度是多少
 
 通过他把section的一些细节信息，比如sectionHeaderView和sectionObject等与控制器进行解耦，控制器只需要根据sectionInfo提供的section相关的信息进行操作展示即可
 */

#import <Foundation/Foundation.h>

@class HLLSectionHeaderView;
@class HLLRegion;

@interface HLLSectionInfo : NSObject

@property (nonatomic ,assign ,getter=isOpen) BOOL open;

// UI
@property (nonatomic) HLLSectionHeaderView * sectionHeaderView;

// Data
@property (nonatomic) HLLRegion * region;

@property (nonatomic) NSMutableArray * rowsHeight;

- (NSInteger) countOfRowsHeight;

#pragma mark - RowHeight Handle -

- (NSNumber *) objectInRowsHeightAtIndex:(NSUInteger)index;

#pragma mark - RowHeight Modifi -

- (void)insertObject:(NSNumber *)obj forRowHeightAtIndex:(NSInteger)index;
- (void)insertRowHeights:(NSArray *)rowHeightArray atIndexes:(NSIndexSet *)indexes;

- (void)replaceObjectInRowHeightsAtIndex:(NSUInteger)idx withObject:(NSNumber *)anObject;
- (void)replaceRowHeightsAtIndexes:(NSIndexSet *)indexes withRowHeights:(NSArray *)rowHeightArray;

- (void)removeObjectFromRowHeightsAtIndex:(NSUInteger)idx;
- (void)removeRowHeightsAtIndexes:(NSIndexSet *)indexes;

@end
