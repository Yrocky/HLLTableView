//
//  HLLSortProtocol.h
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HLLSortProtocol <NSObject>

@required

@property (readonly) NSString *name;

@property (readonly) NSString *navigationBarName;

@property (readonly) UITableViewStyle tableViewStyle;

- (id)elementForIndexPath:(NSIndexPath *)indexPath;

- (NSString *)cellIdentifier;

- (Class) cellClass;

@optional

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;

@end
