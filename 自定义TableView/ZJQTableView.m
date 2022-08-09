//
//  ZJQTableView.m
//  自定义TableView
//
//  Created by 张佳乔 on 2022/8/9.
//

#import "ZJQTableView.h"

#define ZJQ_ROW_HEIGHT 80

@implementation ZJQTableView

// 初始化
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        [self addSubview:self.scrollView];
        self.scrollView.delegate = self;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.reuseCells = [[NSMutableSet alloc] init];
    }
    return self;
}

// 获取类信息
- (void)registerClassForCells:(Class)cellClass {
    self.cellClass = cellClass;
}

// 从复用池中获取cell
- (ZJQTableViewCell *)dequeueReusableCell {
    // 从set列表中获取可重用cell View
    ZJQTableViewCell* cell = [self.reuseCells anyObject];
    if (cell) {
        NSLog(@"add cell");
        [self.reuseCells removeObject:cell];
    }

    // 创建新的
    if (!cell) {
        NSLog(@"new cell");
        cell = [[ZJQTableViewCell alloc] init];
    }
    return cell;
}

// 每次添加子视图（即添加cell）时会调用
- (void)layoutSubviews {
    [super layoutSubviews];
    [self refreshView];
}

// 刷新数据
- (void)refreshView {
    // 为Null直接返回就行了
    if (CGRectIsNull(self.scrollView.frame)) {
        return;
    }
    
    // 根据row数量，设置scrollview的高度
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, [self.datasource numberOfRows] * ZJQ_ROW_HEIGHT);
    
    // 循环得出scrollView中子视图并去掉所用不可用的cell
    for (ZJQTableViewCell *cellView in [self cellSubView]) {
        // 超过scrollView的frame上边界的cell视图
        if (cellView.frame.origin.y + cellView.frame.size.height < self.scrollView.contentOffset.y) {
            [self recycelCell:cellView];
        }
        // 超过scrollView的frame下边界的cell视图
        if (cellView.frame.origin.y > self.scrollView.contentOffset.y + self.frame.size.height) {
            [self recycelCell:cellView];
        }
    }
    
    // 展示可见的cell
    int firstVisibleIndex = MAX(0, (float)(self.scrollView.contentOffset.y / ZJQ_ROW_HEIGHT));
    int lastVisibleIndex =  MIN([self.datasource numberOfRows], firstVisibleIndex + 1 + ceil(self.scrollView.frame.size.height / ZJQ_ROW_HEIGHT)); // ceil用于取整
    
    // 循环展示数据
    for (int row = firstVisibleIndex; row < lastVisibleIndex; row++) {
        // 从委托方法中获取cell
        ZJQTableViewCell *cell = [self cellForRow:row];
        if (!cell) {
            ZJQTableViewCell *cell = [self.datasource cellForRow:row];
            float topEdgeFowRow = row * ZJQ_ROW_HEIGHT;
            cell.frame = CGRectMake(0, topEdgeFowRow, self.scrollView.frame.size.width, ZJQ_ROW_HEIGHT);
            [self.scrollView insertSubview:cell atIndex:0];
        }
    }
}

// 循环出scrollView中所有的subview（SHCTableViewCell类型）
- (NSArray *)cellSubView {
    NSMutableArray *cells = [[NSMutableArray alloc] init];
    for (UIView *subView in self.scrollView.subviews) {
        if ([subView isKindOfClass:[ZJQTableViewCell class]]) {
            [cells addObject:subView];
        }
    }
    return [cells copy];
}

// 回收cell，存到复用池中且从父视图(scrollView)展示中删除
- (void)recycelCell:(UIView *)cell {
    [self.reuseCells addObject:cell];
    [cell removeFromSuperview];
}

// 滚动scrollView时调用，刷新数据
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self refreshView];
}


// 返回给定行的cell视图
- (ZJQTableViewCell *)cellForRow:(NSInteger)row {
    float topEdgeForRow = row * ZJQ_ROW_HEIGHT;
    for (ZJQTableViewCell *cellView in [self cellSubView]) {
        if (cellView.frame.origin.y == topEdgeForRow) {
            return cellView;
        }
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
