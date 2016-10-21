//
//  TestViewController.m
//  UISearchController-demo
//
//  Created by Arvin on 16/10/18.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "TestViewController.h"
#import "CustomSearchBarViewController.h"
#import "SearchResultViewController.h"

#define RGB(r,g,b) \
[UIColor colorWithRed:(r)/256.f green:(g)/256.f blue:(b)/256.f alpha:1]

@interface YYTextField : UITextField

@end

@implementation YYTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect leftIcon = [super leftViewRectForBounds:bounds];
    leftIcon.origin.x += 10;
    return leftIcon;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    [super textRectForBounds:bounds];
    return CGRectInset(bounds, 32, 0);
    
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    [super editingRectForBounds:bounds];
    return CGRectInset(bounds, 32, 0);
}

@end

@interface TestViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // NSLog(@"%@",self.navigationController.viewControllers);
#ifdef __IPHONE_7_0
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
        //tableView.backgroundColor = [UIColor redColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 60;
        tableView;
    })];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self isCustomSearchBarVC]) {
        [self.navigationController setNavigationBarHidden:YES];
        [self.view addSubview:({
            UIView *navigationView = [[UIView alloc] init];
            navigationView.frame = (CGRect){0, 0, self.view.frame.size.width, 64};
            navigationView.backgroundColor = [UIColor whiteColor];
            YYTextField *textField = [[YYTextField alloc] init];
            UIButton *cancelButton = [[UIButton alloc] init];
            UIView *lineView = [[UIView alloc] init];
            UIImageView *searchImage = [[UIImageView alloc] init];
            [navigationView addSubview:({
                textField.delegate = self;
                textField.backgroundColor = RGB(234, 235, 237);
                textField.frame = (CGRect){10, 27, navigationView.frame.size.width - 80, 28};
                textField.placeholder = @"大家都在搜: 从你的全世界路过";
                textField.font = [UIFont systemFontOfSize:14];
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.layer.cornerRadius = CGRectGetHeight(textField.frame)/5.f;
                textField.layer.masksToBounds = YES;
                [textField becomeFirstResponder];
                textField.returnKeyType = UIReturnKeySearch;
                textField.enablesReturnKeyAutomatically = YES;
                //textField.borderStyle = UITextBorderStyleRoundedRect;
                searchImage.frame = (CGRect){10, 7, 14, 14};
                searchImage.image = [UIImage imageNamed:@"searchImg"];
                textField.leftView = searchImage;
                textField.leftViewMode = UITextFieldViewModeAlways;
                textField;
            })];
            [navigationView addSubview:({
                cancelButton.frame = (CGRect){CGRectGetMaxX(textField.frame) + 5,
                    27, navigationView.frame.size.width - textField.frame.size.width - 25, 28};
                cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
                [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
                [cancelButton setTitleColor:RGB(21, 124, 246) forState:UIControlStateNormal];
                [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                cancelButton;
            })];
            [navigationView addSubview:({
                lineView.backgroundColor = [UIColor lightGrayColor];
                lineView.frame = (CGRect){0, 64, navigationView.frame.size.width, 0.5};
                lineView;
            })];
            navigationView;
        })];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self isCustomSearchBarVC]) {
        [self.navigationController setNavigationBarHidden:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self isCustomSearchBarVC]) {
        [self.navigationController setNavigationBarHidden:NO];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([self isCustomSearchBarVC]) {
        [self.navigationController setNavigationBarHidden:NO];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"--%zd--",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (BOOL)isCustomSearchBarVC {
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (UIViewController *vc in viewControllers) {
        if ([vc isKindOfClass:[CustomSearchBarViewController class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)cancelButtonClick:(UIButton *)cancelButton {
    [self.view endEditing:YES];
    CAAnimation *cancelAnimation = [self transitionDuration:.25f Type:kCATransitionFade subType:nil];
    [self.navigationController.view.layer addAnimation:cancelAnimation forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (CAAnimation *)transitionDuration:(CFTimeInterval)duration Type:(NSString *)animation subType:(NSString *)subType {
    CATransition *transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.type = animation;
    //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    transition.subtype = subType;
    return transition;
}

@end
