//
//  HLLGoodCell.m
//  HLLShoppingDemo
//
//  Created by Youngrocky on 16/4/4.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLGoodCell.h"

@interface HLLGoodCell ()
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIImageView *goodPictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodPriceLabel;

@end


static NSString * const kGoodPrice          = @"price";
static NSString * const kGoodName           = @"goodName";
static NSString * const kGoodPicture        = @"picture";

@implementation HLLGoodCell

+ (UINib *) nib{

    return [UINib nibWithNibName:@"HLLGoodCell" bundle:nil];
}

+ (NSString *) cellIdentifier{

    return @"HLLGoodCell";
}

- (void)configureCellWithGoodDictionary:(id)good{

    NSString * picture = [good objectForKey:kGoodPicture];
    self.goodPictureImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",picture]];
    self.goodNameLabel.text = [NSString stringWithFormat:@"%@",[good objectForKey:kGoodName]];
    self.goodPriceLabel.text = [NSString stringWithFormat:@"￥%@",[good objectForKey:kGoodPrice]];
}

- (void)awakeFromNib {
    // Initialization code
    [self.selectedButton setImage:[UIImage imageNamed:@"CheckBox.png"] forState:UIControlStateNormal];
    [self.selectedButton setImage:[UIImage imageNamed:@"CheckBox_HL.png"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goodDidSelected:(UIButton *)sender {
    
    if (self.selectedButton.selected) {
    }
    self.selectedButton.selected = !self.selectedButton.selected;
}

@end
