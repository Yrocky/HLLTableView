//
//  ViewController.m
//  HLLDemo-00
//
//  Created by Youngrocky on 16/3/16.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"
#import "HLLTimeZoneManager.h"


static NSString * const kTimeZoneCellIdentifier = @"timeZoneCellIdentifier";

@interface ViewController ()<UITableViewDataSource>
@property (nonatomic ,strong) HLLTimeZoneManager * manager;
@property (nonatomic ,strong) UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Time Zones";
    
    // setter timeZoneManager
    _manager = [HLLTimeZoneManager shareTimeZoneManager];
    
    // configure tableView
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTimeZoneCellIdentifier];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource -

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    HLLRegion * region = [self.manager knownRegions][section];
    
    return [region.timeZones count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    HLLRegion * region = [self.manager knownRegions][section];
    
    return region.name;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return [self.manager.knownRegions count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTimeZoneCellIdentifier forIndexPath:indexPath];
    HLLRegion * region = [self.manager knownRegions][indexPath.section];
    HLLTimeZone * timeZone = region.timeZones[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",timeZone.localeName];
    
    return cell;
}
@end
