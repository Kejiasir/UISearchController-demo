//
//  ViewController.m
//  UISearchController-demo
//
//  Created by Arvin on 16/10/18.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBtnClick:)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    [self tableView];
    
    [self.tableView setTableHeaderView:({
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        searchBar.frame = (CGRect){0, 0, self.view.frame.size.width, 40};
        searchBar.placeholder = @"搜索";
        searchBar;
    })];
}

- (void)searchBtnClick:(UIBarButtonItem *)searchBtn {
    NSLog(@"------");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
