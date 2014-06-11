//
//  SymbolViewController.swift
//  Stocks
//
//  Created by Jim Kubicek on 6/10/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import UIKit

func µ(runOnMain: ()->()) {
    dispatch_async(dispatch_get_main_queue(), runOnMain)
}

class SymbolViewController: UIViewController {

    var symbol: String? {
    didSet {
        title = symbol
    }}
    
    var stockInfo: Dictionary<String,Int>?

    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var openClosePriceLabel: UILabel!

    override func viewDidLoad() {

        super.viewDidLoad()
        title = symbol

        if let safeSymbol = symbol {
            sharedStockModel.fetchInfoForSymbol(safeSymbol) {
                (info, error) in

                µ({
                    self.stockInfo = info
                    let numberFormatter = NSNumberFormatter()
                    numberFormatter.numberStyle = .CurrencyStyle
                    let lastPrice = info?["LastPrice"]
                    self.priceLabel.text = numberFormatter.stringFromNumber(lastPrice)
                    let open = info?["Open"]
                    self.openClosePriceLabel.text = "Open: \(numberFormatter.stringFromNumber(open))"
                })
            }
        }
    }
}
