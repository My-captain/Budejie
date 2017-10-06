//
//  MRTextField.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/23.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRTextField.h"

#define MRPlaceholderLabel @"_placeholderLabel.textColor"

@implementation MRTextField
 
- (void)awakeFromNib{
    
    self.tintColor = self.textColor;
    [self resignFirstResponder];
    
    [super awakeFromNib];
}

- (BOOL)becomeFirstResponder{
    [self setValue:self.textColor forKeyPath:MRPlaceholderLabel];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:MRPlaceholderLabel];
    return [super resignFirstResponder];
}


@end
