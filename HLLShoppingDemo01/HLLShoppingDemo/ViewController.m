//
//  ViewController.m
//  HLLShoppingDemo
//
//  Created by Youngrocky on 16/4/4.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"
#import "HLLGoodCell.h"
#import "HLLBusinessHeaderView.h"
#import "HLLCheckOutView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic ,strong) NSArray * datas;

@end

@implementation ViewController

static NSString * const kBusinessGoods      = @"goods";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadDatas];
    [self addTableView];
    [self addToolView];
}

#pragma mark - Private

- (void) addToolView{

    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = CGRectGetHeight(self.view.frame) - 0;

    HLLCheckOutView * checkoutView = [[HLLCheckOutView alloc] init];
    checkoutView.frame = CGRectMake(0, h - 50.0f, w, 50.0f);
    checkoutView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:checkoutView];
    
}
- (void) addTableView{

    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = CGRectGetHeight(self.view.frame) - 50;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, w, h) style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60.0f;
    self.tableView.sectionHeaderHeight = 50.0f;
    [self.tableView registerNib:[HLLBusinessHeaderView nib] forHeaderFooterViewReuseIdentifier:[HLLBusinessHeaderView sectionHeaderIdentifier]];
    [self.tableView registerNib:[HLLGoodCell nib] forCellReuseIdentifier:[HLLGoodCell cellIdentifier]];

    [self.view addSubview:self.tableView];
}
- (void) loadDatas{

    NSString * path = [[NSBundle mainBundle] pathForResource:@"shoppingList" ofType:@"plist"];
    _datas = [NSArray arrayWithContentsOfFile:path];
}
#pragma mark - UITableViewDatasource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return [self.datas count];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary * business = [self.datas objectAtIndex:section];
    NSArray * goods = [business objectForKey:kBusinessGoods];
    return [goods count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HLLGoodCell cellIdentifier] forIndexPath:indexPath];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * business = [self.datas objectAtIndex:indexPath.section];
    NSArray * goods = [business objectForKey:kBusinessGoods];
    
    HLLGoodCell * goodCell = (HLLGoodCell *)cell;
    [goodCell configureCellWithGoodDictionary:[goods objectAtIndex:indexPath.row]];
}

#pragma mark - UITableViewDelegate

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    HLLBusinessHeaderView * sectionHeaderView = (HLLBusinessHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:[HLLBusinessHeaderView sectionHeaderIdentifier]];
    
    NSDictionary * business = [self.datas objectAtIndex:section];
    [sectionHeaderView configureSectionHeaderView:business];
    
    return  sectionHeaderView;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
