//
//  OWXMultiUnitView.h
//  pickerView
//
//  Created by 王史超 on 2019/1/18.
//  Copyright © 2019 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWXPickerModel;

NS_ASSUME_NONNULL_BEGIN

@interface OWXMultiUnitView : UICollectionViewCell

- (void)setDataSource:(NSArray<OWXPickerModel *> * _Nullable)dataSource selectIndex:(NSInteger)selectIndex;

@property (nonatomic, copy) void (^selectCallBackBlock)(OWXPickerModel *model, NSInteger index);

@end

NS_ASSUME_NONNULL_END
