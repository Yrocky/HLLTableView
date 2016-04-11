//
//  HLLSortRegionsDataSource.m
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLSortRegionsDataSource.h"
#import "HLLTimeZoneManager.h"

@interface HLLSortRegionsDataSource ()

@property (nonatomic) NSArray * regions;

@end

@implementation HLLSortRegionsDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSArray * knownRegions = [[HLLTimeZoneManager shareTimeZoneManager] knownRegions];
        
        _regions = knownRegions;
    }
    return self;
}

#pragma mark - HLLSortProtocol

- (NSString *)cellIdentifier{
    
    return @"SortRegionsDataSource";
}

- (NSString *)name{
    
    return @"Regions";
}
- (NSString *) navigationBarName{
    
    return @"Sort By Regions";
}
- (UITableViewStyle) tableViewStyle{
    
    return UITableViewStyleGrouped;
}

- (id)elementForIndexPath:(NSIndexPath *)indexPath{
    
    HLLRegion * region = self.regions[indexPath.section];
    HLLTimeZoneWrapper * timeZoneWrapper = region.timeZoneWrappers[indexPath.row];
    
    return timeZoneWrapper;
}
- (Class)cellClass{
    
    return [UITableViewCell class];
}
#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    HLLRegion * region = self.regions[section];
    return [region.timeZoneWrappers count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.regions count];
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    HLLRegion * region = self.regions[section];
    return region.name;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    
    HLLRegion * region = self.regions[indexPath.section];
    HLLTimeZoneWrapper * timeZoneWrapper = region.timeZoneWrappers[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",timeZoneWrapper.localeName ? : @" "];
    
    return cell;
}

@end
