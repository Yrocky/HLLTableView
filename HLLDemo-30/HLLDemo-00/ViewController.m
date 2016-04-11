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

@interface ViewController ()<UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>

@property (nonatomic ,strong) HLLTimeZoneManager * manager;
@property (nonatomic ,strong) UITableView * tableView;

@property (nonatomic ,strong) UISearchController * searchController;

@property (nonatomic ,strong) NSArray * visibleResults;

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
    
    [self configureSearchController];
    
    _visibleResults = [self.manager allTimeZones];
}


- (void) configureSearchController{

    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;

    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    
    self.definesPresentationContext = YES;
}
#pragma mark - UITableViewDataSource -

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.visibleResults.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTimeZoneCellIdentifier forIndexPath:indexPath];
    
    HLLTimeZone * timeZone = self.visibleResults[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",timeZone.localeName];
    
    return cell;
}

#pragma mark - UISearchBarDelegate -


#pragma mark - UISearchResultsUpdating -

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{

    NSString * filterString = self.searchController.searchBar.text;
    
    if (!filterString || filterString.length <= 0) {
        self.visibleResults = [self.manager allTimeZones];
    }
    else {
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"self.localeName contains %@", filterString];
        
        self.visibleResults = [[self.manager allTimeZones] filteredArrayUsingPredicate:filterPredicate];
    }
    [self.tableView reloadData];
}

@end
