//
//  ViewController.m
//  HLLSelect-00
//
//  Created by Youngrocky on 16/4/3.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic ,strong) NSMutableArray * datas;
@end

static NSString * kCellIdentifier = @"item";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select";
    
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    
    for (NSInteger index = 0; index < 20; index ++) {
        @autoreleasepool {
            
            NSString * item = [NSString stringWithFormat:@"%ld",(long)index];
            [_datas addObject:item];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
}

#pragma mark - Private
- (UIView *) _tableViewDidSelectedRow:(NSIndexPath *)selectedIndexPath{

    UIView * selectedView = [UIView new];
    selectedView.backgroundColor = [UIColor orangeColor];
    
    UILabel * textLabel = [UILabel new];
    textLabel.frame = CGRectMake(100, 0, 100, 44);
    textLabel.text = [NSString stringWithFormat:@"%ld",(long)selectedIndexPath.row];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentRight;
    [selectedView addSubview:textLabel];
    
    return selectedView;
}
#pragma mark - UITableViewDatasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.datas count];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.textLabel.text = [NSString stringWithFormat:@"This is No.%@",self.datas[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%d",cell.selectionStyle);
//
//    if (cell.selected) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }else{
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
