//
//  StockModel.h
//  Stocks
//
//  Created by Jonathan Wight on 6/10/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockModel : NSObject

@property (readonly, nonatomic, copy) NSArray *symbols;

+ (instancetype)sharedInstance;

/// Note handler could be invoked from any queue
- (void)fetchInfoForSymbol:(NSString *)inSymbol handler:(void (^)(NSDictionary *info, NSError *error))inHandler;

@end
