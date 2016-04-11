//
//  HLLNormalDataSource.m
//  HLLTimeZone
//
//  Created by Youngrocky on 16/4/12.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLNormalDataSource.h"
#import "HLLTimeZoneManager.h"
#import "HLLSortObject.h"


@interface HLLNormalDataSource ()

@property (nonatomic) HLLTimeZoneManager * manager;

@property (nonatomic) NSArray * timeZones;

@end

@implementation HLLNormalDataSource


- (instancetype)init
{
    self = [super init];
    if (self) {

        _manager = [HLLTimeZoneManager shareTimeZoneManager];
        
        _timeZones = [_manager allTimeZones];
        
    }
    return self;
}


#pragma mark - HLLSortProtocol

- (NSString *)cellIdentifier{
    
    return @"SortNormalDataSource";
}

- (NSString *)name{
    
    return @"Normal";
}

- (NSString *) navigationBarName{
    
    return @"Sort By Normal";
}
- (UITableViewStyle) tableViewStyle{
    
    return UITableViewStylePlain;
}

- (id)elementForIndexPath:(NSIndexPath *)indexPath{
    
    return self.timeZones[indexPath.row];
}

- (Class)cellClass{
    
    return [UITableViewCell class];
}
#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.timeZones.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    
    HLLTimeZoneWrapper * timeZone = self.timeZones[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",timeZone.localeName ? timeZone.localeName : @" "];
    
    return cell;
}

@end
