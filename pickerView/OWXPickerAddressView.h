//
//  OWXPickerAddressView.h
//  pickerView
//
//  Created by 王史超 on 2019/1/18.
//  Copyright © 2019 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OWXPickerAddressView : UICollectionView

@property (nonatomic, copy) NSArray<NSString *> * _Nullable addressPath;

@property (nonatomic, copy) void (^selectCallBackBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
