//
//  HLLSectionInfo.m
//  HLLSectionHeaderDemo
//
//  Created by Youngrocky on 16/3/9.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLSectionInfo.h"

@implementation HLLSectionInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _rowsHeight = [NSMutableArray array];
    }
    return self;
}
- (NSInteger) countOfRowsHeight{

    return self.rowsHeight.count;
}

- (NSNumber *) objectInRowsHeightAtIndex:(NSUInteger)index{
    
    return self.rowsHeight[index];
}

- (void)insertObject:(NSNumber *)obj forRowHeightAtIndex:(NSInteger)index{

    [self.rowsHeight insertObject:obj atIndex:index];
}
- (void)insertRowHeights:(NSArray *)rowHeightArray atIndexes:(NSIndexSet *)indexes{

    [self.rowsHeight insertObjects:rowHeightArray atIndexes:indexes];
}

- (void)replaceObjectInRowHeightsAtIndex:(NSUInteger)idx withObject:(NSNumber *)anObject{

    [self.rowsHeight replaceObjectAtIndex:idx withObject:anObject];
}
- (void)replaceRowHeightsAtIndexes:(NSIndexSet *)indexes withRowHeights:(NSArray *)rowHeightArray{
    
    [self.rowsHeight replaceObjectsAtIndexes:indexes withObjects:rowHeightArray];
}

- (void)removeObjectFromRowHeightsAtIndex:(NSUInteger)idx{

    [self.rowsHeight removeObjectAtIndex:idx];
}
- (void)removeRowHeightsAtIndexes:(NSIndexSet *)indexes{

    [self.rowsHeight removeObjectsAtIndexes:indexes];
}

@end
