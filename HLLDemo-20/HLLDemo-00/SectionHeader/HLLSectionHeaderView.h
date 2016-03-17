//
//  HLLSectionHeaderView.h
//  HLLSectionHeaderDemo
//
//  Created by Youngrocky on 16/3/9.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLLSectionHeaderView;

@protocol HLLSectionHeaderViewDelegate <NSObject>

@optional
// Open
- (void) sectionHeaderView:(HLLSectionHeaderView *)sectionHeaderView didOpenAtIndex:(NSInteger)index;

// Close
- (void) sectionHeaderView:(HLLSectionHeaderView *)sectionHeaderView didCloseAtIndex:(NSInteger)index;

@end
@interface HLLSectionHeaderView : UITableViewHeaderFooterView

// UI
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (nonatomic ,weak) id<HLLSectionHeaderViewDelegate>delegate;
@property (nonatomic ,assign) NSInteger section;

+ (UINib *) nib;

- (void) toggleOpenWithUserAction:(BOOL)action;

@end
