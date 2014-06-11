//
//  SymbolsTableViewController.swift
//  Stocks
//
//  Created by Jim Kubicek on 6/10/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import UIKit

class SymbolsTableViewController: UITableViewController {

    let symbols = StockModel.sharedInstance().symbols as String[]

    // UIViewController

    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {

        let cell = sender as UITableViewCell
        let indexPath = self.tableView.indexPathForCell(cell)
        let symbol = symbols[indexPath.row]

        let vc = segue.destinationViewController as SymbolViewController
        vc.symbol = symbol
    }

}

extension SymbolsTableViewController { // UITableViewDataSource

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {

        return symbols.count

    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {

        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = self.symbols[indexPath.row]
        return cell

    }

}




