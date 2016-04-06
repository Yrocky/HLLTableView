//
//  ViewController.m
//  HLLSelect-00
//
//  Created by Youngrocky on 16/4/3.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"
#import "HLLSelectCell.h"

#define CustomCell

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSIndexPath * selectedIndexPath;
@property (nonatomic ,strong) NSMutableArray * datas;
@end

static NSString * kCellIdentifier = @"selectCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select";
    
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    
    for (NSInteger index = 0; index < 30; index ++) {
        @autoreleasepool {
            
            NSString * item = [NSString stringWithFormat:@"%ld",(long)index];
            [_datas addObject:item];
        }
    }
    
#ifdef CustomCell
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HLLSelectCell" bundle:nil] forCellReuseIdentifier:@"selectCell"];
#else
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
#endif
}

#pragma mark - UITableViewDatasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.datas count];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectCell" forIndexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
#ifndef CustomCell
    
    if (_selectedIndexPath && _selectedIndexPath == indexPath) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
#endif
    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

#ifdef CustomCell
    
    HLLSelectCell * selectCell = (HLLSelectCell *)cell;
    selectCell.centerTitleLabel.text = [NSString stringWithFormat:@"This is No.%@",self.datas[indexPath.row]];
#else
    cell.textLabel.text = [NSString stringWithFormat:@"This is No.%@",self.datas[indexPath.row]];
#endif
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

#ifndef CustomCell
    
    _selectedIndexPath = indexPath;
    [tableView reloadData];
    return;
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];

    if (_selectedIndexPath) {
        
        // 取消上一次选择的accessoryType
        cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // 设置这一次选择的accessoryType
    cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    // 保存indexPath
    self.selectedIndexPath = indexPath;
    
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.5];
#endif
}

@end
