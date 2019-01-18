//
//  OWXMultiUnitViewCell.m
//  pickerView
//
//  Created by 王史超 on 2019/1/17.
//  Copyright © 2019 offcn. All rights reserved.
//

#import "OWXMultiUnitViewCell.h"
#import "OWXPickerModel.h"

@interface OWXMultiUnitViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (nonatomic, strong) OWXPickerModel *model;

@end

@implementation OWXMultiUnitViewCell

- (void)setModel:(OWXPickerModel *)model select:(BOOL)select {
    
    _model = model;
    
    self.titleLabel.text = model.name;
    self.titleLabel.textColor = select ? [UIColor blueColor] : [UIColor blackColor];
    self.checkImage.hidden = !select;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.bottomLine.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
