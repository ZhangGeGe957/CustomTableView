//
//  ZJQTableView.h
//  自定义TableView
//
//  Created by 张佳乔 on 2022/8/9.
//

#import <UIKit/UIKit.h>
#import "ZJQTableViewCell.h"

@protocol ZJQTableViewDelegate <NSObject>

// tableView的行数
- (NSInteger)numberOfRows;

// 展示行
- (ZJQTableViewCell *_Nullable)cellForRow:(NSInteger)row;

@end


NS_ASSUME_NONNULL_BEGIN

@interface ZJQTableView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView; // tableView框架
@property (nonatomic, strong) NSMutableSet *reuseCells; // 复用池
@property (nonatomic, strong) Class cellClass; // cell所属类
@property (nonatomic, strong) id datasource; // 数据代理

- (void)registerClassForCells:(Class)cellClass; // 获取类信息
- (ZJQTableViewCell *)dequeueReusableCell; // 从复用池中获取cell
- (void)refreshView; // 刷新数据

@end

NS_ASSUME_NONNULL_END
