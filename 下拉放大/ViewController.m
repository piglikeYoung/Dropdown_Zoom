//
//  ViewController.m
//  下拉放大
//
//  Created by piglikeyoung on 15/4/24.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "ViewController.h"

const CGFloat JHTopViewH = 350;

#define DeviceWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@property (nonatomic, weak) UIImageView *topView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置内边距(让cell往下移动一段距离)
    self.tableView.contentInset = UIEdgeInsetsMake(JHTopViewH * 0.5, 0, 0, 0);
    
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage imageNamed:@"biaoqingdi"];
    topView.frame = CGRectMake(0, -JHTopViewH, DeviceWidth, JHTopViewH);
    topView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView insertSubview:topView atIndex:0];
    self.topView = topView;
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据---%zd", indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下拽了多少距离
    CGFloat down = -(JHTopViewH *0.5) - scrollView.contentOffset.y;
    if (down < 0) return;
    
    CGRect frame = self.topView.frame;
    // 5决定图片变大的速度,值越大,速度越快
    frame.size.height = JHTopViewH + down * 5;
    self.topView.frame = frame;
}

@end
