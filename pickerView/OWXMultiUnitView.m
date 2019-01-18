//
//  OWXMultiUnitView.m
//  pickerView
//
//  Created by 王史超 on 2019/1/18.
//  Copyright © 2019 offcn. All rights reserved.
//

#import "OWXMultiUnitView.h"
#import "OWXMultiUnitViewCell.h"

@interface OWXMultiUnitView ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<OWXPickerModel *> *dataSource;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation OWXMultiUnitView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupUI];
}

- (void)setupUI {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OWXMultiUnitViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OWXMultiUnitViewCell class])];
}

- (void)setDataSource:(NSArray<OWXPickerModel *> * _Nullable)dataSource selectIndex:(NSInteger)selectIndex {
    _dataSource = dataSource;
    _selectIndex = selectIndex;
    self.tableView.contentOffset = CGPointZero;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OWXPickerModel *model = self.dataSource[indexPath.row];
    
    OWXMultiUnitViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OWXMultiUnitViewCell class]) forIndexPath:indexPath];
    [cell setModel:model select:indexPath.row == self.selectIndex];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectIndex = indexPath.row;
    OWXPickerModel *model = self.dataSource[indexPath.row];
    [tableView reloadData];
    
    if (self.selectCallBackBlock) {
        self.selectCallBackBlock(model, indexPath.row);
    }
}

@end
