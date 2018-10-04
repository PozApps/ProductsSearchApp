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

@interface SearchTableViewController () <UITableViewDataSource , UITableViewDelegate>

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ServerManager *serverManager = [ServerManager sharedInstance];
    
    self.productsArray = [[NSArray alloc] init];
    
    [serverManager getProducts:@"apple" withCompletionBlock:^(NSArray *products) {
        
        self.productsArray = products;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[self tableView] reloadData];
        });
    }];
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

@end
