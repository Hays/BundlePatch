//
//  MainViewController.m
//  BundleSeparate
//
//  Created by Hays on 27/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "MainViewController.h"
#import "RNFuncViewController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
  
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview: tableView];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  switch (indexPath.row) {
    case 0:
    {
      tableViewCell.textLabel.text = @"Origin App";
    }
      break;
    case 1:
    {
      tableViewCell.textLabel.text = @"Hello World";
    }
      break;
    default:
      break;
  }
  return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.row) {
    case 0:
    {
      RNFuncViewController *vc = [[RNFuncViewController alloc] initWithModuleNamne:@"BundleSeparate" patchName:@"business1"];
      [self.navigationController pushViewController:vc animated:YES];
    }
      break;
    case 1:
    {
      RNFuncViewController *vc = [[RNFuncViewController alloc] initWithModuleNamne:@"hello" patchName:@"business2"];
      [self.navigationController pushViewController:vc animated:YES];
    }
      break;
    default:
      break;
  }
  
}

@end
