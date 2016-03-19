//
//  ViewController.m
//  HLLDemo-00
//
//  Created by Youngrocky on 16/3/16.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"
#import "HLLTimeZoneManager.h"
#import "HLLSectionHeaderView.h"
#import "HLLSectionInfo.h"

static NSString * const kTimeZoneCellIdentifier = @"timeZoneCellIdentifier";
static NSString * const kSectionHeaderViewIdentifier = @"sectionHeaderViewIdentifier";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,HLLSectionHeaderViewDelegate>

// UI
@property (nonatomic ,strong) UITableView * tableView;

// Data
@property (nonatomic ,strong) HLLTimeZoneManager * manager;
@property (nonatomic ,strong) NSMutableArray * sectionInfoArray;
@property (nonatomic ,assign) NSInteger openSectionIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Time Zones";
    
    // setter timeZoneManager
    _manager = [HLLTimeZoneManager shareTimeZoneManager];

    // init
    _openSectionIndex = NSNotFound;
    
    // configure tableView
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.sectionHeaderHeight = 50.0f;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTimeZoneCellIdentifier];
    [_tableView registerNib:[HLLSectionHeaderView nib] forHeaderFooterViewReuseIdentifier:kSectionHeaderViewIdentifier];
    [self.view addSubview:self.tableView];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (self.sectionInfoArray == nil ||
        self.sectionInfoArray.count != [self numberOfSectionsInTableView:self.tableView]) {
        
        NSMutableArray * temp = [NSMutableArray array];
        
        for (HLLRegion * region in [self.manager knownRegions]) {
            
            HLLSectionInfo * sectionInfo = [[HLLSectionInfo alloc] init];
            sectionInfo.region = region;
            sectionInfo.open = NO;
            
            NSNumber * rowHeight = @(44);
            NSInteger rowsCount = region.timeZones.count;
            
            for (NSInteger index = 0; index < rowsCount; index ++) {
                
                [sectionInfo insertObject:rowHeight forRowHeightAtIndex:index];
            }
            [temp addObject:sectionInfo];
        }
        
        self.sectionInfoArray = temp;
    }
}
#pragma mark - UITableViewDataSource -

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    HLLSectionInfo * sectionInfo = self.sectionInfoArray[section];
    NSInteger timeZones = sectionInfo.region.timeZones.count;

    return sectionInfo.isOpen ? timeZones : 0;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionInfoArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTimeZoneCellIdentifier forIndexPath:indexPath];
    
    HLLSectionInfo * sectionInfo = self.sectionInfoArray[indexPath.section];
    HLLRegion * region = sectionInfo.region;
    HLLTimeZone * timeZone = region.timeZones[indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@",timeZone.localeName];
    
    return cell;
}

#pragma mark - UITableViewDelegate -

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HLLSectionHeaderView * sectionHeaderView = (HLLSectionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:kSectionHeaderViewIdentifier];
    sectionHeaderView.delegate = self;
    sectionHeaderView.section = section;
    
    HLLSectionInfo * sectionInfo = self.sectionInfoArray[section];
    sectionInfo.sectionHeaderView = sectionHeaderView;
    sectionHeaderView.titleLabel.text = sectionInfo.region.name;
    sectionHeaderView.countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)sectionInfo.region.timeZones.count];
    return sectionHeaderView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HLLSectionInfo * sectionInfo = self.sectionInfoArray[indexPath.section];
    CGFloat rowHeight = [[sectionInfo objectInRowsHeightAtIndex:indexPath.row] floatValue];
    
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - HLLSectionHeaderViewDelegate -

- (void)sectionHeaderView:(HLLSectionHeaderView *)sectionHeaderView
          didCloseAtIndex:(NSInteger)section{
    
    HLLSectionInfo * sectionInfo = self.sectionInfoArray[section];
    sectionInfo.open = NO;
    
    NSInteger countOfRowsToDelete = [self.tableView numberOfRowsInSection:_openSectionIndex];

    if (countOfRowsToDelete > 0) {
        
        NSMutableArray * indexPathToDelete = [NSMutableArray array];
        
        for (NSInteger row = 0; row < countOfRowsToDelete; row ++) {
            [indexPathToDelete addObject:[NSIndexPath indexPathForRow:row inSection:section]];
        }
        [self.tableView deleteRowsAtIndexPaths:indexPathToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
}

- (void)sectionHeaderView:(HLLSectionHeaderView *)sectionHeaderView
           didOpenAtIndex:(NSInteger)section{
    
    HLLSectionInfo * sectionInfo = self.sectionInfoArray[section];
    sectionInfo.open = YES;
    
    // 添加row给tableView
    NSInteger rowCount = sectionInfo.region.timeZones.count;
    NSMutableArray * indexPathToInsert = [NSMutableArray array];
    
    for (NSInteger row = 0; row < rowCount; row ++) {
        [indexPathToInsert addObject:[NSIndexPath indexPathForRow:row inSection:section]];
    }
    
    // 如果是已经有sectionHeaderView打开了，就将他下面的row都关闭
    NSMutableArray * indexPathToDelete = [NSMutableArray array];
    
    if (self.openSectionIndex != NSNotFound) {
        
        // 取出已经打开的section，对其进行关闭操作
        HLLSectionInfo * openSectionInfo = self.sectionInfoArray[self.openSectionIndex];
        openSectionInfo.open = NO;
        [openSectionInfo.sectionHeaderView toggleOpenWithUserAction:NO];
        for (NSInteger row = 0; row < openSectionInfo.region.timeZones.count; row ++) {
            [indexPathToDelete addObject:[NSIndexPath indexPathForRow:row inSection:self.openSectionIndex]];
        }
    }
    
    // 设置动画效果
    UITableViewRowAnimation animationWithDelete;
    UITableViewRowAnimation animationWithInsert;
    
    if (self.openSectionIndex == NSNotFound ||
        section < self.openSectionIndex) {
        animationWithInsert = UITableViewRowAnimationTop;
        animationWithDelete = UITableViewRowAnimationBottom;
    }else{
        animationWithInsert = UITableViewRowAnimationBottom;
        animationWithDelete = UITableViewRowAnimationTop;
    }
    
    // 更新UI
    [self.tableView beginUpdates];
    
    [self.tableView deleteRowsAtIndexPaths:indexPathToDelete withRowAnimation:animationWithDelete];
    [self.tableView insertRowsAtIndexPaths:indexPathToInsert withRowAnimation:animationWithInsert];
    
    [self.tableView endUpdates];
    
    self.openSectionIndex = section;
}
@end
