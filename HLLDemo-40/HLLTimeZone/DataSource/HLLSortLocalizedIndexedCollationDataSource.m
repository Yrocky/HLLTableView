//
//  HLLSortLocalizedIndexedCollationDataSource.m
//  HLLTimeZone
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLSortLocalizedIndexedCollationDataSource.h"
#import "HLLTimeZoneManager.h"

@interface HLLSortLocalizedIndexedCollationDataSource ()

@property (nonatomic) NSMutableArray * timeZonesArray;

@property (nonatomic) NSMutableArray * sectioinsArray;

@property (nonatomic) UILocalizedIndexedCollation * collection;

@end

@implementation HLLSortLocalizedIndexedCollationDataSource


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray * allTimeZones = [[HLLTimeZoneManager shareTimeZoneManager] allTimeZones];
        for (HLLTimeZoneWrapper * timeZone in allTimeZones) {
            if (timeZone.localeName == nil) {
                NSLog(@"nil:%lu",(unsigned long)[allTimeZones indexOfObject:timeZone]);
            }
        }
        [self configureDataSourceWithArray:allTimeZones];
//        self.timeZonesArray = [allTimeZones mutableCopy];
    }
    return self;
}
#pragma mark - HLLSortProtocol

- (NSString *)cellIdentifier{
    
    return @"SortLocationIndexCollationDataSource";
}

- (NSString *)name{
    
    return @"Collation";
}

- (NSString *) navigationBarName{
    
    return @"Collation DataSource";
}

- (UITableViewStyle) tableViewStyle{
    
    return UITableViewStylePlain;
}

- (id)elementForIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * timeZones = self.sectioinsArray[indexPath.section];
    
    HLLTimeZoneWrapper * timeZoneWrapper = timeZones[indexPath.row];
    
    return timeZoneWrapper;
}
- (Class)cellClass{
    
    return [UITableViewCell class];
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray * timeZones = self.sectioinsArray[section];
    
    return timeZones.count;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return [[self.collection sectionTitles] count];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    
    NSArray * timeZones = self.sectioinsArray[indexPath.section];
    
    HLLTimeZoneWrapper * timeZoneWrapper = timeZones[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",timeZoneWrapper.localeName ? : @" "];

    return cell;
}

// 返回每一个对应Section的内容
// 如果使用UILocationIndexCollection，可以使用`-sectionTitles`数组中的对象
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return [self.collection sectionTitles][section];
}

// 返回一个区域索引标题的数组，用于在列表右边显示，例如字母序列 A...Z 和 #。注意，区域索引标题很短，通常不能多于两个 Unicode 字符。
// 如果使用UILocationIndexCollection，可以使用`-sectionIndexTitles`方法返回索引数组
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    NSMutableArray * array = [NSMutableArray arrayWithArray:[self.collection sectionIndexTitles]];
//    [array insertObject:UITableViewIndexSearch atIndex:0];
    return array;
}

// 提供一个NSInteger类型的值，当点击返回当用户触摸到某个索引标题时列表应该跳至的区域的索引，比如B-1
// 如果使用UILocationIndexCollection，可以通过`-sectionForSectionIndexTitleAtIndex:`方法进行返回点击到侧边栏的字母要跳转到的Section区域
- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{

    return [self.collection sectionForSectionIndexTitleAtIndex:index];
}

#pragma mark - Private

- (void)setTimeZonesArray:(NSMutableArray *)timeZonesArray{

    if (timeZonesArray != _timeZonesArray) {
        _timeZonesArray = [timeZonesArray mutableCopy];
        if (_timeZonesArray == nil) {
            _sectioinsArray = nil;
        }else{
            [self configureDataSource];
        }
    }
}

- (void) configureDataSource{
    
    [self configureDataSourceWithArray:self.timeZonesArray];
}


- (void) configureDataSourceWithArray:(NSArray *)array{

    
    _collection = [UILocalizedIndexedCollation currentCollation];
    
    NSInteger index ,sectionTitlesCount = [self.collection sectionTitles].count;
    
    NSMutableArray * newSectionsArray = [NSMutableArray array];
    
    //    获得所有的sections数组
    for (NSInteger index = 0; index < sectionTitlesCount; index ++) {
        
        NSMutableArray * sections = [NSMutableArray array];
        
        [newSectionsArray addObject:sections];
    }
    
    // 对每一个section数组进行对象的填充
    for (HLLTimeZoneWrapper * timeZone in array) {
        
        // 获得每个对象所在的section
        NSInteger sectionNumber = [self.collection sectionForObject:timeZone collationStringSelector:@selector(localeName)];
        
        // 通过setionNumber取出改section数组
        NSMutableArray * secitonTimeZones = newSectionsArray[sectionNumber];
        
        // 把属于该section的对象放入数组section数组中
        [secitonTimeZones addObject:timeZone];
    }
    
    // 下面就是要对section数组中的对象进行排序了
    for (index = 0; index < sectionTitlesCount; index ++) {
        
        // 原始的对应section下的TimeZone数组
        NSArray * timeZonesArray = newSectionsArray[index];
        
        //  排过序之后的section下的TimeZone数组
        // 注意这里如果tableView是可以编辑的，就需要使用mutable copy
        NSArray * sortedTimeZonesArray = [self.collection sortedArrayFromArray:timeZonesArray collationStringSelector:@selector(localeName)];
        
        // 替换掉原来的TimeZone数组
        [newSectionsArray replaceObjectAtIndex:index withObject:sortedTimeZonesArray];
    }
    
    self.sectioinsArray = newSectionsArray;

}
@end
