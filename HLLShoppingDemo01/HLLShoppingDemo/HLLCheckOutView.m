//
//  HLLCheckOutView.m
//  HLLShoppingDemo
//
//  Created by Youngrocky on 16/4/4.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLCheckOutView.h"


@interface HLLCheckOutView ()

@property (weak, nonatomic) IBOutlet UIButton *allSelectedButton;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkoutButton;

@end

@implementation HLLCheckOutView


- (instancetype)init{
    
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"HLLCheckOutView" owner:self options:nil] firstObject];
    }
    return self;
}

- (void)awakeFromNib{

    [super awakeFromNib];
    
    [self.allSelectedButton setImage:[UIImage imageNamed:@"CheckBox.png"] forState:UIControlStateNormal];
    [self.allSelectedButton setImage:[UIImage imageNamed:@"CheckBox_HL.png"] forState:UIControlStateSelected];
}
- (IBAction)allGoodsDIdSelected:(id)sender {
    
    self.allSelectedButton.selected = !self.allSelectedButton.selected;
}

@end
