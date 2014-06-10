//
//  SymbolsTableViewController.m
//  Stocks
//
//  Created by Jonathan Wight on 6/9/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

#import "SymbolsTableViewController.h"

#import "SymbolViewController.h"
#import "StockModel.h"

@interface SymbolsTableViewController ()
@property (readwrite, nonatomic, copy) NSArray *symbols;
@end

@implementation SymbolsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.symbols = [StockModel sharedInstance].symbols;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.symbols.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    cell.textLabel.text = self.symbols[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *symbol = self.symbols[indexPath.row];

    SymbolViewController *theViewController = segue.destinationViewController;
    theViewController.symbol = symbol;

}

@end
