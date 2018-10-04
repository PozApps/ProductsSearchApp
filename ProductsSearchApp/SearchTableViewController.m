//
//  SearchTableViewController.m
//  ProductsSearchApp
//
//  Created by Nadav Pozmantir on 03/10/2018.
//  Copyright © 2018 Nadav Pozmantir. All rights reserved.
//

#import "SearchTableViewController.h"
#import "Product.h"
#import "ProductTableViewCell.h"
#import "ServerManager.h"

@interface SearchTableViewController () <UITableViewDataSource , UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic) UISearchBar *searchBar;

@end

NSString * const kDefaultSearch = @"apple";

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.productsArray = [[NSArray alloc] init];
    [self searchProducts:kDefaultSearch];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.text = kDefaultSearch;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.productsArray count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell" forIndexPath:indexPath];
 
     Product *product = [self.productsArray objectAtIndex:indexPath.row];
     [[cell productImageView] setImage:[UIImage imageNamed:@"product"]];
     [[cell descTextView] setText:[product desc]];
     [[cell priceLabel] setText:[NSString stringWithFormat:@"%f",[[product regularPrice] doubleValue]]];
     [[cell ratingLabel] setText:[NSString stringWithFormat:@"%f",[[product rating] doubleValue]]];
     
 
     return cell;
 }

#pragma mark - Table view delegate
// I added the search bar programmatically in order to attach it to the tableview header to make it stick to the top.
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.searchBar;
}

#pragma mark - Search bar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchProducts:searchBar.text];
}

#pragma mark - Other methods
- (void)searchProducts:(NSString *)queryStr {
    ServerManager *serverManager = [ServerManager sharedInstance];

    [serverManager getProducts:queryStr withCompletionBlock:^(NSArray *products) {
        
        self.productsArray = products;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[self tableView] reloadData];
        });
    }];
}

@end
