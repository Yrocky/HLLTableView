//
//  HLLBusinessHeaderView.h
//  HLLShoppingDemo
//
//  Created by Youngrocky on 16/4/4.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLLBusinessHeaderView : UITableViewHeaderFooterView


+ (UINib *) nib;

+ (NSString *) sectionHeaderIdentifier;

- (void) configureSectionHeaderView:(id)business;
@end
