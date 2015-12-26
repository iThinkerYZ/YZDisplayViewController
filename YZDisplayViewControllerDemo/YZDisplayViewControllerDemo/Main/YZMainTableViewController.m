//
//  YZMainTableViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/26.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "YZMainTableViewController.h"

@interface YZMainTableViewController ()

@property (strong, nonatomic) NSArray *demos;

@end

@implementation YZMainTableViewController

#pragma mark - 懒加载
- (NSArray *)demos {
    if (_demos == nil) {
        _demos = @[@"腾讯",@"今日头条", @"网易",@"喜马拉雅"];
    }
    
    return _demos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - tableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.demos[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
          case 0:{
            
            [self performSegueWithIdentifier:@"YZTXViewController" sender:nil];
            
            break;
        } case 1:{
            [self performSegueWithIdentifier:@"YZJRViewController" sender:nil];
            
            break;
        } case 2:{
            [self performSegueWithIdentifier:@"YZWYViewController" sender:nil];
            
            break;
        } case 3:{
            [self performSegueWithIdentifier:@"YZXiMaViewController" sender:nil];
            
            break;
        }
            
    }
}



@end