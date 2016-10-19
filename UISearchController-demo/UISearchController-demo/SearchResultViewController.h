//
//  SearchResultViewController.h
//  UISearchController-demo
//
//  Created by Arvin on 16/10/19.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchResultViewController;
@protocol SearchResultViewControllerDelegate <NSObject>
@optional
- (void)didSelectedIndexPath:(NSIndexPath *)indexPath;
@end

@interface SearchResultViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *searchResults;

@property (nonatomic, weak) id<SearchResultViewControllerDelegate> delegate;
@end
