//
//  StockModel.swift
//  Stocks
//
//  Created by Jim Kubicek on 6/10/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import UIKit

struct StockModel {

    let symbols = ["TWTR", "AAPL"]

    static var sharedInstance: StockModel {
    get {
        struct Static {
            static var instance : StockModel? = nil
            static var token : dispatch_once_t = 0
        }

        dispatch_once(&Static.token) {
            Static.instance = StockModel()
            println("Hello!")
        }

        return Static.instance!
    }
    }


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
