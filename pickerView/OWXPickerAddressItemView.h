//
//  OWXPickerAddressItemView.h
//  pickerView
//
//  Created by 王史超 on 2019/1/18.
//  Copyright © 2019 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OWXPickerAddressItemView : UICollectionViewCell

- (void)setTitle:(NSString *)title select:(BOOL)select;

+ (NSInteger)titleWidth:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
