//
//  NetInterface.h
//  NetConnectPro
//
//  Created by Liu Lantao on 13-4-15.
//  Copyright (c) 2013年 Liu Lantao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNSUtils : NSObject

//+ (NSString *) send_query:(NSString *)domain_name;
+ (NSMutableArray *) send_query:(NSString *)domain_name ns:(NSString *)nameserver;
+ (NSMutableArray *) send_query:(NSString *)domain_name;
+ (NSMutableArray *) getDNSServers;

@end