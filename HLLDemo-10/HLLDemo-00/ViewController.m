//
//  ViewController.m
//  HLLDemo-00
//
//  Created by Youngrocky on 16/3/16.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"


static NSString * const kTimeZoneCellIdentifier = @"timeZoneCellIdentifier";

@interface ViewController ()<UITableViewDataSource>

@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) NSMutableArray * regions;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Time Zones";
    
    // setter dataSource
    [self configureWithAllTimeZones];
    
    // configure tableView
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTimeZoneCellIdentifier];
    [self.view addSubview:self.tableView];
}

#pragma mark - Helper -

- (NSString *) replaceSolidusWithString:(NSString *)otherRegionName{

    return [otherRegionName stringByReplacingOccurrencesOfString:@"/" withString:@" "];
}
/**
 *  进行所有的时区的获取
 */
- (void) configureWithAllTimeZones{
    
    NSArray * knownTimeZoneNames = [NSTimeZone knownTimeZoneNames];
    
    NSMutableArray * regions = [NSMutableArray array];
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    for (NSString * timeZoneName in knownTimeZoneNames) {
        
        NSArray * fullTimeZoneNames = [timeZoneName componentsSeparatedByString:@"/"];
        
        NSString * regionName = fullTimeZoneNames[0];
        
        // GMT下面一个时区都没有
        if ([regionName  isEqual: @"GMT"]) {
            break;
        }
        NSString * otherRegionName = [timeZoneName substringFromIndex:regionName.length + 1];
        otherRegionName = [self replaceSolidusWithString:otherRegionName];
        
        if (![dict.allKeys containsObject:regionName]) {
            
            NSMutableArray * timeZones = [NSMutableArray array];
            [timeZones addObject:[NSString stringWithFormat:@"%@",otherRegionName]];
            [dict setObject:timeZones forKey:regionName];
        }else{
            
            NSMutableArray * timeZones = dict[regionName];
            [timeZones addObject:[NSString stringWithFormat:@"%@",otherRegionName]];
        }
    }
    
    // sort region
    NSArray * newKeys = [dict.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString * key1, NSString *key2) {
        
        return [key1 localizedCaseInsensitiveCompare:key2];
    }];
    
    // sort timeZone
    for (NSString * key in dict.allKeys) {
        NSArray * timeZones = dict[key];
        
        NSArray * temp = [timeZones sortedArrayUsingComparator:^NSComparisonResult(NSString * timeZone1, NSString *timeZone2) {
            
            return [timeZone1 localizedCaseInsensitiveCompare:timeZone2];
        }];
        
        [dict setObject:temp forKey:key];
    }
    
    for (NSString * newKey in newKeys) {
        
        NSDictionary * temp = @{newKey:dict[newKey]};
        
        [regions addObject:temp];
    }
    
    _regions = [NSMutableArray arrayWithArray:regions];
}

#pragma mark - UITableViewDataSource -

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSDictionary * dict = self.regions[section];
    NSArray * timeZones = dict.allValues.firstObject;
    
    return timeZones.count;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    NSDictionary * dict = self.regions[section];
    
    return [NSString stringWithFormat:@"%@",dict.allKeys.firstObject];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return self.regions.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTimeZoneCellIdentifier forIndexPath:indexPath];
    NSDictionary * dict = self.regions[indexPath.section];
    NSArray * timeZones = dict.allValues.firstObject;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",timeZones[indexPath.row]];
    return cell;
}
@end
