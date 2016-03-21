//
//  HLLTimeZoneCell.h
//  HLLDemo-00
//
//  Created by Youngrocky on 16/3/19.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLLTimeZone;

@interface HLLTimeZoneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeZoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timeImageView;

+ (UINib *) nib;

- (void) configureTimeZoneCellWithTimeZone:(HLLTimeZone *)timeZone;
@end
