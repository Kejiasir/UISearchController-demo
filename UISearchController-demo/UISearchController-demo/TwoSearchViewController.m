//
//  TwoSearchViewController.m
//  UISearchController-demo
//
//  Created by Arvin on 16/10/20.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "TwoSearchViewController.h"
#import "SearchResultViewController.h"
#import "TestViewController.h"

@interface TwoSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, SearchResultViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation TwoSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二种搜索样式";
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Back"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(backBtnClick)];
    [self tableView];
    [self.tableView setTableHeaderView:({
        UISearchBar *searcgBar = self.searchController.searchBar;
        [searcgBar sizeToFit];
        searcgBar;
    })];
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self updateFilteredContent:searchController.searchBar.text];
    if (searchController.searchResultsController) {
        SearchResultViewController *searchResultControl = (SearchResultViewController *)searchController.searchResultsController;
        searchResultControl.searchResults = self.searchResults;
        [searchResultControl.tableView reloadData];
    }
}

- (void)updateFilteredContent:(NSString *)searchString {
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",searchString];
    if (self.searchResults) {
        [self.searchResults removeAllObjects];
    }
    NSArray *searchArr = [self.sourceArray filteredArrayUsingPredicate:preicate];
    self.searchResults = [NSMutableArray arrayWithArray:searchArr];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - SearchResultViewControllerDelegate
- (void)didSelectedIndexPath:(NSIndexPath *)indexPath {
    TestViewController *testVC = [[TestViewController alloc] init]; 
    [self.navigationController pushViewController:testVC animated:YES];
}

#pragma mark -
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
        SearchResultViewController *searchResultControl = [[SearchResultViewController alloc] init];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultControl];
        _searchController.delegate = self;
        searchResultControl.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = YES;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder = @"搜索";
        // 不设置下面这个属性的话会有问题
        self.definesPresentationContext = YES;
        //_searchController.searchBar.barTintColor = [UIColor orangeColor];
        //_searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
    return _searchController;
}

@end

