//
//  SomeModel.m
//  Realm-AFNetworking-Crash
//
//  Created by Ryan Copley on 5/9/15.
//  Copyright (c) 2015 Ryan Copley. All rights reserved.
//

#import "Foo.h"
#import <AFNetworking/AFNetworking.h>

@implementation Foo

+ (NSDictionary *)defaultPropertyValues
{
    return @{
             @"bar" : @"baz"
             };
}

-(void)auth {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"some-broken-url" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Weakly referencing `self` doesn't work either.
        self.bar = [responseObject objectForKey:@"something"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
