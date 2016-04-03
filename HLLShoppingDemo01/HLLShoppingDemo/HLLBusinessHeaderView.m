//
//  HLLBusinessHeaderView.m
//  HLLShoppingDemo
//
//  Created by Youngrocky on 16/4/4.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLBusinessHeaderView.h"


@interface HLLBusinessHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *bunisnessNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;

@end

static NSString * const kBusinessName       = @"businessName";

@implementation HLLBusinessHeaderView
+ (UINib *) nib{

    return [UINib nibWithNibName:@"HLLBusinessHeaderView" bundle:nil];
}

+ (NSString *) sectionHeaderIdentifier{

    return @"HLLBusinessHeaderView";
}

- (void)configureSectionHeaderView:(id)business{

    NSString * businessName = [business objectForKey:kBusinessName];
    
    self.bunisnessNameLabel.text = [NSString stringWithFormat:@"%@",businessName];
}
- (void)awakeFromNib{

    [super awakeFromNib];
    
    UIView * backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = backgroundView;
    
    [self.allSelectButton setImage:[UIImage imageNamed:@"CheckBox.png"] forState:UIControlStateNormal];
    [self.allSelectButton setImage:[UIImage imageNamed:@"CheckBox_HL.png"] forState:UIControlStateSelected];
}
- (IBAction)allGoodDIdSelected:(id)sender {
    
    self.allSelectButton.selected = !self.allSelectButton.selected;
}

- (void)drawRect:(CGRect)rect{

    [super drawRect:rect];
    
//    CAShapeLayer * lineLayer = [CAShapeLayer layer];
//    UIBezierPath * path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 0)];
//    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect), 0)];
//    path.lineWidth = .5f;
//    lineLayer.path = path.CGPath;
//    lineLayer.strokeColor = [UIColor colorWithWhite:.5 alpha:0.4].CGColor;
//    [self.layer addSublayer:lineLayer];
}
@end
