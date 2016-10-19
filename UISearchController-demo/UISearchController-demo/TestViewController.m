//
//  TestViewController.m
//  UISearchController-demo
//
//  Created by Arvin on 16/10/18.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tableView];
    [self.tableView setTableHeaderView:({
        UISearchBar *searcgBar = self.searchController.searchBar;
        searcgBar;
    })];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.sourceArray[indexPath.row];
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = @[@"sdgg",@"gdh",@"fse",@"jyjj",@"5ujd"].copy;
    }
    return _sourceArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.rowHeight = 60;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        self.tableView = tableView;
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *views = NSDictionaryOfVariableBindings(tableView);
        NSString *width = @"H:|-0-[tableView]-0-|", *height = @"V:|-0-[tableView]-0-|";
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:width options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:height options:0 metrics:nil views:views]];
    }
    return _tableView;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = YES;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder = @"大家都在搜";
    }
    return _searchController;
}
@end
