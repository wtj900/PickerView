//
//  OWXPickerAddressItemView.m
//  pickerView
//
//  Created by 王史超 on 2019/1/18.
//  Copyright © 2019 offcn. All rights reserved.
//

#import "OWXPickerAddressItemView.h"

@interface OWXPickerAddressItemView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end

@implementation OWXPickerAddressItemView

- (void)setTitle:(NSString *)title select:(BOOL)select {
    
    self.titleLabel.text = title;
    self.titleLabel.textColor = select ? [UIColor redColor] : [UIColor blackColor];
    self.bottomLine.hidden = !select;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (NSInteger)titleWidth:(NSString *)title {
    
    return [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil].size.width + 30;
    
}

@end
