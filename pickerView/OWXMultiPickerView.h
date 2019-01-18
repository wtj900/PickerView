//
//  OWXMultiPickerView.h
//  pickerView
//
//  Created by 王史超 on 2019/1/17.
//  Copyright © 2019 offcn. All rights reserved.
//

#import "OWXBasePickerView.h"

@class OWXPickerModel;

typedef void(^OWXMultipleResultBlock)(NSArray<NSNumber *> *path, NSArray<OWXPickerModel *> *pathValue);

NS_ASSUME_NONNULL_BEGIN

@interface OWXMultiPickerView : OWXBasePickerView

+ (void)showMultiPickerWithTitle:(NSString *)title
                              dataSource:(NSArray<OWXPickerModel *> * _Nonnull)dataSource
                         defaultSelValue:(NSArray<NSNumber *> * _Nullable)defaultSelValue
                            isAutoSelect:(BOOL)isAutoSelect
                             resultBlock:(OWXMultipleResultBlock)resultBlock;

@end

NS_ASSUME_NONNULL_END
