//
//  ViewController.m
//  HLLTimeZone
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self.dataSource;
    
    [self.tableView registerClass:[self.dataSource cellClass] forCellReuseIdentifier:[self.dataSource cellIdentifier]];
}

- (void)setDataSource:(id<UITableViewDataSource,HLLSortProtocol>)dataSource{
    
    _dataSource = dataSource;
    
    self.title = [dataSource name];
    
    self.navigationItem.title = [dataSource navigationBarName];
}
@end
