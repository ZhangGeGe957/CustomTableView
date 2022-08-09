//
//  ViewController.m
//  自定义TableView
//
//  Created by 张佳乔 on 2022/8/9.
//

#import "ViewController.h"
#import "ZJQTableView.h"

@interface ViewController () <ZJQTableViewDelegate>

@property (nonatomic, strong) ZJQTableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.array = [[NSMutableArray alloc] init];
    [self.array addObject:@"00000"];
    [self.array addObject:@"11111"];
    [self.array addObject:@"22222"];
    [self.array addObject:@"33333"];
    [self.array addObject:@"44444"];
    [self.array addObject:@"55555"];
    [self.array addObject:@"66666"];
    [self.array addObject:@"77777"];
    [self.array addObject:@"88888"];
    [self.array addObject:@"99999"];
    [self.array addObject:@"`````"];
    [self.array addObject:@"-----"];
    [self.array addObject:@"====="];
    
    self.tableView = [[ZJQTableView alloc] initWithFrame:self.view.frame];
    [self.tableView registerClassForCells:[ZJQTableView class]];
    self.tableView.datasource = self;
    [self.view addSubview:self.tableView];
}


// 数据展示
- (ZJQTableViewCell *)cellForRow:(NSInteger)row {
    ZJQTableViewCell *cell = [self.tableView dequeueReusableCell];
    cell.label.text = self.array[row];
    return cell;
}

// 返回行
- (NSInteger)numberOfRows {
    return self.array.count;
}

@end
