//
//  HLLSortA_ZDataSource.m
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLSortA_ZDataSource.h"
#import "HLLTimeZoneManager.h"
#import "HLLSortObject.h"


@interface HLLSortA_ZDataSource ()

@property (nonatomic) NSArray * regions;

@property (nonatomic) NSMutableDictionary * timeZoneDatas;

@end

@implementation HLLSortA_ZDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _timeZoneDatas = [NSMutableDictionary dictionary];
        
        NSArray * allTimeZones = [[HLLTimeZoneManager shareTimeZoneManager] allTimeZones];
        
        HLLSortObject * sort = [[HLLSortObject alloc] init];
        
        NSDictionary * sortDictionary = [sort sortCollection:allTimeZones
                            forEachObjectFromAToZWithKeyPath:@"localeName"];
        
        _timeZoneDatas = [NSMutableDictionary dictionaryWithDictionary:sortDictionary];
        
        NSArray * allKeys = [sort sortCollectioinAscendingOrder:self.timeZoneDatas.allKeys];
        
        _regions = allKeys;

    }
    return self;
}

#pragma mark - HLLSortProtocol

- (NSString *)cellIdentifier{

    return @"SortRegionsDataSource";
}

- (NSString *)name{

    return @"A_Z";
}

- (NSString *) navigationBarName{

    return @"Sort By A_Z";
}
- (UITableViewStyle) tableViewStyle{

    return UITableViewStyleGrouped;
}

- (id)elementForIndexPath:(NSIndexPath *)indexPath{

    NSArray * timeZones = [self.timeZoneDatas objectForKey:self.regions[indexPath.section]];
    HLLTimeZoneWrapper * timeZoneWrapper = timeZones[indexPath.row];
    
    return timeZoneWrapper;
}

- (Class)cellClass{

    return [UITableViewCell class];
}
#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.regions.count;
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.regions[section];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * timeZones = [self.timeZoneDatas objectForKey:self.regions[section]];
    return timeZones.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    
    NSArray * timeZones = [self.timeZoneDatas objectForKey:self.regions[indexPath.section]];
    HLLTimeZoneWrapper * timeZoneWrapper = timeZones[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",timeZoneWrapper.localeName ? : @" "];
    return cell;
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return self.regions;
}

@end
