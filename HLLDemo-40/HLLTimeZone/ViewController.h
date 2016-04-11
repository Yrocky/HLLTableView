//
//  ViewController.h
//  HLLTimeZone
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLSortProtocol.h"

@interface ViewController : UIViewController

@property (nonatomic ,strong) id<UITableViewDataSource,HLLSortProtocol> dataSource;

@end

