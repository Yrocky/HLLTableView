//
//  HLLSectionHeaderView.m
//  HLLSectionHeaderDemo
//
//  Created by Youngrocky on 16/3/9.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLSectionHeaderView.h"

@implementation HLLSectionHeaderView

+ (UINib *)nib{

    UINib * nib = [UINib nibWithNibName:@"HLLSectionHeaderView" bundle:nil];
    return nib;
}

- (void)awakeFromNib{

    [super awakeFromNib];
    
    UIView * backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:108.0/255.0 blue:115.0/255.0 alpha:1];
    self.backgroundView = backgroundView;
    
    [self.button setImage:[UIImage imageNamed:@"ExplainJianTou_Select"] forState:UIControlStateSelected];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
    [self addGestureRecognizer:tap];
}
- (IBAction)toggleOpen:(id)sender {
    
    [self toggleOpenWithUserAction:YES];
}

- (void)toggleOpenWithUserAction:(BOOL)action{

    self.button.selected = !self.button.selected;
    
    if (action) {
        
        if (self.button.selected) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(sectionHeaderView:didOpenAtIndex:)]) {
                [self.delegate sectionHeaderView:self didOpenAtIndex:self.section];
            }
        }else{
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(sectionHeaderView:didCloseAtIndex:)]) {
                [self.delegate sectionHeaderView:self didCloseAtIndex:self.section];
            }
        }
    }
    
    
}
@end
