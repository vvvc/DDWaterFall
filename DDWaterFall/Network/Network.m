//
//  Network.m
//  XHLaunchAdExample
//
//  Created by zhuxiaohui on 2016/6/28.
//  Copyright © 2016年 it7090.com. All rights reserved.
//  数据请求类
#import "Network.h"

@implementation Network

+(void)getNetworkDataSuccess:(NetworkSucess)success failure:(NetworkFailure)failure {
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"]];
    NSDictionary *json =  [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    if(success) success(json);
}

@end
