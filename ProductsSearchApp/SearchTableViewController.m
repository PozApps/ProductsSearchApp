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
@property (nonatomic) NSNumberFormatter *priceNumberFormatter;
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
    
    self.priceNumberFormatter = [[NSNumberFormatter alloc] init];
    [self.priceNumberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [self.priceNumberFormatter setMaximumFractionDigits:2];
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
     
     NSString *origDesc = [product desc];
     [[cell descLabel] setText:[origDesc stringByReplacingOccurrencesOfString: @"<br/>" withString: @"\n"]];
     
     if ([product rating]) {
         [[cell ratingLabel] setText:[NSString stringWithFormat:@"%.1f",[[product rating] doubleValue]]];
         [[cell ratingLabel] setHidden:NO];
     } else {
         [[cell ratingLabel] setText:@""];
         [[cell ratingLabel] setHidden:YES];
    }
     
     if ([[product regularPrice] isEqualToNumber:[product price]]) {
         [[cell regularPriceLabel] setText:@""];
         [[cell regularPriceLabel] setHidden:YES];
     } else {
         NSString *regularPrice = [self.priceNumberFormatter stringFromNumber:[product regularPrice]];
         NSMutableAttributedString *regularPriceStrikeThrough = [[NSMutableAttributedString alloc] initWithString:regularPrice];
         [regularPriceStrikeThrough addAttribute:NSStrikethroughStyleAttributeName
                                 value:@1
                                 range:NSMakeRange(0, [regularPriceStrikeThrough length])];
         [[cell regularPriceLabel] setAttributedText:regularPriceStrikeThrough];
         [[cell regularPriceLabel] setHidden:NO];
     }
          
     [[cell priceLabel] setText:[self.priceNumberFormatter stringFromNumber:[product price]]];
     
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
