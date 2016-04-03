//
//  HLLGoodCell.h
//  HLLShoppingDemo
//
//  Created by Youngrocky on 16/4/4.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLLGoodCell : UITableViewCell

+ (UINib *) nib;

+ (NSString *) cellIdentifier;

- (void) configureCellWithGoodDictionary:(id)good;
@end
