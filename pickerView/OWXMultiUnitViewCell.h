//
//  OWXMultiUnitViewCell.h
//  pickerView
//
//  Created by 王史超 on 2019/1/17.
//  Copyright © 2019 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWXPickerModel;

NS_ASSUME_NONNULL_BEGIN

@interface OWXMultiUnitViewCell : UITableViewCell

- (void)setModel:(OWXPickerModel *)model select:(BOOL)select;

@end

NS_ASSUME_NONNULL_END
