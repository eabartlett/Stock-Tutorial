//
//  StockModel.swift
//  Stocks
//
//  Created by Jim Kubicek on 6/10/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import UIKit

let sharedStockModel = StockModel()

struct StockModel {

    let symbols = ["TWTR", "AAPL"]

    func fetchInfoForSymbol(symbol: String, handler: (info: Dictionary<String,Int>?, error: NSError?) -> ()) {

        let urlString = "http://dev.markitondemand.com/Api/v2/Quote/json?symbol=\(symbol)"
        let url = NSURL.URLWithString(urlString)


        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) {
            (data, response, error) in
            var jsonError: NSError?
            let opt = NSJSONReadingOptions(0)
            let json = NSJSONSerialization.JSONObjectWithData(data, options: opt, error: &jsonError) as? Dictionary<String,Int>
            handler(info: json, error: jsonError)
        }
        task.resume()
    }
}
