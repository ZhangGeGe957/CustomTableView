//
//  ZJQTableViewCell.m
//  自定义TableView
//
//  Created by 张佳乔 on 2022/8/9.
//

#import "ZJQTableViewCell.h"

@implementation ZJQTableViewCell

- (id)init {
    self = [super init];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.textColor = [UIColor blackColor];
        [self addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews {
    self.label.frame = CGRectMake(15, 15, 200, 50);
    self.layer.borderWidth = 0.2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
