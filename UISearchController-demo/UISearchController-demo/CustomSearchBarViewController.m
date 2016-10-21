//
//  CustomSearchBarViewController.m
//  UISearchController-demo
//
//  Created by Arvin on 16/10/21.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "CustomSearchBarViewController.h"
#import "TestViewController.h"
#import "SearchResultViewController.h"

#define RGB(r,g,b) \
[UIColor colorWithRed:(r)/256.f green:(g)/256.f blue:(b)/256.f alpha:1]

@interface CustomSearchBarViewController ()<UISearchBarDelegate>

@end

@implementation CustomSearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义搜索框";
    self.tableView.rowHeight = 60;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Back"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(backBtnClick)];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView setTableHeaderView: ({
//        UISearchBar *searchBar = [[UISearchBar alloc] init];
//        searchBar.backgroundColor = [UIColor orangeColor];
//        searchBar.frame = (CGRect){0, 0, self.view.frame.size.width, 44};
//        searchBar.placeholder = @"搜索";
//        searchBar.delegate = self;
//        [searchBar canResignFirstResponder];
//        searchBar; 
        UIView *searchBarView = [[UIView alloc] init];
        searchBarView.backgroundColor = RGB(201, 201, 206);
        searchBarView.frame = (CGRect){0, 0, self.view.frame.size.width, 44};
        [searchBarView addSubview:({
            UIButton *searchButton = [[UIButton alloc] init];
            searchButton.backgroundColor = [UIColor whiteColor];
            searchButton.frame = (CGRect){10, 8, searchBarView.frame.size.width - 20, 28};
            searchButton.layer.cornerRadius = CGRectGetHeight(searchButton.frame)/5.f;
            searchButton.layer.masksToBounds = YES;
            [searchButton addTarget:self
                             action:@selector(searchButtonClick:)
                   forControlEvents:UIControlEventTouchUpInside];
            [searchButton addSubview:({
                UIImageView *searchImage = [[UIImageView alloc] init];
                searchImage.image = [UIImage imageNamed:@"searchImg"];
                searchImage.frame = (CGRect){10, 7, 14, 14};
                searchImage;
            })];
            [searchButton addSubview:({
                UILabel *placeholderLabel = [[UILabel alloc] init];
                placeholderLabel.text = @"大家都在搜: 从你的全世界路过";
                placeholderLabel.textColor = RGB(142, 142, 147);
                placeholderLabel.textAlignment = NSTextAlignmentLeft;
                placeholderLabel.font = [UIFont systemFontOfSize:14]; 
                placeholderLabel.frame = (CGRect){32, 6, searchButton.frame.size.width - 42, 16};
                placeholderLabel;
            })];
            searchButton;
        })];
        searchBarView;
    })];
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchButtonClick:(UIButton *)searchButton {
    TestViewController *testViewControl = [[TestViewController alloc] init];
    CATransition *transition = [CATransition animation];
    transition.duration = .25f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionFade; 
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:testViewControl animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
