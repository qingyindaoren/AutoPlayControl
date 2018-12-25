//
//  ViewController.m
//  TestTable
//
//  Created by mc on 2018/11/5.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "ViewController.h"
#import "VideoView.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *expressAdViews;
@end

@implementation ViewController
-(NSMutableArray *)expressAdViews{
    if (!_expressAdViews) {
        _expressAdViews = [NSMutableArray array];
        for (int i = 0; i<20; i++) {
            UIView *v = [VideoView new];
            [_expressAdViews addObject:v];
        }
      
    }
    return _expressAdViews;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,88, ScreenWidth, ScreenHeight-88) style:UITableViewStylePlain];
  
         [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nativeexpresscell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     [self.view addSubview:self.tableView];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoView *v = self.expressAdViews[indexPath.row];
    return v.frame.size.height ;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    

        cell = [self.tableView dequeueReusableCellWithIdentifier:@"nativeexpresscell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
        UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
        if ([subView superview]) {
            [subView removeFromSuperview];
        }
        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row];
        view.tag = 1000;
        [cell.contentView addSubview:view];

    return cell;
    
}


@end
