//
//  SymbolViewController.swift
//  Stocks
//
//  Created by Jim Kubicek on 6/10/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import UIKit

class SymbolViewController: UIViewController {

    var symbol: String? {
    didSet {
        title = symbol
    }}
    
    var stockInfo: NSDictionary?

    @IBOutlet var priceLabel: UILabel?
    @IBOutlet var openClosePriceLabel: UILabel?


    override func viewDidLoad() {

        super.viewDidLoad()
        title = symbol

        StockModel.sharedInstance().fetchInfoForSymbol(symbol) {
            (info: NSDictionary?, error) in

            dispatch_async(dispatch_get_main_queue()) {
                self.stockInfo = info
                let numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = .CurrencyStyle
                if let label = self.priceLabel {
                    let lastPrice = (info?.objectForKey("LastPrice") as NSNumber)
                    label.text = numberFormatter.stringFromNumber(lastPrice)
                }
                if let label = self.openClosePriceLabel {
                    let open = (info?.objectForKey("Open") as NSNumber)
                    label.text = "Open: \(numberFormatter.stringFromNumber(open))"
                }
            }

        }
    }
}
