//
//  OWXPickerModel.h
//  pickerView
//
//  Created by 王史超 on 2019/1/17.
//  Copyright © 2019 offcn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OWXPickerModel : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<OWXPickerModel *> *sub;

@end

NS_ASSUME_NONNULL_END
