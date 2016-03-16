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
@property (nonatomic ,strong) NSMutableArray * timeZones;
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

/**
 *  进行所有的时区的获取
 */
- (void) configureWithAllTimeZones{
    
    NSMutableArray * timeZones = [[NSTimeZone knownTimeZoneNames] mutableCopy];
    
    [timeZones sortUsingComparator:^NSComparisonResult(NSString * timeZone1,NSString * timeZone2) {
        return [timeZone1 localizedStandardCompare:timeZone2];
    }];
    
    _timeZones = [NSMutableArray arrayWithArray:timeZones];
}

#pragma mark - UITableViewDataSource -

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.timeZones.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTimeZoneCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.timeZones[indexPath.row]];
    return cell;
}
@end
