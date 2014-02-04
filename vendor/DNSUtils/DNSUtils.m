//
//  DNSUtils.m
//  DNSUtils
//
//  Created by Liu Lantao on 14-2-4.
//  Copyright (c) 2014年 Liu Lantao. All rights reserved.
//

#import "DNSUtils.h"

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <ifaddrs.h>
#include <resolv.h>
#include <dns.h>

@implementation DNSUtils

+ (NSMutableArray *) send_query:(NSString *)domain_name ns:(NSString *)nameserver {
	NSMutableArray *myColors;

	myColors = [NSMutableArray arrayWithObjects: @"Red", @"Green", @"Blue", @"Yellow", nil];

	return myColors;
}

+ (NSMutableArray *) send_query:(NSString *)domain_name {
	NSMutableArray *servers;
	servers = [NSMutableArray arrayWithObjects:nil];

	int i;
	struct hostent *he;
	struct in_addr **addr_list;

	if ((he = gethostbyname2([domain_name cStringUsingEncoding:NSUTF8StringEncoding], AF_INET)) == NULL) {  // get the host info
		printf("resolve get null\n");
		return NULL;
	}
	//printf("Official name is: %s\n", he->h_name);
	//printf("    IP addresses: ");
	addr_list = (struct in_addr **)he->h_addr_list;
	for(i = 0; addr_list[i] != NULL; i++) {
		NSString *server_addr = [NSString stringWithUTF8String:inet_ntoa(*addr_list[i])];
		[servers addObject:server_addr];
		//	printf("%s ", inet_ntoa(*addr_list[i]));
	}
	//printf("\n");

	return servers;
}

+ (NSMutableArray *) getDNSServers {
    NSMutableArray *addresses = [NSMutableArray arrayWithObjects:nil];

    res_state res = malloc(sizeof(struct __res_state));

    int result = res_ninit(res);

    if ( result == 0 )
    {
        for ( int i = 0; i < res->nscount; i++ )
        {
            NSString *s = [NSString stringWithUTF8String :  inet_ntoa(res->nsaddr_list[i].sin_addr)];
            [addresses addObject:s];
        }
    }

    return addresses;
    }
@end