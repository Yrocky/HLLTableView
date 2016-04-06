//
//  HLLSelectCell.m
//  HLLSelect-00
//
//  Created by Youngrocky on 16/4/4.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLSelectCell.h"

@interface HLLSelectCell ()
@property (weak, nonatomic) IBOutlet UIImageView *checkoutImageView;

@end
@implementation HLLSelectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.checkoutImageView.image = [UIImage imageNamed:@"CheckBox_HL"];
    }else{
        self.checkoutImageView.image = [UIImage imageNamed:@"CheckBox"];
    }
    // Configure the view for the selected state
}

@end
