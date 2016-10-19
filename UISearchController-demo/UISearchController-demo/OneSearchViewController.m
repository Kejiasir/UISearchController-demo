//
//  OneSearchViewController.m
//  UISearchController-demo
//
//  Created by Arvin on 16/10/18.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "OneSearchViewController.h"
#import "TwoSearchViewController.h"
#import "SearchResultViewController.h"
#import "TestViewController.h"

@interface OneSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, SearchResultViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation OneSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第一种搜索样式";
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBtnClick:)];
    [self tableView];
//    [self.tableView setTableHeaderView:({
//        UIView *headerView = [[UIView alloc] init];
//        headerView.backgroundColor = [UIColor brownColor];
//        headerView.frame = (CGRect){0, 0, self.view.frame.size.width, 44};
//        headerView;
//    })];
}

- (void)searchBtnClick:(UIBarButtonItem *)searchBtn {
    // 如果 SearchResultsController 设置为nil表示使用当前控制器为result控制器
    SearchResultViewController *searchResultController = [[SearchResultViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultController];
    _searchController.delegate = self;
    searchResultController.delegate = self;
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = YES;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.placeholder = @"大家都在搜";
    [_searchController.searchBar sizeToFit];
    [self presentViewController:_searchController animated:YES completion:nil];
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
    // 谓词中SELF代表被查询的集合
    // BEGINSWITH：检查某个字符串是否以另一个字符串开头。
    // ENDSWITH：检查某个字符串是否以另一个字符串结尾。
    // CONTAINS：检查某个字符串是否在另一个字符串内部。
    // [c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",searchString];
    // 在查询结果之前先清空数组
    if (self.searchResults) {
        [self.searchResults removeAllObjects];
    }
    // 生成查询结果数组
    NSArray *searchArr = [self.sourceArray filteredArrayUsingPredicate:preicate];
    self.searchResults = [NSMutableArray arrayWithArray:searchArr];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - UISearchControllerDelegate
// 当发生自动显示或关闭时，将调用这些方法。 如果您自己显示或关闭搜索控制器，则不会调用它们。
- (void)willPresentSearchController:(UISearchController *)searchController {
    NSLog(@"willPresentSearchController");
}
- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"willDismissSearchController");
}
- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"didDismissSearchController");
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
    return /*self.searchController.active ? [self.searchResults count] : */[self.sourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
//    if (self.searchController.active) {
//        cell.textLabel.text = self.searchResults[indexPath.row];
//    } else {
    cell.textLabel.text = self.sourceArray[indexPath.row];
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (self.searchController.active) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
    TwoSearchViewController *twoSearchViewControl = [[TwoSearchViewController alloc] init];
    twoSearchViewControl.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:twoSearchViewControl animated:YES];
}


#pragma mark - SearchResultViewControllerDelegate
- (void)didSelectedIndexPath:(NSIndexPath *)indexPath {
    if (self.searchController.active) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    TestViewController *testVC = [[TestViewController alloc] init];
    testVC.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:testVC animated:YES];
}

#pragma mark -
- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray array];
        NSMutableArray *array = @[@"rssg",@"eywe",@"gfh",@"tjj",@"lewy",@"yi",@"et",@"ewt",@"lo",@"asfg",@"eyu",@"7ty",@"reyu",@"25es",@"t3u",@"yj76",@"uir",@"3th",@"7tb",@"3tey",@"5ubet",@"1e1u",@"ruvv",@"jke",@"8hl",@"0fss",@"rwr",@"ery",@"fjeb",@"wty",@"locc",@"hre4"].copy;
        for (int i = 0; i < 50; i++) {
            uint32_t index = arc4random_uniform((u_int32_t)array.count);
            NSString *str = [array objectAtIndex:index];
            [_sourceArray addObject:[[NSString stringWithFormat:@"%@%d",str,i] stringByAppendingString:str]];
        }
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
        NSString *horizontal = @"H:|-0-[tableView]-0-|", *vertical = @"V:|-0-[tableView]-0-|";
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontal options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vertical options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    }
    return _tableView;
}

@end
