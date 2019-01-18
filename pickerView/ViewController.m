//
//  ViewController.m
//  pickerView
//
//  Created by 王史超 on 2019/1/17.
//  Copyright © 2019 offcn. All rights reserved.
//

#import "ViewController.h"
#import "OWXPickerView.h"
#import "OWXPickerModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(showPickerView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showPickerView {
    
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        OWXPickerModel *model1 = [OWXPickerModel new];
        model1.name = [NSString stringWithFormat:@"1-%d号",i];
        NSMutableArray *array1 = [[NSMutableArray alloc] init];
        for (int j = 0; j < 10; j++) {
            OWXPickerModel *model2 = [OWXPickerModel new];
            model2.name = [NSString stringWithFormat:@"2-%d-%d号", i ,j];
            NSMutableArray *array2 = [[NSMutableArray alloc] init];
            for (int z = 0; z < 10; z++) {
                OWXPickerModel *model3 = [OWXPickerModel new];
                model3.name = [NSString stringWithFormat:@"3-%d-%d-%d号",i, j, z];
                NSMutableArray *array3 = [[NSMutableArray alloc] init];
                for (int a = 0; a < 10; a++) {
                    OWXPickerModel *model4 = [OWXPickerModel new];
                    model4.name = [NSString stringWithFormat:@"4-%d-%d-%d-%d号",i, j, z, a];
                    NSMutableArray *array4 = [[NSMutableArray alloc] init];
                    for (int b = 0; b < 10; b++) {
                        OWXPickerModel *model5 = [OWXPickerModel new];
                        model5.name = [NSString stringWithFormat:@"5-%d-%d-%d-%d-%d号",i, j, z, b, b];
                        [array4 addObject:model5];
                    }
                    model4.sub = array4;
                    [array3 addObject:model4];
                }
                model3.sub = array3;
                [array2 addObject:model3];
            }
            model2.sub = array2;
            [array1 addObject:model2];
        }
        model1.sub = array1;
        [dataSource addObject:model1];
    }
    
    [OWXMultiPickerView showMultiPickerWithTitle:@"哈哈" dataSource:dataSource defaultSelValue:@[@2,@1,@3,@2,@2] isAutoSelect:NO resultBlock:^(NSArray<NSNumber *> *path, NSArray<OWXPickerModel *> *pathValue) {
        NSLog(@"%@--%@",path, pathValue);
    }];
    
}


@end
