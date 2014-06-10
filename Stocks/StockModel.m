//
//  StockModel.m
//  Stocks
//
//  Created by Jonathan Wight on 6/10/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

#import "StockModel.h"

@interface StockModel ()
@property (readwrite, nonatomic, copy) NSArray *symbols;
@end

@implementation StockModel

static id gSharedInstance = NULL;

+ (instancetype)sharedInstance
{
    static dispatch_once_t sOnceToken = 0;
    dispatch_once(&sOnceToken, ^{
        gSharedInstance = [[self alloc] init];
    });
    return(gSharedInstance);
}


- (id)init
{
    if ((self = [super init]) != NULL)
    {
        _symbols = @[ @"TWTR", @"AAPL" ];
    }
    return self;
}

- (void)fetchInfoForSymbol:(NSString *)inSymbol handler:(void (^)(NSDictionary *info, NSError *error))inHandler
{
    NSString *theURLString = [NSString stringWithFormat:@"http://dev.markitondemand.com/Api/v2/Quote/json?symbol=%@", inSymbol];
    NSURL *theURL = [NSURL URLWithString:theURLString];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:theURL];

    NSURLSessionDataTask *theTask = [[NSURLSession sharedSession] dataTaskWithRequest:theRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // Properly handling HTTP errors and bad JSON is an excercise for someone less lazy.
        NSDictionary *theJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        inHandler(theJSON, NULL);
    }];
    [theTask resume];
}

@end
